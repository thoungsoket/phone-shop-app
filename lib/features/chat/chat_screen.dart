import 'package:flutter/material.dart';

import '../common/phonehub_ui.dart';
import '../common/phonehub_store.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  bool supportTyping = false;

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 120), () {
      if (!scrollController.hasClients) return;
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOut,
      );
    });
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    PhoneHubStore.instance.addMessage(text);
    controller.clear();
    _scrollToBottom();

    setState(() => supportTyping = true);

    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      setState(() => supportTyping = false);
      _scrollToBottom();
    });
  }

  void _sendRepairStatus() {
    final bookings = PhoneHubStore.instance.bookings;

    if (bookings.isEmpty) {
      _sendMessage('I want to track my repair.');
      return;
    }

    final latest = bookings.first;

    _sendMessage(
      'Track my repair: ${latest.service}, Ticket ${latest.id}, ${latest.status}, ${(latest.progress * 100).round()}% completed.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: PhoneHubStore.instance,
      builder: (context, _) {
        final messages = PhoneHubStore.instance.messages;

        return PhoneHubPageShell(
          child: Column(
            children: [
              _ChatHeader(
                onBack: () => Navigator.maybePop(context),
                onCall: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Calling PhoneHub Support...')),
                  );
                },
              ),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(18, 18, 18, 12),
                  itemCount: messages.length + (supportTyping ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (supportTyping && index == messages.length) {
                      return const _TypingBubble();
                    }

                    return _MessageBubble(message: messages[index]);
                  },
                ),
              ),
              _QuickReplies(
                onTrack: _sendRepairStatus,
                onPayment: () => _sendMessage('I need help with payment.'),
                onStore: () => _sendMessage('Can I contact the store?'),
              ),
              _MessageInput(
                controller: controller,
                onSend: () => _sendMessage(controller.text),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ChatHeader extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onCall;

  const _ChatHeader({
    required this.onBack,
    required this.onCall,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 14, 12, 14),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            offset: Offset(0, 4),
            color: Color(0x11000000),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [PhoneHubColors.blue, PhoneHubColors.cyan],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.support_agent_rounded,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PhoneHub Support',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 17,
                    color: PhoneHubColors.textDark,
                  ),
                ),
                SizedBox(height: 3),
                Row(
                  children: [
                    Icon(Icons.circle, color: Color(0xFF16A34A), size: 9),
                    SizedBox(width: 6),
                    Text(
                      'Online now',
                      style: TextStyle(
                        color: PhoneHubColors.textGray,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onCall,
            icon: const Icon(
              Icons.call_rounded,
              color: PhoneHubColors.blue,
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const _MessageBubble({
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final isMe = message.me;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * .76,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          gradient: isMe
              ? const LinearGradient(
                  colors: [PhoneHubColors.blue, PhoneHubColors.cyan],
                )
              : null,
          color: isMe ? null : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(isMe ? 18 : 4),
            bottomRight: Radius.circular(isMe ? 4 : 18),
          ),
          border: isMe ? null : Border.all(color: PhoneHubColors.border),
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: TextStyle(
                color: isMe ? Colors.white : PhoneHubColors.textDark,
                height: 1.35,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              message.time,
              style: TextStyle(
                color: isMe ? Colors.white70 : PhoneHubColors.textGray,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TypingBubble extends StatelessWidget {
  const _TypingBubble();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: PhoneHubColors.border),
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: PhoneHubColors.blue,
              ),
            ),
            SizedBox(width: 10),
            Text(
              'Support is typing...',
              style: TextStyle(
                color: PhoneHubColors.textGray,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickReplies extends StatelessWidget {
  final VoidCallback onTrack;
  final VoidCallback onPayment;
  final VoidCallback onStore;

  const _QuickReplies({
    required this.onTrack,
    required this.onPayment,
    required this.onStore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _QuickChip(
            icon: Icons.build_rounded,
            label: 'Track Repair',
            onTap: onTrack,
          ),
          _QuickChip(
            icon: Icons.payment_rounded,
            label: 'Payment',
            onTap: onPayment,
          ),
          _QuickChip(
            icon: Icons.storefront_rounded,
            label: 'Store',
            onTap: onStore,
          ),
        ],
      ),
    );
  }
}

class _QuickChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 9),
      child: ActionChip(
        avatar: Icon(icon, size: 18, color: PhoneHubColors.blue),
        label: Text(label),
        onPressed: onTap,
        backgroundColor: Colors.white,
        side: const BorderSide(color: PhoneHubColors.border),
        labelStyle: const TextStyle(
          color: PhoneHubColors.textDark,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _MessageInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const _MessageInput({
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            offset: Offset(0, -4),
            color: Color(0x0F000000),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Attachment UI only')),
              );
            },
            icon: const Icon(
              Icons.add_circle_outline_rounded,
              color: PhoneHubColors.blue,
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              minLines: 1,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                filled: true,
                fillColor: PhoneHubColors.softCard,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(999),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: (_) => onSend(),
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: onSend,
            borderRadius: BorderRadius.circular(999),
            child: Container(
              width: 46,
              height: 46,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [PhoneHubColors.blue, PhoneHubColors.cyan],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.send_rounded,
                color: Colors.white,
                size: 21,
              ),
            ),
          ),
        ],
      ),
    );
  }
}