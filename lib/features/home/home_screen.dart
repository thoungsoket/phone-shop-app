import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../category/category_screen.dart';
import '../compare/compare_screen.dart';
import '../search/search_delegate.dart';
import '../data/product_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // GLOBAL KEY FOR DRAWER
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  int _currentBottomIndex = 0;
  int _selectedCategoryIndex = 0;
  String _selectedBrand = 'Apple';
  bool _isDarkMode = false;
  bool _isCategoriesExpanded = false;
  
  // Auto-scrolling Banner Engine
  final PageController _bannerPageController = PageController(initialPage: 0);
  int _currentBannerIndex = 0;
  Timer? _bannerTimer;

  // Banner Configurations - ADDED navigationTarget
  final List<Map<String, dynamic>> _bannerConfigs = [
    {
      'tag': 'LIMITED OFFER',
      'title': 'iPhone 17 Air',
      'subtitle': 'Upgrade Your Tech\nGet Up to 20% Off',
      'cta': 'Shop Now',
      'image': 'assets/images/ipbanner1.png',
      'bgGradientStart': '0xFFE0F2FE',
      'bgGradientEnd': '0xFFBAE6FD',
      'accentColor': '0xFF0284C7',
      'navigationTarget': 'Apple', // Navigate to Apple products
    },
    {
      'tag': 'HOT DISCOUNTS',
      'title': 'Galaxy S26 Ultra',
      'subtitle': 'Pre-order Now\nFree Wireless Buds',
      'cta': 'View Deals',
      'image': 'assets/images/banner2.png',
      'bgGradientStart': '0xFFECFDF5',
      'bgGradientEnd': '0xFFA7F3D0',
      'accentColor': '0xFF059669',
      'navigationTarget': 'Best Deals', // Navigate to Best Deals
    },
    {
      'tag': 'NEW ARRIVAL',
      'title': 'AirPods Pro 3',
      'subtitle': 'Spatial Audio • ANC\nExperience Sound',
      'cta': 'Explore',
      'image': 'assets/images/banner3.png',
      'bgGradientStart': '0xFFF1F5F9',
      'bgGradientEnd': '0xFFE2E8F0',
      'accentColor': '0xFF0F172A',
      'navigationTarget': 'Accessories', // Navigate to Accessories
    },
  ];

  // Heart states
  final Map<int, bool> _favoritedDeals = {};

  // Quick Actions
  final List<Map<String, dynamic>> _quickActions = [
    {'title': 'Compare Phones', 'desc': 'Side-by-side specs', 'icon': Icons.compare_arrows_rounded, 'color': 0xFF007BF6},
    {'title': 'Track Repair', 'desc': 'Check device status', 'icon': Icons.build_circle_outlined, 'color': 0xFF10B981},
    {'title': 'Reserve Device', 'desc': 'Hold at local branch', 'icon': Icons.bookmark_added_outlined, 'color': 0xFFF59E0B},
    {'title': 'Promotions', 'desc': 'Active coupon club', 'icon': Icons.local_offer_outlined, 'color': 0xFFEF4444},
  ];

  // ========== CATEGORIES ==========
  final List<Map<String, dynamic>> _categories = [
    {'name': 'Smartphones', 'icon': Icons.phone_android_rounded, 'count': '44 Models'},
    {'name': 'Tablets', 'icon': Icons.tablet_mac_rounded, 'count': '20 Models'},
    {'name': 'Wearables', 'icon': Icons.watch_rounded, 'count': '20 Models'},
    {'name': 'Accessories', 'icon': Icons.headphones_rounded, 'count': '26 Models'},
  ];

  // ========== BRANDS - UPDATED WITH SVG LOGOS ==========
  final List<Map<String, dynamic>> _brands = [
    {'name': 'Apple', 'iconPath': 'assets/images/brands/apple.svg'},
    {'name': 'Samsung', 'iconPath': 'assets/images/brands/samsung.svg'},
    {'name': 'Xiaomi', 'iconPath': 'assets/images/brands/xiaomi.svg'},
    {'name': 'Oppo', 'iconPath': 'assets/images/brands/oppo.svg'},
    {'name': 'OnePlus', 'iconPath': 'assets/images/brands/oneplus.svg'},
    {'name': 'Vivo', 'iconPath': 'assets/images/brands/vivo.svg'},
  ];

  // ========== NEW ARRIVALS ==========
  final List<Map<String, dynamic>> _newArrivals = [
    {'id': 1, 'name': 'iPhone 17 Pro Max', 'price': '\$1399', 'tag': 'Apple', 'img': 'assets/images/ip17promax.png', 'rating': '4.9'},
    {'id': 31, 'name': 'Galaxy S26 Ultra', 'price': '\$1399', 'tag': 'Samsung', 'img': 'assets/images/s26_ultra.png', 'rating': '4.9'},
    {'id': 108, 'name': 'OnePlus 12', 'price': '\$899', 'tag': 'OnePlus', 'img': 'assets/images/oneplus12.png', 'rating': '4.5'},
    {'id': 119, 'name': 'Vivo X100 Ultra', 'price': '\$1099', 'tag': 'Vivo', 'img': 'assets/images/vivo_x100_ultra.png', 'rating': '4.5'},
  ];

  // ========== BEST DEALS ==========
  final List<Map<String, dynamic>> _bestDeals = [
    {'id': 1, 'name': 'iPhone 17 Pro Max', 'price': '\$1399', 'oldPrice': '\$1646', 'discount': '-15%', 'img': 'assets/images/ip17promax.png'},
    {'id': 31, 'name': 'Galaxy S26 Ultra', 'price': '\$1399', 'oldPrice': '\$1646', 'discount': '-15%', 'img': 'assets/images/s26_ultra.png'},
    {'id': 108, 'name': 'OnePlus 12', 'price': '\$899', 'oldPrice': '\$1058', 'discount': '-15%', 'img': 'assets/images/oneplus12.png'},
    {'id': 119, 'name': 'Vivo X100 Ultra', 'price': '\$1099', 'oldPrice': '\$1293', 'discount': '-15%', 'img': 'assets/images/vivo_x100_ultra.png'},
  ];

  @override
  void initState() {
    super.initState();
    _bannerTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_bannerPageController.hasClients) {
        int nextPage = _currentBannerIndex + 1;
        if (nextPage >= _bannerConfigs.length) {
          nextPage = 0;
        }
        _bannerPageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastOutSlowIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _bannerPageController.dispose();
    super.dispose();
  }

  // ==================== NAVIGATION METHODS ====================
  void _navigateToCategory(String categoryName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryScreen(
          categoryName: categoryName,
          subCategory: null,
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
          subCategory: null,
          initialFilter: brandName,
        ),
      ),
    );
  }

  void _navigateToNewArrivals() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryScreen(
          categoryName: 'New Arrivals',
          subCategory: null,
          initialFilter: 'All',
        ),
      ),
    );
  }

  void _navigateToBestDeals() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryScreen(
          categoryName: 'Best Deals',
          subCategory: null,
          initialFilter: 'All',
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
    setState(() {
      _isCategoriesExpanded = !_isCategoriesExpanded;
    });
  }

  // ==================== COMPARE NAVIGATION ====================
  void _navigateToCompare() {
    setState(() {
      _currentBottomIndex = 1;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CompareScreen(),
      ),
    ).then((_) {
      if (mounted) {
        setState(() {
          _currentBottomIndex = 0;
        });
      }
    });
  }

  // ==================== FAVORITES NAVIGATION ====================
  void _navigateToFavorites() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Favorites feature coming soon! 📱'),
        duration: Duration(seconds: 2),
        backgroundColor: Color(0xFF007BF6),
      ),
    );
  }

  // ==================== BANNER BUTTON NAVIGATION ====================
  void _handleBannerButtonTap(Map<String, dynamic> config) {
    final target = config['navigationTarget'] as String;
    
    // Navigate based on the target
    if (target == 'Best Deals') {
      _navigateToBestDeals();
    } else if (target == 'New Arrivals') {
      _navigateToNewArrivals();
    } else if (target == 'Smartphones' || 
               target == 'Tablets' || 
               target == 'Wearables' || 
               target == 'Accessories') {
      _navigateToCategory(target);
    } else {
      // Assume it's a brand name
      _navigateToBrand(target);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildPremiumAppBar(),
      drawer: _buildDrawer(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            
            // 1. Hero Banner Slider
            _buildPremiumHeroBannerSlider(),
            const SizedBox(height: 28),

            // 2. Quick Actions
            _buildSectionHeader('Quick Links', showSeeAll: false),
            const SizedBox(height: 12),
            _buildQuickActionsDeck(),
            const SizedBox(height: 28),

            _buildSectionDivider(),

            // 3. Shop by Category
            _buildSectionHeader('Shop By Category', showSeeAll: false),
            const SizedBox(height: 12),
            _buildCategoryTilesGrid(),
            const SizedBox(height: 28),

            _buildSectionDivider(),

            // 4. Popular Brands - UPDATED
            _buildSectionHeader('Popular Brands', showSeeAll: false),
            const SizedBox(height: 12),
            _buildBrandsStrip(),
            const SizedBox(height: 28),

            _buildSectionDivider(),

            // 5. New Arrivals
            _buildSectionHeader('New Arrivals', onSeeAllPressed: _navigateToNewArrivals),
            const SizedBox(height: 12),
            _buildNewArrivalsHorizontalList(),
            const SizedBox(height: 28),

            _buildSectionDivider(),

            // 6. Best Deals
            _buildSectionHeader('🔥 Best Deals', onSeeAllPressed: _navigateToBestDeals),
            const SizedBox(height: 12),
            _buildBestDealsVerticalSection(),
            const SizedBox(height: 28),

            _buildSectionDivider(),

            // 7. Compare Promo Card
            _buildCompareMarketingPromoCard(),
            const SizedBox(height: 28),

            // 8. Store Availability
            _buildStoreAvailabilityWidget(),
            const SizedBox(height: 28),

            // 9. Repair Service
            _buildRepairServiceCard(),
            const SizedBox(height: 36),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
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
                  
                  // ========== EXPANDABLE CATEGORIES ==========
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
                    onTap: () => _navigateToDrawerItem('Promotions'),
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
                    onTap: () => _navigateToDrawerItem('Store Branches'),
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
                        onChanged: (value) {
                          setState(() { _isDarkMode = value; });
                        },
                        activeColor: const Color(0xFF007BF6),
                        inactiveThumbColor: Colors.grey.shade400,
                        inactiveTrackColor: Colors.grey.shade200,
                      ),
                      onTap: () {
                        setState(() { _isDarkMode = !_isDarkMode; });
                      },
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

  // ==================== EXPANDABLE CATEGORIES ====================
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
                  child: const Icon(Icons.category_rounded, color: Color(0xFF007BF6), size: 22),
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
      onTap: () => _navigateToCategory(category['name']),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade200, width: 0.5),
          ),
        ),
        child: Row(
          children: [
            Icon(
              category['icon'],
              color: const Color(0xFF007BF6),
              size: 18,
            ),
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
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade500,
                    ),
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

  // ==================== APP BAR ====================
  PreferredSizeWidget _buildPremiumAppBar() {
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
        IconButton(
          icon: const Icon(Icons.search_rounded, color: Color(0xFF0F172A), size: 24),
          onPressed: () {
            showSearch(
              context: context,
              delegate: ProductSearchDelegate(
                allProducts: ProductData.allProducts,
              ),
            );
          },
        ),
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart_outlined, color: Color(0xFF0F172A), size: 24),
              onPressed: () {},
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

  // ==================== SECTION DIVIDER ====================
  Widget _buildSectionDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Divider(color: Colors.grey.shade200, thickness: 1, height: 1),
    );
  }

  // ==================== SECTION HEADER ====================
  Widget _buildSectionHeader(String title, {bool showSeeAll = true, VoidCallback? onSeeAllPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF0F172A), letterSpacing: -0.2)),
          if (showSeeAll)
            TextButton(
              onPressed: onSeeAllPressed,
              style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
              child: const Row(
                children: [
                  Text('See All', style: TextStyle(color: Color(0xFF007BF6), fontWeight: FontWeight.bold, fontSize: 13)),
                  SizedBox(width: 1),
                  Icon(Icons.chevron_right_rounded, color: Color(0xFF007BF6), size: 16),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // ==================== HERO BANNER - WITH WORKING BUTTONS ====================
  Widget _buildPremiumHeroBannerSlider() {
    return Column(
      children: [
        SizedBox(
          height: 210,
          child: PageView.builder(
            controller: _bannerPageController,
            itemCount: _bannerConfigs.length,
            onPageChanged: (index) { setState(() { _currentBannerIndex = index; }); },
            itemBuilder: (context, index) {
              final config = _bannerConfigs[index];
              final Color startColor = Color(int.parse(config['bgGradientStart']!));
              final Color endColor = Color(int.parse(config['bgGradientEnd']!));
              final Color accentColor = Color(int.parse(config['accentColor']!));

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(colors: [startColor, endColor], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 14, offset: const Offset(0, 6))],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: accentColor.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(config['tag']!, style: TextStyle(color: accentColor, fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 0.6)),
                              ),
                              const SizedBox(height: 2),
                              Text(config['title']!, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.w900), maxLines: 1, overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 1),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(config['subtitle']!, style: const TextStyle(color: Color(0xFF475569), fontSize: 11.5, fontWeight: FontWeight.w500, height: 1.2), maxLines: 2, overflow: TextOverflow.ellipsis),
                                ),
                              ),
                              // Banner Button - NOW WITH NAVIGATION
                              ElevatedButton(
                                onPressed: () => _handleBannerButtonTap(config),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF007BF6),
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                  minimumSize: const Size(0, 30),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                ),
                                child: Text(config['cta']!, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 10,
                          child: Transform.scale(
                            scale: 1.15,
                            child: Image.asset(
                              config['image']!,
                              fit: BoxFit.contain,
                              alignment: Alignment.centerRight,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  alignment: Alignment.center,
                                  child: Icon(Icons.phone_android_rounded, size: 75, color: accentColor.withOpacity(0.2)),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _bannerConfigs.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              height: 5,
              width: _currentBannerIndex == index ? 16 : 5,
              decoration: BoxDecoration(
                color: _currentBannerIndex == index ? const Color(0xFF007BF6) : const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        )
      ],
    );
  }

  // ==================== QUICK ACTIONS ====================
  Widget _buildQuickActionsDeck() {
    return SizedBox(
      height: 96,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _quickActions.length,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final act = _quickActions[index];
          final accentColor = Color(act['color'] as int);
          return GestureDetector(
            onTap: () {
              if (act['title'] == 'Compare Phones') {
                _navigateToCompare();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Opening ${act['title']}...'),
                    duration: const Duration(seconds: 1),
                    backgroundColor: const Color(0xFF007BF6),
                  ),
                );
              }
            },
            child: Container(
              width: 175,
              margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFE2E8F0), width: 0.8),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.015), blurRadius: 6, offset: const Offset(0, 3))],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [accentColor.withOpacity(0.15), accentColor.withOpacity(0.05)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(act['icon'] as IconData, color: accentColor, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(act['title'] as String, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)), maxLines: 1, overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 3),
                        Text(act['desc'] as String, style: const TextStyle(fontSize: 10, color: Color(0xFF64748B)), maxLines: 1, overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ==================== CATEGORIES ====================
  Widget _buildCategoryTilesGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          final cat = _categories[index];
          bool isSelected = _selectedCategoryIndex == index;
          return InkWell(
            onTap: () {
              setState(() { _selectedCategoryIndex = index; });
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryScreen(
                    categoryName: cat['name'],
                    subCategory: null,
                  ),
                ),
              );
            },
            borderRadius: BorderRadius.circular(16),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF007BF6) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: isSelected ? Colors.transparent : const Color(0xFFF1F5F9), width: 1),
                boxShadow: [
                  BoxShadow(
                    color: isSelected ? const Color(0xFF007BF6).withOpacity(0.18) : Colors.black.withOpacity(0.01),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white.withOpacity(0.15) : const Color(0xFFF0F7FF),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(cat['icon'], color: isSelected ? Colors.white : const Color(0xFF007BF6), size: 20),
                  ),
                  const SizedBox(height: 12),
                  Text(cat['name'], style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: isSelected ? Colors.white : const Color(0xFF0F172A))),
                  const SizedBox(height: 2),
                  Text(cat['count'], style: TextStyle(fontSize: 11, color: isSelected ? Colors.white.withOpacity(0.8) : const Color(0xFF64748B))),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ==================== BRANDS - UPDATED WITH SVG LOGOS ====================
  Widget _buildBrandsStrip() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _brands.length,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final brand = _brands[index];
          bool isSelected = _selectedBrand == brand['name'];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: GestureDetector(
              onTap: () {
                setState(() { _selectedBrand = brand['name']; });
                _navigateToBrand(brand['name']);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF0F172A) : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isSelected ? Colors.transparent : const Color(0xFFE2E8F0),
                  ),
                  boxShadow: isSelected
                      ? [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8)]
                      : [],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      brand['iconPath'],
                      height: 20,
                      width: 20,
                      colorFilter: ColorFilter.mode(
                        isSelected ? Colors.white : const Color(0xFF334155),
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      brand['name'],
                      style: TextStyle(
                        color: isSelected ? Colors.white : const Color(0xFF334155),
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ==================== NEW ARRIVALS ====================
  Widget _buildNewArrivalsHorizontalList() {
    return SizedBox(
      height: 255,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _newArrivals.length,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final item = _newArrivals[index];
          final int itemId = item['id'] as int;
          bool isFav = _favoritedDeals[itemId] ?? false;

          return Container(
            width: 165,
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE2E8F0), width: 0.8),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.015), blurRadius: 8, offset: const Offset(0, 4))],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(14)),
                          padding: const EdgeInsets.all(8),
                          child: Image.asset(
                            item['img'],
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) => const Icon(Icons.phone_android_rounded, size: 44, color: Colors.grey),
                          ),
                        ),
                        Positioned(
                          left: 4,
                          top: 4,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFF10B981),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'NEW',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 4,
                          top: 4,
                          child: InkWell(
                            onTap: () { setState(() { _favoritedDeals[itemId] = !isFav; }); },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                              child: Icon(
                                isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                                color: isFav ? const Color(0xFFFF3B30) : const Color(0xFF94A3B8),
                                size: 16,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item['tag'].toUpperCase(), style: const TextStyle(color: Color(0xFF007BF6), fontSize: 10, fontWeight: FontWeight.w800)),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, color: Colors.amber, size: 12),
                          const SizedBox(width: 2),
                          Text(item['rating'], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF475569))),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF0F172A)), maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item['price'], style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: Color(0xFF0F172A))),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(color: Color(0xFF007BF6), shape: BoxShape.circle),
                        child: const Icon(Icons.add_rounded, color: Colors.white, size: 16),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ==================== BEST DEALS ====================
  Widget _buildBestDealsVerticalSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _bestDeals.length,
        itemBuilder: (context, index) {
          final item = _bestDeals[index];
          final int id = item['id'] as int;
          bool isFav = _favoritedDeals[id] ?? false;

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0), width: 0.8),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.01), blurRadius: 8, offset: const Offset(0, 4))],
            ),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.all(6),
                  child: Stack(
                    children: [
                      Image.asset(
                        item['img'],
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.phone_android_rounded, size: 36, color: Colors.grey),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF3B30),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Text(
                            item['discount'],
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
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF3B30).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'BEST DEAL',
                          style: TextStyle(color: Color(0xFFFF3B30), fontSize: 9, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF0F172A))),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(item['price'], style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Color(0xFFFF3B30))),
                          const SizedBox(width: 8),
                          Text(item['oldPrice'], style: const TextStyle(decoration: TextDecoration.lineThrough, color: Color(0xFF94A3B8), fontSize: 12)),
                        ],
                      )
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded, color: isFav ? const Color(0xFFFF3B30) : const Color(0xFF94A3B8), size: 24),
                  onPressed: () { setState(() { _favoritedDeals[id] = !isFav; }); },
                )
              ],
            ),
          );
        },
      ),
    );
  }

  // ==================== PROMO CARD ====================
  Widget _buildCompareMarketingPromoCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(colors: [Color(0xFF007BF6), Color(0xFF0EA5E9)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        boxShadow: [BoxShadow(color: const Color(0xFF007BF6).withOpacity(0.2), blurRadius: 16, offset: const Offset(0, 8))],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('💡 Not sure which phone to buy?', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('Compare up to 3 devices side by side to pick the absolute best option for you.', style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12, height: 1.3)),
                const SizedBox(height: 14),
                ElevatedButton(
                  onPressed: _navigateToCompare,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF007BF6),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Start Comparing', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
          const SizedBox(width: 12),
          Icon(Icons.compare_arrows_rounded, size: 64, color: Colors.white.withOpacity(0.25)),
        ],
      ),
    );
  }

  // ==================== STORE AVAILABILITY ====================
  Widget _buildStoreAvailabilityWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.01), blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.location_on_rounded, color: Color(0xFF007BF6), size: 18),
              SizedBox(width: 6),
              Text('Nearby Store Availability', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(color: Color(0xFFF0FDF4), shape: BoxShape.circle),
                    child: const Icon(Icons.storefront_rounded, color: Color(0xFF16A34A), size: 18),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('iPhone 17 Pro Max', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                      SizedBox(height: 1),
                      Text('✓ Available in 3 local branches', style: TextStyle(fontSize: 11, color: Color(0xFF16A34A))),
                    ],
                  )
                ],
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                ),
                child: const Text('Check Stock', style: TextStyle(color: Color(0xFF007BF6), fontSize: 11, fontWeight: FontWeight.bold)),
              )
            ],
          )
        ],
      ),
    );
  }

  // ==================== REPAIR CARD ====================
  Widget _buildRepairServiceCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF1E293B), Color(0xFF0F172A)]),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 16, offset: const Offset(0, 8))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('🔧 Need a Repair?', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text('✓ Screen & Battery Replacement\n✓ Professional Diagnostics', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 11, height: 1.4)),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF007BF6),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Book Service', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          )
        ],
      ),
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
        currentIndex: _currentBottomIndex,
        onTap: (index) { 
          setState(() { 
            _currentBottomIndex = index;
            if (index == 0) {
              // Already on home
            } else if (index == 1) {
              _navigateToCompare();
            } else if (index == 2) {
              _navigateToFavorites();
            }
          }); 
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