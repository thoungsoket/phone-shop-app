import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../cart/cart_screen.dart';
import '../compare/compare_screen.dart';
import '../home/home_screen.dart';
import '../nearby/nearby_screen.dart';
import '../promotions/promotions_screen.dart';
import '../detail/product_detail_screen.dart';
import '../data/product_data.dart';
import '../search/search_delegate.dart';
import '../../state/app_provider.dart';
import '../category/category_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isDarkMode = false;
  bool _isCategoriesExpanded = false;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController(); // ✅ ADDED

  final List<Map<String, dynamic>> _categories = [
    {'name': 'Smartphones', 'icon': Icons.phone_android_rounded, 'count': '44 Models'},
    {'name': 'Tablets', 'icon': Icons.tablet_mac_rounded, 'count': '20 Models'},
    {'name': 'Wearables', 'icon': Icons.watch_rounded, 'count': '20 Models'},
    {'name': 'Accessories', 'icon': Icons.headphones_rounded, 'count': '26 Models'},
  ];

  final List<Map<String, dynamic>> _brands = [
    {'name': 'Apple', 'iconPath': 'assets/images/brands/apple.svg'},
    {'name': 'Samsung', 'iconPath': 'assets/images/brands/samsung.svg'},
    {'name': 'Xiaomi', 'iconPath': 'assets/images/brands/xiaomi.svg'},
    {'name': 'Oppo', 'iconPath': 'assets/images/brands/oppo.svg'},
    {'name': 'OnePlus', 'iconPath': 'assets/images/brands/oneplus.svg'},
    {'name': 'Vivo', 'iconPath': 'assets/images/brands/vivo.svg'},
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

  void _navigateToNearby() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NearbyScreen()),
    );
  }

  void _navigateToPromotions() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PromotionsScreen()),
    );
  }

  void _navigateToProductDetail(Map<String, dynamic> product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(product: product),
      ),
    );
  }

  void _navigateToCategory(String categoryName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryScreen(categoryName: categoryName, initialFilter: 'All'),
      ),
    );
  }

  void _navigateToBrand(String brandName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryScreen(categoryName: brandName, initialFilter: brandName),
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

  void _removeFromFavorites(Map<String, dynamic> product) {
    context.read<CartProvider>().removeFavorite(product);
    
    // ✅ Clear search when removing an item
    if (_searchQuery.isNotEmpty) {
      _searchQuery = '';
      _searchController.clear();
    }
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Removed from favorites'),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.grey,
      ),
    );
  }

  // ==================== SEARCH FUNCTION ====================
  void _performSearch(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchQuery = '';
      _searchController.clear();
    });
  }

  List<Map<String, dynamic>> _visibleFavorites(
    List<Map<String, dynamic>> favorites,
  ) {
    if (_searchQuery.isEmpty) return favorites;
    final query = _searchQuery.toLowerCase();
    return favorites.where((product) {
      final name = product['name']?.toString().toLowerCase() ?? '';
      final brand = product['brand']?.toString().toLowerCase() ?? '';
      return name.contains(query) || brand.contains(query);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF8FAFC),
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
              onPressed: _navigateToCart,
            ),
            Positioned(
              right: 6,
              top: 6,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(color: Color(0xFFFF3B30), shape: BoxShape.circle),
                child: Text(
                  '${context.watch<CartProvider>().itemCount}',
                  style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
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
                    onTap: () { Navigator.pop(context); },
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
                    onTap: () { Navigator.pop(context); _navigateToNearby(); },
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
                      const Text('Categories', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF0F172A))),
                      Text('Browse all products', style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                    ],
                  ),
                ),
                AnimatedRotation(
                  turns: _isCategoriesExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: const Icon(Icons.arrow_drop_down_rounded, color: Color(0xFF94A3B8), size: 28),
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

  Widget _buildSubCategoryItem(Map<String, dynamic> category) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
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
    final favorites = context.watch<CartProvider>().favorites;
    final visibleFavorites = _visibleFavorites(favorites);

    return Column(
      children: [
        _buildHeader(visibleFavorites.length),
        _buildSearchBar(),
        Expanded(
          child: visibleFavorites.isEmpty
              ? _buildEmptyState()
              : _buildFavoritesGrid(visibleFavorites),
        ),
      ],
    );
  }

  // ==================== SEARCH BAR ====================
  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      child: TextField(
        controller: _searchController, // ✅ Added controller
        decoration: InputDecoration(
          hintText: 'Search favorites...',
          prefixIcon: const Icon(Icons.search, color: Color(0xFF94A3B8)),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Color(0xFF94A3B8)),
                  onPressed: _clearSearch, // ✅ Clear search when X is pressed
                )
              : null,
          filled: true,
          fillColor: const Color(0xFFF1F5F9),
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          hintStyle: TextStyle(color: Colors.grey.shade400),
        ),
        onChanged: _performSearch,
      ),
    );
  }

  Widget _buildHeader(int favoriteCount) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Favorites',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$favoriteCount Saved Devices',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _searchQuery.isNotEmpty ? Icons.search_off_rounded : Icons.favorite_border_rounded,
            size: 80,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            _searchQuery.isNotEmpty ? 'No favorites match your search' : 'No favorites yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _searchQuery.isNotEmpty ? 'Try a different search term' : 'Start saving your favorite devices ❤️',
            style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          ),
          const SizedBox(height: 24),
          if (!_searchQuery.isNotEmpty)
            ElevatedButton.icon(
              onPressed: _navigateToHome,
              icon: const Icon(Icons.home_rounded),
              label: const Text('Browse Products'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF007BF6),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFavoritesGrid(List<Map<String, dynamic>> favorites) {
    if (favorites.isEmpty) {
      return _buildEmptyState();
    }

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.68,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final item = favorites[index];
        return _buildFavoriteCard(item);
      },
    );
  }

  Widget _buildFavoriteCard(Map<String, dynamic> item) {
    final String brand = item['brand'] as String? ?? 'Brand';
    final String name = item['name'] as String? ?? 'Product';
    final num price = item['price'] as num? ?? 0;
    final String priceText = price % 1 == 0 ? price.toInt().toString() : price.toStringAsFixed(2);
    final String image = item['image'] as String? ?? 'assets/images/placeholder.png';
    final String storage = item['storage'] as String? ?? '256GB';
    final String color = item['color'] as String? ?? 'Default';
    final double rating = (item['rating'] as num?)?.toDouble() ?? 4.5;

    return GestureDetector(
      onTap: () => _navigateToProductDetail(item),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200, width: 0.8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image Section
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        image,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.phone_android_rounded, size: 40, color: Colors.grey);
                        },
                      ),
                    ),
                  ),
                  // Brand Badge
                  Positioned(
                    left: 6,
                    top: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF007BF6).withOpacity(0.9),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        brand,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Remove from favorites button
                  Positioned(
                    right: 4,
                    top: 4,
                    child: GestureDetector(
                      onTap: () => _removeFromFavorites(item),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 4),
                          ],
                        ),
                        child: const Icon(
                          Icons.close_rounded,
                          color: Color(0xFFFF3B30),
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Info Section
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 6, 10, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0F172A),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '$storage • $color',
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.grey.shade500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star_rounded, color: Colors.amber, size: 10),
                            const SizedBox(width: 2),
                            Text(
                              rating.toStringAsFixed(1),
                              style: TextStyle(
                                fontSize: 9,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$$priceText',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<CartProvider>().addProduct(item);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('$name added to cart'),
                                backgroundColor: const Color(0xFF10B981),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Color(0xFF007BF6),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.add_rounded,
                              color: Colors.white,
                              size: 14,
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
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            _navigateToHome();
          } else if (index == 1) {
            _navigateToCompare();
          } else if (index == 2) {
            // Already on favorites
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
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.compare_arrows_rounded), label: 'Compare'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_rounded), activeIcon: Icon(Icons.favorite_rounded), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.storefront_rounded), label: 'Nearby'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), activeIcon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
      ),
    );
  }
}