import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../cart/cart_screen.dart';
import '../compare/compare_screen.dart';
import '../favorites/favorites_screen.dart';
import '../nearby/nearby_screen.dart';
import '../home/home_screen.dart';
import '../detail/product_detail_screen.dart';
import '../../state/app_provider.dart';

class PromotionsScreen extends StatefulWidget {
  const PromotionsScreen({super.key});

  @override
  State<PromotionsScreen> createState() => _PromotionsScreenState();
}

class _PromotionsScreenState extends State<PromotionsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isDarkMode = false;
  bool _isCategoriesExpanded = false;

  final List<Map<String, dynamic>> _categories = [
    {
      'name': 'Smartphones',
      'icon': Icons.phone_android_rounded,
      'count': '44 Models',
    },
    {'name': 'Tablets', 'icon': Icons.tablet_mac_rounded, 'count': '20 Models'},
    {'name': 'Wearables', 'icon': Icons.watch_rounded, 'count': '20 Models'},
    {
      'name': 'Accessories',
      'icon': Icons.headphones_rounded,
      'count': '26 Models',
    },
  ];

  // ==================== NAVIGATION METHODS ====================

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  void _navigateToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CartScreen()),
    );
  }

  void _navigateToCompare() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CompareScreen()),
    );
  }

  void _navigateToFavorites() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FavoritesScreen()),
    );
  }

  void _navigateToNearby() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NearbyScreen()),
    );
  }

  void _navigateToCategory(String categoryName) {
    Navigator.pushNamed(
      context,
      '/category',
      arguments: {'categoryName': categoryName},
    );
  }

  void _navigateToDrawerItem(String itemName) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening $itemName...'),
        duration: const Duration(seconds: 1),
        backgroundColor: const Color(0xFF007BF6),
      ),
    );
  }

  void _toggleCategories() {
    setState(() {
      _isCategoriesExpanded = !_isCategoriesExpanded;
    });
  }

  void showMessage(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: const Duration(seconds: 2),
        backgroundColor: const Color(0xFF007BF6),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: _buildAppBar(),
      drawer: _buildDrawer(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // ==================== APP BAR ====================
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white.withOpacity(0.95),
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: IconButton(
          icon: const Icon(
            Icons.menu_rounded,
            color: Color(0xFF0F172A),
            size: 26,
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'PhoneHub',
            style: TextStyle(
              color: Color(0xFF007BF6),
              fontWeight: FontWeight.w900,
              fontSize: 20,
              letterSpacing: -0.8,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 1),
          Text(
            '📍 Phnom Penh Branch',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
              fontSize: 11,
              height: 1.0,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.search_rounded,
            color: Color(0xFF0F172A),
            size: 24,
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Search promotions coming soon!'),
                duration: Duration(seconds: 1),
                backgroundColor: Color(0xFF007BF6),
              ),
            );
          },
        ),
        Stack(
          children: [
            IconButton(
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: Color(0xFF0F172A),
                size: 24,
              ),
              onPressed: _navigateToCart,
            ),
            Positioned(
              right: 6,
              top: 6,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: Color(0xFFFF3B30),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${context.watch<CartProvider>().itemCount}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 12),
      ],
    );
  }

  // ==================== DRAWER ====================
  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF007BF6), Color(0xFF0EA5E9)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.person_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back! 👋',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Alex Johnson',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'alex@email.com',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          color: Colors.white,
                          size: 14,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '📍 Phnom Penh Branch',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 16, 8),
                    child: Text(
                      'MAIN',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  _buildExpandableCategories(),
                  _buildDrawerItem(
                    icon: Icons.compare_arrows_rounded,
                    title: 'Compare',
                    subtitle: 'Compare phones side-by-side',
                    onTap: () {
                      Navigator.pop(context);
                      _navigateToCompare();
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.favorite_rounded,
                    title: 'Favorites',
                    subtitle: 'Your saved items',
                    onTap: () {
                      Navigator.pop(context);
                      _navigateToFavorites();
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.local_offer_rounded,
                    title: 'Promotions',
                    subtitle: 'Active deals & coupons',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.shopping_bag_rounded,
                    title: 'Cart',
                    subtitle: 'View your cart',
                    onTap: () {
                      Navigator.pop(context);
                      _navigateToCart();
                    },
                  ),
                  const Divider(
                    height: 24,
                    thickness: 1,
                    indent: 16,
                    endIndent: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 16, 8),
                    child: Text(
                      'SUPPORT',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  _buildDrawerItem(
                    icon: Icons.build_rounded,
                    title: 'Repair Tracker',
                    subtitle: 'Check device status',
                    onTap: () => _navigateToDrawerItem('Repair Tracker'),
                  ),
                  _buildDrawerItem(
                    icon: Icons.storefront_rounded,
                    title: 'Store Branches',
                    subtitle: 'Find nearby stores',
                    onTap: () {
                      Navigator.pop(context);
                      _navigateToNearby();
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.headset_mic_rounded,
                    title: 'Customer Support',
                    subtitle: '24/7 live chat',
                    onTap: () => _navigateToDrawerItem('Customer Support'),
                  ),
                  const Divider(
                    height: 24,
                    thickness: 1,
                    indent: 16,
                    endIndent: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 16, 8),
                    child: Text(
                      'SETTINGS',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  _buildDrawerItem(
                    icon: Icons.settings_rounded,
                    title: 'Settings',
                    subtitle: 'App preferences',
                    onTap: () => _navigateToDrawerItem('Settings'),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: _isDarkMode
                          ? const Color(0xFF1E293B).withOpacity(0.08)
                          : const Color(0xFF007BF6).withOpacity(0.06),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                      leading: Icon(
                        _isDarkMode
                            ? Icons.dark_mode_rounded
                            : Icons.light_mode_rounded,
                        color: _isDarkMode
                            ? const Color(0xFF1E293B)
                            : const Color(0xFF007BF6),
                        size: 24,
                      ),
                      title: Text(
                        _isDarkMode ? 'Dark Mode (On)' : 'Dark Mode (Off)',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: _isDarkMode
                              ? const Color(0xFF1E293B)
                              : const Color(0xFF0F172A),
                        ),
                      ),
                      subtitle: Text(
                        _isDarkMode
                            ? 'Switch to light theme'
                            : 'Switch to dark theme',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      trailing: Switch(
                        value: _isDarkMode,
                        onChanged: (value) {
                          setState(() {
                            _isDarkMode = value;
                          });
                        },
                        activeColor: const Color(0xFF007BF6),
                        inactiveThumbColor: Colors.grey.shade400,
                        inactiveTrackColor: Colors.grey.shade200,
                      ),
                      onTap: () {
                        setState(() {
                          _isDarkMode = !_isDarkMode;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade200)),
              ),
              child: Center(
                child: Text(
                  'PhoneHub v2.4.1',
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF007BF6).withOpacity(0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: const Color(0xFF007BF6), size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0F172A),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
        ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
          color: Color(0xFF94A3B8),
          size: 20,
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      ),
    );
  }

  Widget _buildExpandableCategories() {
    return Column(
      children: [
        InkWell(
          onTap: _toggleCategories,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              color: _isCategoriesExpanded
                  ? const Color(0xFF007BF6).withOpacity(0.08)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF007BF6).withOpacity(0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.category_rounded,
                    color: Color(0xFF007BF6),
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      Text(
                        'Browse all products',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedRotation(
                  turns: _isCategoriesExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: const Icon(
                    Icons.arrow_drop_down_rounded,
                    color: Color(0xFF94A3B8),
                    size: 28,
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            padding: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: _categories.map((category) {
                return _buildSubCategoryItem(category);
              }).toList(),
            ),
          ),
          crossFadeState: _isCategoriesExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
          firstCurve: Curves.easeIn,
          secondCurve: Curves.easeOut,
        ),
      ],
    );
  }

  Widget _buildSubCategoryItem(Map<String, dynamic> category) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        _navigateToCategory(category['name']);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade200, width: 0.5),
          ),
        ),
        child: Row(
          children: [
            Icon(category['icon'], color: const Color(0xFF007BF6), size: 18),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category['name'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    category['count'],
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF94A3B8),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  // ==================== BODY ====================
  Widget _buildBody() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Promotions & Coupons',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Unlock exclusive deals and maximize your savings on your next device upgrade.',
          style: TextStyle(color: Colors.black54, height: 1.4),
        ),
        const SizedBox(height: 24),

        // Featured Offer
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFE9F7FF), Color(0xFFBFEFFF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF007BF6).withOpacity(0.1),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFF007BF6).withOpacity(0.2),
                      ),
                    ),
                    child: const Text(
                      '↗ Featured Offer',
                      style: TextStyle(
                        color: Color(0xFF007BF6),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF3B30).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Expires in 3 days',
                      style: TextStyle(
                        color: Color(0xFFFF3B30),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              const Text(
                'Massive Trade-In Bonus',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
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
                  onPressed: () =>
                      showMessage(context, 'Trade-in offer selected! 🎉'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF007BF6),
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

        // Promotion Card 1
        PromotionCard(
          icon: Icons.account_balance,
          title: 'Bank Card Offer',
          description:
              '10% instant discount on select credit cards.\nMax discount \$150.',
          code: 'BANK10OFF',
          footer: 'Valid till Oct 31',
          onCopy: () => showMessage(context, 'Copied BANK10OFF'),
          onUse: () => showMessage(context, 'Bank card offer applied! 💳'),
        ),

        const SizedBox(height: 16),

        // Small Promotion Cards
        SmallPromoCard(
          icon: Icons.school_outlined,
          title: 'Student Advantage',
          description: 'Save 15% on accessories',
          code: 'EDU15ACC',
          footer: 'Ends Dec 31',
          onCopy: () => showMessage(context, 'Copied EDU15ACC'),
          onUse: () => showMessage(context, 'Student discount applied! 🎓'),
        ),

        const SizedBox(height: 14),

        SmallPromoCard(
          icon: Icons.headphones,
          title: 'Audio Bundle',
          description: 'Buy phone, get earbuds 50% off',
          code: 'AUTO-APPLIED',
          footer: 'Ongoing',
          onCopy: () => showMessage(context, 'Auto-applied offer'),
          onUse: () => showMessage(context, 'Audio bundle activated! 🎧'),
        ),

        const SizedBox(height: 14),

        SmallPromoCard(
          icon: Icons.phone_android_rounded,
          title: 'Trade-In Bonus',
          description: 'Extra \$100 on any trade-in',
          code: 'TRADE100',
          footer: 'Limited time',
          onCopy: () => showMessage(context, 'Copied TRADE100'),
          onUse: () => showMessage(context, 'Trade-in bonus added! 📱'),
        ),

        const SizedBox(height: 14),

        SmallPromoCard(
          icon: Icons.credit_card_rounded,
          title: '0% EMI Financing',
          description: '6 months no-cost EMI on all phones',
          code: 'EMI6M',
          footer: 'Minimum \$500',
          onCopy: () => showMessage(context, 'Copied EMI6M'),
          onUse: () => showMessage(context, '0% EMI financing selected! 💳'),
        ),

        const SizedBox(height: 30),
      ],
    );
  }

  // ==================== BOTTOM NAVIGATION ====================
  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            _navigateToHome();
          } else if (index == 1) {
            _navigateToCompare();
          } else if (index == 2) {
            _navigateToFavorites();
          } else if (index == 3) {
            _navigateToNearby();
          } else if (index == 4) {
            Navigator.pushNamed(context, '/profile');
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF007BF6),
        unselectedItemColor: const Color(0xFF94A3B8),
        selectedFontSize: 11,
        unselectedFontSize: 11,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.compare_arrows_rounded),
            label: 'Compare',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_rounded),
            activeIcon: Icon(Icons.favorite_rounded),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront_rounded),
            label: 'Nearby',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            activeIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// ==================== COUPON BOX WIDGET ====================
class CouponBox extends StatelessWidget {
  final String code;
  final VoidCallback onCopy;

  const CouponBox({super.key, required this.code, required this.onCopy});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.75),
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
              fontSize: 14,
              color: Color(0xFF0F172A),
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: onCopy,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFF007BF6).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.copy, color: Color(0xFF007BF6), size: 18),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== PROMOTION CARD WIDGET ====================
class PromotionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String code;
  final String footer;
  final VoidCallback onCopy;
  final VoidCallback onUse;

  const PromotionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.code,
    required this.footer,
    required this.onCopy,
    required this.onUse,
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
            color: Colors.black.withOpacity(0.04),
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
            child: Icon(icon, color: const Color(0xFF007BF6)),
          ),
          const SizedBox(height: 18),
          Text(
            title,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(color: Colors.black87, height: 1.4),
          ),
          const Divider(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                footer,
                style: const TextStyle(color: Colors.black54, fontSize: 12),
              ),
              TextButton(
                onPressed: onUse,
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF007BF6),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Apply',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          CouponBox(code: code, onCopy: onCopy),
        ],
      ),
    );
  }
}

// ==================== SMALL PROMO CARD WIDGET ====================
class SmallPromoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String code;
  final String footer;
  final VoidCallback onCopy;
  final VoidCallback onUse;

  const SmallPromoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.code,
    required this.footer,
    required this.onCopy,
    required this.onUse,
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
            color: Colors.black.withOpacity(0.03),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFF1F5F9),
            child: Icon(icon, color: const Color(0xFF007BF6)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        footer,
                        style: const TextStyle(
                          color: Color(0xFF10B981),
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF007BF6).withOpacity(0.08),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        code,
                        style: const TextStyle(
                          color: Color(0xFF007BF6),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: onCopy,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(
                          Icons.copy,
                          size: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    InkWell(
                      onTap: onUse,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF007BF6),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'Apply',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
