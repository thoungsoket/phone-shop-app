import 'package:flutter/material.dart';

import '../common/phonehub_ui.dart';
import '../common/phonehub_store.dart';

class RepairTrackerScreen extends StatelessWidget {
  const RepairTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: PhoneHubStore.instance,
      builder: (context, _) {
        final bookings = PhoneHubStore.instance.bookings;
        final latest = bookings.isNotEmpty ? bookings.first : null;

        return PhoneHubPageShell(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.maybePop(context),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  const SizedBox(width: 4),
                  const Expanded(
                    child: Text(
                      'Repair Tracker',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: PhoneHubColors.textDark,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              if (latest == null)
                PhoneHubCard(
                  child: Column(
                    children: [
                      const Icon(
                        Icons.build_circle_outlined,
                        size: 64,
                        color: PhoneHubColors.blue,
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'No repair booking yet',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: PhoneHubColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Book a repair first, then your tracking status will appear here.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: PhoneHubColors.textGray,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 18),
                      PhoneHubGradientButton(
                        text: 'Book Repair',
                        onTap: () => Navigator.pushNamed(context, '/booking'),
                      ),
                    ],
                  ),
                )
              else ...[
                _CurrentRepairCard(booking: latest),
                const SizedBox(height: 16),
                _TimelineCard(booking: latest),
                const SizedBox(height: 16),
                _TechnicianCard(
                  onChat: () => Navigator.pushNamed(context, '/chat'),
                ),
                const SizedBox(height: 16),
                if (bookings.length > 1) _HistoryCard(bookings: bookings),
                const SizedBox(height: 16),
                PhoneHubGradientButton(
                  text: 'Contact Support',
                  onTap: () => Navigator.pushNamed(context, '/chat'),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _CurrentRepairCard extends StatelessWidget {
  final RepairBooking booking;

  const _CurrentRepairCard({required this.booking});

  @override
  Widget build(BuildContext context) {
    return PhoneHubCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            booking.device,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: PhoneHubColors.textDark,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${booking.service} • Ticket #${booking.id}',
            style: const TextStyle(
              color: PhoneHubColors.textGray,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _StatusBadge(status: booking.status),
              const Spacer(),
              Text(
                '${booking.date} • ${booking.time}',
                style: const TextStyle(
                  color: PhoneHubColors.textGray,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: booking.progress,
              minHeight: 10,
              backgroundColor: PhoneHubColors.softCard,
              valueColor: const AlwaysStoppedAnimation(PhoneHubColors.blue),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                '${(booking.progress * 100).round()}% completed',
                style: const TextStyle(
                  color: PhoneHubColors.blue,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Spacer(),
              Text(
                booking.price,
                style: const TextStyle(
                  color: PhoneHubColors.textDark,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimelineCard extends StatelessWidget {
  final RepairBooking booking;

  const _TimelineCard({required this.booking});

  @override
  Widget build(BuildContext context) {
    final progress = booking.progress;

    return PhoneHubCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Repair Timeline',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: PhoneHubColors.textDark,
            ),
          ),
          const SizedBox(height: 18),
          _TimelineItem(
            title: 'Booking Confirmed',
            subtitle: 'Your repair request has been received.',
            time: booking.date,
            done: progress >= .10,
          ),
          _TimelineItem(
            title: 'Device Check-in',
            subtitle: 'Technician will inspect your device condition.',
            time: progress >= .30 ? 'Done' : 'Pending',
            done: progress >= .30,
            active: progress >= .10 && progress < .30,
          ),
          _TimelineItem(
            title: 'Repair In Progress',
            subtitle: 'Repair work is being processed by our technician.',
            time: progress >= .65 ? 'Done' : 'Pending',
            done: progress >= .65,
            active: progress >= .30 && progress < .65,
          ),
          _TimelineItem(
            title: 'Quality Check',
            subtitle: 'Device will be tested before pickup.',
            time: progress >= .90 ? 'Done' : 'Pending',
            done: progress >= .90,
            active: progress >= .65 && progress < .90,
          ),
          _TimelineItem(
            title: 'Ready for Pickup',
            subtitle: 'You will receive a notification when it is ready.',
            time: progress >= 1 ? 'Ready' : 'Pending',
            done: progress >= 1,
            active: progress >= .90 && progress < 1,
            last: true,
          ),
        ],
      ),
    );
  }
}

class _TechnicianCard extends StatelessWidget {
  final VoidCallback onChat;

  const _TechnicianCard({required this.onChat});

  @override
  Widget build(BuildContext context) {
    return PhoneHubCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Technician',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: PhoneHubColors.textDark,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [PhoneHubColors.blue, PhoneHubColors.cyan],
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.engineering_rounded,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dara Sok',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        color: PhoneHubColors.textDark,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Senior Mobile Technician',
                      style: TextStyle(
                        color: PhoneHubColors.textGray,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onChat,
                icon: const Icon(
                  Icons.chat_bubble_rounded,
                  color: PhoneHubColors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final List<RepairBooking> bookings;

  const _HistoryCard({required this.bookings});

  @override
  Widget build(BuildContext context) {
    return PhoneHubCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Other Repairs',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: PhoneHubColors.textDark,
            ),
          ),
          const SizedBox(height: 12),
          ...bookings.skip(1).map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.build_circle_outlined,
                        color: PhoneHubColors.blue,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          '${item.service} • ${item.date}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: PhoneHubColors.textDark,
                          ),
                        ),
                      ),
                      Text(
                        item.status,
                        style: const TextStyle(
                          color: PhoneHubColors.textGray,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color = PhoneHubColors.blue;

    if (status.toLowerCase().contains('complete')) {
      color = const Color(0xFF16A34A);
    } else if (status.toLowerCase().contains('book')) {
      color = const Color(0xFFF97316);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final bool done;
  final bool active;
  final bool last;

  const _TimelineItem({
    required this.title,
    required this.subtitle,
    required this.time,
    this.done = false,
    this.active = false,
    this.last = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = done || active ? PhoneHubColors.blue : const Color(0xFFCBD5E1);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: done || active ? PhoneHubColors.blue : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: color, width: 2),
                ),
                child: done
                    ? const Icon(
                        Icons.check_rounded,
                        size: 16,
                        color: Colors.white,
                      )
                    : active
                        ? const Icon(
                            Icons.build_rounded,
                            size: 14,
                            color: Colors.white,
                          )
                        : null,
              ),
              if (!last)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: color.withOpacity(.35),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            color: PhoneHubColors.textDark,
                          ),
                        ),
                      ),
                      Text(
                        time,
                        style: const TextStyle(
                          color: PhoneHubColors.textGray,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: PhoneHubColors.textGray,
                      fontSize: 13,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}