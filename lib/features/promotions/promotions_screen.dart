import 'package:flutter/material.dart';
import '../cart/cart_screen.dart';

class PromotionsScreen extends StatelessWidget {
  const PromotionsScreen({super.key});

  void showMessage(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: const Icon(Icons.menu, color: Color(0xFF0066E6)),
        title: const Text(
          'PhoneHub',
          style: TextStyle(
            color: Color(0xFF0066E6),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Color(0xFF0066E6),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Promotions & Coupons',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          const Text(
            'Unlock exclusive deals and maximize your savings on your next device upgrade.',
            style: TextStyle(color: Colors.black54, height: 1.4),
          ),
          const SizedBox(height: 24),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFE9F7FF), Color(0xFFBFEFFF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        '↗ Featured Offer',
                        style: TextStyle(
                          color: Color(0xFF0066E6),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'Expires in 3 days',
                      style: TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                const Text(
                  'Massive Trade-In Bonus',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Get up to \$800 credit when you trade in your eligible older device towards the new flagship series.',
                  style: TextStyle(color: Colors.black87, height: 1.4),
                ),
                const SizedBox(height: 18),
                CouponBox(
                  code: 'TRADEUP800',
                  onCopy: () => showMessage(context, 'Copied TRADEUP800'),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => showMessage(context, 'Trade-in offer selected'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00AEEF),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Use Now',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          PromotionCard(
            icon: Icons.account_balance,
            title: 'Bank Card Offer',
            description: '10% instant discount on select credit cards.\nMax discount \$150.',
            code: 'BANK10OFF',
            footer: 'Valid till Oct 31',
            onCopy: () => showMessage(context, 'Copied BANK10OFF'),
          ),

          const SizedBox(height: 16),

          SmallPromoCard(
            icon: Icons.school_outlined,
            title: 'Student Advantage',
            description: 'Save 15% on accessories',
            code: 'EDU15ACC',
            footer: 'Ends Dec 31',
            onCopy: () => showMessage(context, 'Copied EDU15ACC'),
          ),

          const SizedBox(height: 14),

          SmallPromoCard(
            icon: Icons.headphones,
            title: 'Audio Bundle',
            description: 'Buy phone, get earbuds 50% off',
            code: 'AUTO-APPLIED',
            footer: 'Ongoing',
            onCopy: () => showMessage(context, 'Auto-applied offer'),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF0066E6),
        unselectedItemColor: Colors.black54,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.compare_arrows), label: 'Compare'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.storefront_outlined), label: 'Nearby'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

class CouponBox extends StatelessWidget {
  final String code;
  final VoidCallback onCopy;

  const CouponBox({
    super.key,
    required this.code,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          Text(
            code,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: onCopy,
            child: const Icon(Icons.copy, color: Color(0xFF0066E6), size: 18),
          ),
        ],
      ),
    );
  }
}

class PromotionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String code;
  final String footer;
  final VoidCallback onCopy;

  const PromotionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.code,
    required this.footer,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFF1F5F9),
            child: Icon(icon, color: const Color(0xFF0066E6)),
          ),
          const SizedBox(height: 18),
          Text(
            title,
            style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(color: Colors.black87, height: 1.4),
          ),
          const Divider(height: 30),
          Text(
            footer,
            style: const TextStyle(color: Colors.black54, fontSize: 12),
          ),
          const SizedBox(height: 8),
          CouponBox(code: code, onCopy: onCopy),
        ],
      ),
    );
  }
}

class SmallPromoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String code;
  final String footer;
  final VoidCallback onCopy;

  const SmallPromoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.code,
    required this.footer,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFF1F5F9),
            child: Icon(icon, color: const Color(0xFF0066E6)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text(description, style: const TextStyle(fontSize: 12)),
                const SizedBox(height: 5),
                Text(
                  code,
                  style: const TextStyle(
                    color: Color(0xFF0066E6),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Text(
            footer,
            style: const TextStyle(color: Colors.black54, fontSize: 11),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: onCopy,
            child: const Icon(Icons.copy, size: 18, color: Colors.black45),
          ),
        ],
      ),
    );
  }
}