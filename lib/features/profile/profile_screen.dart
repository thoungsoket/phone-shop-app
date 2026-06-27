import 'package:flutter/material.dart';

import '../common/phonehub_store.dart';
import '../common/phonehub_ui.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const List<_OrderModel> _orders = [
    _OrderModel(
      title: 'iPhone 16 Pro Max',
      subtitle: 'Delivered • 12 Jun 2026',
      price: '\$1,299',
      icon: Icons.phone_iphone_rounded,
    ),
    _OrderModel(
      title: 'Apple Watch Ultra',
      subtitle: 'Delivered • 29 May 2026',
      price: '\$799',
      icon: Icons.watch_rounded,
    ),
    _OrderModel(
      title: 'AirPods Pro',
      subtitle: 'Delivered • 18 May 2026',
      price: '\$249',
      icon: Icons.headphones_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: PhoneHubStore.instance,
      builder: (context, _) {
        final store = PhoneHubStore.instance;
        final latestRepair = store.bookings.isNotEmpty ? store.bookings.first : null;

        return PhoneHubPageShell(
          showBottomNav: true,
          currentIndex: 4,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
            children: [
              _ProfileHeader(store: store),
              const SizedBox(height: 16),
              _RewardCard(
                points: 540,
                target: 700,
                onTap: () => _showMembershipSheet(context),
              ),
              const SizedBox(height: 16),
              _QuickActions(),
              const SizedBox(height: 16),
              _RecentOrdersCard(
                orders: _orders,
                onViewAll: () => _showOrdersSheet(context, _orders),
              ),
              const SizedBox(height: 16),
              _SavedItemsCard(store: store),
              const SizedBox(height: 16),
              _RepairStatusCard(booking: latestRepair),
              const SizedBox(height: 16),
              _AccountMenu(store: store),
            ],
          ),
        );
      },
    );
  }

  static void _showMembershipSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return const _PhoneHubBottomSheet(
          title: 'Membership Details',
          icon: Icons.workspace_premium_rounded,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _MembershipLevelCard(
                title: 'Premium Member',
                subtitle: '540 / 700 points to Gold',
                progress: 540 / 700,
              ),
              SizedBox(height: 14),
              _BenefitTile(
                icon: Icons.local_shipping_outlined,
                title: 'Free delivery',
                subtitle: 'Available for selected orders.',
              ),
              _BenefitTile(
                icon: Icons.build_circle_outlined,
                title: 'Repair discount',
                subtitle: 'Save up to 10% on repair services.',
              ),
              _BenefitTile(
                icon: Icons.card_giftcard_rounded,
                title: 'Reward coupons',
                subtitle: 'Redeem points for coupons and accessories.',
              ),
            ],
          ),
        );
      },
    );
  }

  static void _showOrdersSheet(BuildContext context, List<_OrderModel> orders) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return _PhoneHubBottomSheet(
          title: 'Order History',
          icon: Icons.receipt_long_rounded,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: orders
                .map(
                  (order) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _OrderTile(order: order),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final PhoneHubStore store;

  const _ProfileHeader({required this.store});

  static const List<IconData> _avatars = [
    Icons.person_rounded,
    Icons.face_rounded,
    Icons.account_circle_rounded,
    Icons.sentiment_satisfied_alt_rounded,
    Icons.emoji_emotions_rounded,
    Icons.support_agent_rounded,
  ];

  IconData _avatarIcon(int index) {
    if (index < 0 || index >= _avatars.length) return Icons.person_rounded;
    return _avatars[index];
  }

  void _showAvatarPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return AnimatedBuilder(
          animation: PhoneHubStore.instance,
          builder: (context, _) {
            return _PhoneHubBottomSheet(
              title: 'Choose Avatar',
              icon: Icons.camera_alt_rounded,
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: _avatars.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                ),
                itemBuilder: (context, index) {
                  final selected = PhoneHubStore.instance.avatarIndex == index;

                  return InkWell(
                    borderRadius: BorderRadius.circular(22),
                    onTap: () {
                      PhoneHubStore.instance.updateAvatar(index);
                      Navigator.pop(context);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      decoration: BoxDecoration(
                        gradient: selected
                            ? const LinearGradient(
                                colors: [PhoneHubColors.blue, PhoneHubColors.cyan],
                              )
                            : null,
                        color: selected ? null : PhoneHubColors.softCard,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: selected ? Colors.transparent : PhoneHubColors.border,
                        ),
                      ),
                      child: Icon(
                        _avatars[index],
                        color: selected ? Colors.white : PhoneHubColors.blue,
                        size: 42,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PhoneHubCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 104,
                height: 104,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [PhoneHubColors.blue, PhoneHubColors.cyan],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: PhoneHubColors.blue.withOpacity(.22),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Icon(
                  _avatarIcon(store.avatarIndex),
                  color: Colors.white,
                  size: 58,
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: InkWell(
                  borderRadius: BorderRadius.circular(999),
                  onTap: () => _showAvatarPicker(context),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: PhoneHubColors.border),
                    ),
                    child: const Icon(
                      Icons.camera_alt_rounded,
                      color: PhoneHubColors.blue,
                      size: 19,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            store.fullName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: PhoneHubColors.textDark,
              fontSize: 23,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            store.email,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: PhoneHubColors.textGray,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [PhoneHubColors.blue, PhoneHubColors.cyan],
              ),
              borderRadius: BorderRadius.circular(999),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.workspace_premium_rounded, color: Colors.white, size: 15),
                SizedBox(width: 6),
                Text(
                  'Premium Member',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          PhoneHubGradientButton(
            text: 'Edit Profile',
            onTap: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
    );
  }
}

class _RewardCard extends StatelessWidget {
  final int points;
  final int target;
  final VoidCallback onTap;

  const _RewardCard({
    required this.points,
    required this.target,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final progress = points / target;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: PhoneHubCard(
        padding: EdgeInsets.zero,
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: [Color(0xFF0F172A), PhoneHubColors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.card_giftcard_rounded, color: Colors.white, size: 24),
                  const SizedBox(width: 10),
                  const Text(
                    'Reward Points',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '$points',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Earn ${target - points} more points to reach Gold Membership.',
                style: const TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 14),
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 9,
                  backgroundColor: Colors.white24,
                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PhoneHubCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(title: 'Quick Actions', actionText: ''),
          const SizedBox(height: 14),
          Row(
            children: [
              _QuickActionButton(
                icon: Icons.build_circle_outlined,
                title: 'Book Repair',
                onTap: () => Navigator.pushNamed(context, '/booking'),
              ),
              const SizedBox(width: 10),
              _QuickActionButton(
                icon: Icons.timeline_rounded,
                title: 'Track',
                onTap: () => Navigator.pushNamed(context, '/repair-tracker'),
              ),
              const SizedBox(width: 10),
              _QuickActionButton(
                icon: Icons.chat_bubble_outline_rounded,
                title: 'Support',
                onTap: () => Navigator.pushNamed(context, '/chat'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          height: 86,
          decoration: BoxDecoration(
            color: PhoneHubColors.softCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: PhoneHubColors.border),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: PhoneHubColors.blue, size: 28),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: PhoneHubColors.textDark,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecentOrdersCard extends StatelessWidget {
  final List<_OrderModel> orders;
  final VoidCallback onViewAll;

  const _RecentOrdersCard({
    required this.orders,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return PhoneHubCard(
      child: Column(
        children: [
          _SectionHeader(
            title: 'Recent Orders',
            actionText: 'View All',
            onTap: onViewAll,
          ),
          const SizedBox(height: 14),
          ...orders.take(2).map(
                (order) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _OrderTile(order: order),
                ),
              ),
        ],
      ),
    );
  }
}

class _SavedItemsCard extends StatelessWidget {
  final PhoneHubStore store;

  const _SavedItemsCard({required this.store});

  @override
  Widget build(BuildContext context) {
    return PhoneHubCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            title: 'Saved Photos',
            actionText: 'Gallery',
            onTap: () => Navigator.pushNamed(context, '/gallery'),
          ),
          const SizedBox(height: 14),
          if (store.favoriteGallery.isEmpty)
            Container(
              height: 130,
              decoration: BoxDecoration(
                color: PhoneHubColors.softCard,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Center(
                child: Text(
                  'No favourite photos yet.',
                  style: TextStyle(
                    color: PhoneHubColors.textGray,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            )
          else
            Column(
              children: store.favoriteGallery
                  .take(4)
                  .map(
                    (item) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const CircleAvatar(
                        backgroundColor: PhoneHubColors.softCard,
                        child: Icon(Icons.favorite, color: Colors.red),
                      ),
                      title: Text(
                        item,
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () => Navigator.pushNamed(context, '/gallery'),
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }
}

class _RepairStatusCard extends StatelessWidget {
  final RepairBooking? booking;

  const _RepairStatusCard({required this.booking});

  @override
  Widget build(BuildContext context) {
    return PhoneHubCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            title: 'Repair Status',
            actionText: 'Tracker',
            onTap: () => Navigator.pushNamed(context, '/repair-tracker'),
          ),
          const SizedBox(height: 14),
          if (booking == null)
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: PhoneHubColors.softCard,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  const Icon(Icons.build_circle_outlined, size: 46, color: PhoneHubColors.blue),
                  const SizedBox(height: 12),
                  const Text(
                    'No repair booking yet.',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                  ),
                  const SizedBox(height: 14),
                  PhoneHubGradientButton(
                    text: 'Book Repair',
                    onTap: () => Navigator.pushNamed(context, '/booking'),
                  ),
                ],
              ),
            )
          else
            InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () => Navigator.pushNamed(context, '/repair-tracker'),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: PhoneHubColors.softCard,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.build_circle_rounded, color: PhoneHubColors.blue),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            booking!.service,
                            style: const TextStyle(fontWeight: FontWeight.w900),
                          ),
                        ),
                        Text(
                          booking!.status,
                          style: const TextStyle(
                            color: PhoneHubColors.blue,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        value: booking!.progress,
                        minHeight: 8,
                        backgroundColor: Colors.white,
                        valueColor: const AlwaysStoppedAnimation(PhoneHubColors.blue),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          booking!.date,
                          style: const TextStyle(color: PhoneHubColors.textGray),
                        ),
                        const Spacer(),
                        Text(
                          booking!.time,
                          style: const TextStyle(color: PhoneHubColors.textGray),
                        ),
                      ],
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

class _AccountMenu extends StatelessWidget {
  final PhoneHubStore store;

  const _AccountMenu({required this.store});

  @override
  Widget build(BuildContext context) {
    return PhoneHubCard(
      child: Column(
        children: [
          _ProfileMenuTile(
            icon: Icons.person_outline_rounded,
            title: 'Account Information',
            subtitle: '${store.fullName} • ${store.phone}',
            onTap: () => Navigator.pushNamed(context, '/settings'),
          ),
          const Divider(height: 18),
          _ProfileMenuTile(
            icon: Icons.location_on_outlined,
            title: 'Shipping Address',
            subtitle: store.address,
            onTap: () => Navigator.pushNamed(context, '/settings'),
          ),
          const Divider(height: 18),
          _ProfileMenuTile(
            icon: Icons.payment_rounded,
            title: 'Payment Method',
            subtitle: store.payment,
            onTap: () => Navigator.pushNamed(context, '/settings'),
          ),
          const Divider(height: 18),
          _ProfileMenuTile(
            icon: Icons.star_outline_rounded,
            title: 'My Reviews',
            subtitle: '${store.reviewCount} reviews written',
            onTap: () => Navigator.pushNamed(context, '/reviews'),
          ),
          const Divider(height: 18),
          _ProfileMenuTile(
            icon: Icons.photo_library_outlined,
            title: 'Photos & Videos',
            subtitle: '${store.galleryFavoriteCount} saved media',
            onTap: () => Navigator.pushNamed(context, '/gallery'),
          ),
          const Divider(height: 18),
          _ProfileMenuTile(
            icon: Icons.support_agent_rounded,
            title: 'Customer Support',
            subtitle: 'Chat with PhoneHub support',
            onTap: () => Navigator.pushNamed(context, '/chat'),
          ),
        ],
      ),
    );
  }
}

class _ProfileMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ProfileMenuTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 23,
        backgroundColor: PhoneHubColors.softCard,
        child: Icon(icon, color: PhoneHubColors.blue),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: PhoneHubColors.textDark,
          fontWeight: FontWeight.w900,
          fontSize: 15,
        ),
      ),
      subtitle: Text(
        subtitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: PhoneHubColors.textGray,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.chevron_right_rounded, color: PhoneHubColors.textGray),
      onTap: onTap,
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String actionText;
  final VoidCallback? onTap;

  const _SectionHeader({
    required this.title,
    required this.actionText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: PhoneHubColors.textDark,
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
        const Spacer(),
        if (actionText.isNotEmpty)
          TextButton(
            onPressed: onTap,
            child: Text(
              actionText,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
      ],
    );
  }
}

class _OrderTile extends StatelessWidget {
  final _OrderModel order;

  const _OrderTile({required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: PhoneHubColors.softCard,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(order.icon, color: PhoneHubColors.blue, size: 30),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: PhoneHubColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  order.subtitle,
                  style: const TextStyle(color: PhoneHubColors.textGray, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            order.price,
            style: const TextStyle(
              color: PhoneHubColors.blue,
              fontWeight: FontWeight.w900,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

class _PhoneHubBottomSheet extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _PhoneHubBottomSheet({
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 30,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(
                  color: PhoneHubColors.border,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [PhoneHubColors.blue, PhoneHubColors.cyan],
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(icon, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: PhoneHubColors.textDark,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class _MembershipLevelCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double progress;

  const _MembershipLevelCard({
    required this.title,
    required this.subtitle,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0F172A), PhoneHubColors.blue],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 9,
              backgroundColor: Colors.white24,
              valueColor: const AlwaysStoppedAnimation(Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _BenefitTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _BenefitTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: PhoneHubColors.softCard,
        child: Icon(icon, color: PhoneHubColors.blue),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w900, color: PhoneHubColors.textDark),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: PhoneHubColors.textGray),
      ),
    );
  }
}

class _OrderModel {
  final String title;
  final String subtitle;
  final String price;
  final IconData icon;

  const _OrderModel({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.icon,
  });
}
