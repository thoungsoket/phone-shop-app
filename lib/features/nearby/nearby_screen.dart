import 'package:flutter/material.dart';
import '../map/map_screen.dart';
import '../cart/cart_screen.dart';
import '../compare/compare_screen.dart';
import '../favorites/favorites_screen.dart';
import '../home/home_screen.dart';
import '../promotions/promotions_screen.dart';
import '../detail/product_detail_screen.dart';
import '../category/category_screen.dart'; // ✅ ADD THIS IMPORT

class NearbyScreen extends StatefulWidget {
  const NearbyScreen({super.key});

  @override
  State<NearbyScreen> createState() => _NearbyScreenState();
}

class _NearbyScreenState extends State<NearbyScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String selectedFilter = 'Open Now';
  bool _isDarkMode = false;
  bool _isCategoriesExpanded = false;

  final List<Map<String, dynamic>> _categories = [
    {'name': 'Smartphones', 'icon': Icons.phone_android_rounded, 'count': '44 Models'},
    {'name': 'Tablets', 'icon': Icons.tablet_mac_rounded, 'count': '20 Models'},
    {'name': 'Wearables', 'icon': Icons.watch_rounded, 'count': '20 Models'},
    {'name': 'Accessories', 'icon': Icons.headphones_rounded, 'count': '26 Models'},
  ];

  final List<Map<String, dynamic>> stores = [
    {
      'id': 1,
      'name': 'Downtown Hub',
      'distance': '0.8 miles away',
      'address': '123 Tech Avenue, Suite 100',
      'status': 'In Stock',
      'image': 'assets/images/store_1.png',
      'hours': '9:00 AM - 8:00 PM',
      'rating': 4.8,
    },
    {
      'id': 2,
      'name': 'Uptown Tech',
      'distance': '2.4 miles away',
      'address': '456 Innovation Blvd.',
      'status': 'Limited Stock',
      'image': 'assets/images/store_2.png',
      'hours': '10:00 AM - 9:00 PM',
      'rating': 4.5,
    },
    {
      'id': 3,
      'name': 'Westside Retail',
      'distance': '5.1 miles away',
      'address': '789 Commerce Way, Floor 2',
      'status': 'In Stock',
      'image': 'assets/images/store_3.png',
      'hours': '8:00 AM - 10:00 PM',
      'rating': 4.7,
    },
  ];

  final filters = ['Open Now', 'In Stock', 'Top Rated', 'Nearest'];

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

  void _navigateToPromotions() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PromotionsScreen()),
    );
  }

  void _navigateToMap() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MapScreen()),
    );
  }

  void _navigateToCategory(String categoryName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryScreen(
          categoryName: categoryName,
          initialFilter: 'All',
        ),
      ),
    );
  }

  void _navigateToBrand(String brandName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryScreen(
          categoryName: brandName,
          initialFilter: brandName,
        ),
      ),
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
    setState(() { _isCategoriesExpanded = !_isCategoriesExpanded; });
  }

  void _reserveDevice(Map<String, dynamic> store) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reserved device at ${store['name']} 📱'),
        backgroundColor: const Color(0xFF10B981),
        duration: const Duration(seconds: 2),
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
          icon: const Icon(Icons.menu_rounded, color: Color(0xFF0F172A), size: 26),
          onPressed: () { _scaffoldKey.currentState?.openDrawer(); },
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('PhoneHub', style: TextStyle(color: Color(0xFF007BF6), fontWeight: FontWeight.w900, fontSize: 20, letterSpacing: -0.8, height: 1.0)),
          const SizedBox(height: 1),
          Text('📍 Phnom Penh Branch', style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w500, fontSize: 11, height: 1.0)),
        ],
      ),
      actions: [
        // Search icon REMOVED from nearby screen
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart_outlined, color: Color(0xFF0F172A), size: 24),
              onPressed: _navigateToCart,
            ),
            Positioned(
              right: 6,
              top: 6,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(color: Color(0xFFFF3B30), shape: BoxShape.circle),
                child: const Text('0', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
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
                          child: Icon(Icons.person_rounded, color: Colors.white, size: 28),
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Welcome back! 👋', style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w500)),
                          Text('Alex Johnson', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                          Text('alex@email.com', style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.location_on_rounded, color: Colors.white, size: 14),
                        SizedBox(width: 4),
                        Text('📍 Phnom Penh Branch', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
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
                    child: Text('MAIN', style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
                  ),
                  _buildExpandableCategories(),
                  _buildDrawerItem(
                    icon: Icons.compare_arrows_rounded,
                    title: 'Compare',
                    subtitle: 'Compare phones side-by-side',
                    onTap: () { Navigator.pop(context); _navigateToCompare(); },
                  ),
                  _buildDrawerItem(
                    icon: Icons.favorite_rounded,
                    title: 'Favorites',
                    subtitle: 'Your saved items',
                    onTap: () { Navigator.pop(context); _navigateToFavorites(); },
                  ),
                  _buildDrawerItem(
                    icon: Icons.local_offer_rounded,
                    title: 'Promotions',
                    subtitle: 'Active deals & coupons',
                    onTap: () { Navigator.pop(context); _navigateToPromotions(); },
                  ),
                  _buildDrawerItem(
                    icon: Icons.shopping_bag_rounded,
                    title: 'Cart',
                    subtitle: 'View your cart',
                    onTap: () { Navigator.pop(context); _navigateToCart(); },
                  ),
                  const Divider(height: 24, thickness: 1, indent: 16, endIndent: 16),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 16, 8),
                    child: Text('SUPPORT', style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
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
                    onTap: () { Navigator.pop(context); },
                  ),
                  _buildDrawerItem(
                    icon: Icons.headset_mic_rounded,
                    title: 'Customer Support',
                    subtitle: '24/7 live chat',
                    onTap: () => _navigateToDrawerItem('Customer Support'),
                  ),
                  const Divider(height: 24, thickness: 1, indent: 16, endIndent: 16),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 16, 8),
                    child: Text('SETTINGS', style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
                  ),
                  _buildDrawerItem(
                    icon: Icons.settings_rounded,
                    title: 'Settings',
                    subtitle: 'App preferences',
                    onTap: () => _navigateToDrawerItem('Settings'),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: _isDarkMode ? const Color(0xFF1E293B).withOpacity(0.08) : const Color(0xFF007BF6).withOpacity(0.06),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                      leading: Icon(
                        _isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                        color: _isDarkMode ? const Color(0xFF1E293B) : const Color(0xFF007BF6),
                        size: 24,
                      ),
                      title: Text(
                        _isDarkMode ? 'Dark Mode (On)' : 'Dark Mode (Off)',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: _isDarkMode ? const Color(0xFF1E293B) : const Color(0xFF0F172A)),
                      ),
                      subtitle: Text(
                        _isDarkMode ? 'Switch to light theme' : 'Switch to dark theme',
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                      ),
                      trailing: Switch(
                        value: _isDarkMode,
                        onChanged: (value) { setState(() { _isDarkMode = value; }); },
                        activeColor: const Color(0xFF007BF6),
                        inactiveThumbColor: Colors.grey.shade400,
                        inactiveTrackColor: Colors.grey.shade200,
                      ),
                      onTap: () { setState(() { _isDarkMode = !_isDarkMode; }); },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade200))),
              child: Center(
                child: Text('PhoneHub v2.4.1', style: TextStyle(color: Colors.grey.shade400, fontSize: 12, fontWeight: FontWeight.w500)),
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
        title: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF0F172A))),
        subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
        trailing: const Icon(Icons.chevron_right_rounded, color: Color(0xFF94A3B8), size: 20),
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
              color: _isCategoriesExpanded ? const Color(0xFF007BF6).withOpacity(0.08) : Colors.transparent,
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
                  child: const Icon(Icons.category_rounded, color: Color(0xFF007BF6), size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Categories',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF0F172A)),
                      ),
                      Text(
                        'Browse all products',
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
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
          crossFadeState: _isCategoriesExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
          firstCurve: Curves.easeIn,
          secondCurve: Curves.easeOut,
        ),
      ],
    );
  }

  // ✅ FIXED: This now correctly navigates to the category screen
  Widget _buildSubCategoryItem(Map<String, dynamic> category) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        // Navigate directly to the category screen with the category name
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryScreen(
              categoryName: category['name'],
              initialFilter: 'All',
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade200, width: 0.5)),
        ),
        child: Row(
          children: [
            Icon(category['icon'], color: const Color(0xFF007BF6), size: 18),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(category['name'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF0F172A))),
                  Text(category['count'], style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: Color(0xFF94A3B8), size: 20),
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
          'Nearby Stock',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
        ),
        const SizedBox(height: 14),

        // Search field - stays on nearby screen
        TextField(
          decoration: InputDecoration(
            hintText: 'Search devices near you...',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Filter options coming soon!'),
                    duration: Duration(seconds: 1),
                    backgroundColor: Color(0xFF007BF6),
                  ),
                );
              },
              child: const Icon(Icons.tune, color: Color(0xFF007BF6)),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Color(0xFF007BF6), width: 2),
            ),
          ),
        ),

        const SizedBox(height: 18),

        // Filter chips
        Row(
          children: filters.map((filter) {
            final isSelected = selectedFilter == filter;

            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 6),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedFilter = filter;
                    });
                  },
                  child: Container(
                    height: 38,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF007BF6)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF007BF6)
                            : const Color(0xFFE5E7EB),
                      ),
                      boxShadow: isSelected ? [
                        BoxShadow(
                          color: const Color(0xFF007BF6).withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ] : [],
                    ),
                    child: Text(
                      filter,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 24),

        // Store cards
        for (int i = 0; i < stores.length; i++)
          StoreCard(
            store: stores[i],
            isFirst: i == 0,
            onReserve: () => _reserveDevice(stores[i]),
            onDirections: _navigateToMap,
          ),
      ],
    );
  }

  // ==================== BOTTOM NAVIGATION ====================
  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 16, offset: const Offset(0, -4))],
      ),
      child: BottomNavigationBar(
        currentIndex: 3,
        onTap: (index) {
          if (index == 0) {
            _navigateToHome();
          } else if (index == 1) {
            _navigateToCompare();
          } else if (index == 2) {
            _navigateToFavorites();
          } else if (index == 3) {
            // Already on nearby
          } else if (index == 4) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profile feature coming soon!'),
                duration: Duration(seconds: 1),
                backgroundColor: Color(0xFF007BF6),
              ),
            );
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
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.compare_arrows_rounded), label: 'Compare'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border_rounded), activeIcon: Icon(Icons.favorite_rounded), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.storefront_rounded), label: 'Nearby'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), activeIcon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
      ),
    );
  }
}

// ==================== STORE CARD WIDGET ====================
class StoreCard extends StatelessWidget {
  final Map<String, dynamic> store;
  final bool isFirst;
  final VoidCallback onReserve;
  final VoidCallback onDirections;

  const StoreCard({
    super.key,
    required this.store,
    required this.isFirst,
    required this.onReserve,
    required this.onDirections,
  });

  @override
  Widget build(BuildContext context) {
    final isLimited = store['status'] == 'Limited Stock';
    final rating = store['rating'] as double? ?? 4.5;

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
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
      child: Row(
        children: [
          if (isFirst)
            Container(
              width: 4,
              height: 176,
              decoration: const BoxDecoration(
                color: Color(0xFF007BF6),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                ),
              ),
            ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          width: 72,
                          height: 72,
                          color: Colors.grey.shade100,
                          child: Icon(
                            Icons.storefront_rounded,
                            size: 40,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    store['name'] as String,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFF0F172A),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (isFirst) ...[
                                  const SizedBox(width: 5),
                                  const Icon(
                                    Icons.verified,
                                    color: Color(0xFF007BF6),
                                    size: 15,
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 3),
                            Row(
                              children: [
                                const Icon(Icons.star_rounded, color: Colors.amber, size: 14),
                                const SizedBox(width: 2),
                                Text(
                                  rating.toStringAsFixed(1),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: Color(0xFF0F172A),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '⌖ ${store['distance']}',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 3),
                            Text(
                              store['address'] as String,
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 12,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 8),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: isLimited
                              ? const Color(0xFFFEF3C7)
                              : const Color(0xFFD1FAE5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          store['status'] as String,
                          style: TextStyle(
                            color: isLimited ? const Color(0xFFD97706) : const Color(0xFF059669),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: onDirections,
                          icon: const Icon(Icons.directions, size: 18),
                          label: const Text('Directions'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF007BF6),
                            side: const BorderSide(color: Color(0xFFE5E7EB)),
                            backgroundColor: const Color(0xFFF8FAFC),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: onReserve,
                          icon: const Icon(
                            Icons.shopping_bag_outlined,
                            size: 17,
                          ),
                          label: const Text('Reserve'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF007BF6),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
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