import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../data/product_data.dart';
import '../search/search_delegate.dart';
import '../detail/product_detail_screen.dart';
import '../cart/cart_screen.dart';
import '../compare/compare_screen.dart';
import '../favorites/favorites_screen.dart';
import '../nearby/nearby_screen.dart';
import '../promotions/promotions_screen.dart';

class CategoryScreen extends StatefulWidget {
  final String categoryName;
  final String? subCategory;
  final String? initialFilter;
  final String? searchQuery;

  const CategoryScreen({
    super.key,
    required this.categoryName,
    this.subCategory,
    this.initialFilter,
    this.searchQuery,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late String _selectedFilter;
  String _selectedSort = 'Popular';
  bool _showSubCategories = true;
  String _searchQuery = '';

  // Favorite states - persisted across the screen
  final Map<int, bool> _favoritedProducts = {};
  
  // Cart states
  final Map<int, bool> _cartProducts = {};

  final List<String> _filters = [
    'All', 
    'Apple', 
    'Samsung', 
    'Xiaomi', 
    'Oppo',
    'OnePlus', 
    'Vivo',
  ];
  
  final List<String> _sortOptions = ['Popular', 'Price: Low to High', 'Price: High to Low', 'Newest', 'Rating: High to Low'];

  // ========== SVG BRAND LOGOS ==========
  final Map<String, List<Map<String, dynamic>>> _subCategories = {
    'Smartphones': [
      {'name': 'Apple', 'iconPath': 'assets/images/brands/apple.svg', 'count': '12 Models', 'color': 0xFF000000},
      {'name': 'Samsung', 'iconPath': 'assets/images/brands/samsung.svg', 'count': '11 Models', 'color': 0xFF1428A0},
      {'name': 'Xiaomi', 'iconPath': 'assets/images/brands/xiaomi.svg', 'count': '10 Models', 'color': 0xFFFF6900},
      {'name': 'Oppo', 'iconPath': 'assets/images/brands/oppo.svg', 'count': '10 Models', 'color': 0xFF1A6B37},
      {'name': 'OnePlus', 'iconPath': 'assets/images/brands/oneplus.svg', 'count': '6 Models', 'color': 0xFFEB0029},
      {'name': 'Vivo', 'iconPath': 'assets/images/brands/vivo.svg', 'count': '5 Models', 'color': 0xFF415FFF},
    ],
    'Tablets': [
      {'name': 'Apple', 'iconPath': 'assets/images/brands/apple.svg', 'count': '6 Models', 'color': 0xFF000000},
      {'name': 'Samsung', 'iconPath': 'assets/images/brands/samsung.svg', 'count': '6 Models', 'color': 0xFF1428A0},
      {'name': 'Xiaomi', 'iconPath': 'assets/images/brands/xiaomi.svg', 'count': '4 Models', 'color': 0xFFFF6900},
      {'name': 'Oppo', 'iconPath': 'assets/images/brands/oppo.svg', 'count': '3 Models', 'color': 0xFF1A6B37},
      {'name': 'OnePlus', 'iconPath': 'assets/images/brands/oneplus.svg', 'count': '2 Models', 'color': 0xFFEB0029},
    ],
    'Wearables': [
      {'name': 'Apple', 'iconPath': 'assets/images/brands/apple.svg', 'count': '5 Models', 'color': 0xFF000000},
      {'name': 'Samsung', 'iconPath': 'assets/images/brands/samsung.svg', 'count': '6 Models', 'color': 0xFF1428A0},
      {'name': 'Xiaomi', 'iconPath': 'assets/images/brands/xiaomi.svg', 'count': '5 Models', 'color': 0xFFFF6900},
      {'name': 'Oppo', 'iconPath': 'assets/images/brands/oppo.svg', 'count': '3 Models', 'color': 0xFF1A6B37},
    ],
    'Accessories': [
      {'name': 'Apple', 'iconPath': 'assets/images/brands/apple.svg', 'count': '7 Models', 'color': 0xFF000000},
      {'name': 'Samsung', 'iconPath': 'assets/images/brands/samsung.svg', 'count': '6 Models', 'color': 0xFF1428A0},
      {'name': 'Xiaomi', 'iconPath': 'assets/images/brands/xiaomi.svg', 'count': '6 Models', 'color': 0xFFFF6900},
      {'name': 'Oppo', 'iconPath': 'assets/images/brands/oppo.svg', 'count': '5 Models', 'color': 0xFF1A6B37},
      {'name': 'OnePlus', 'iconPath': 'assets/images/brands/oneplus.svg', 'count': '3 Models', 'color': 0xFFEB0029},
      {'name': 'Vivo', 'iconPath': 'assets/images/brands/vivo.svg', 'count': '3 Models', 'color': 0xFF415FFF},
    ],
  };

  // ==================== NAVIGATION METHODS ====================
  
  void _navigateToProductDetail(Map<String, dynamic> product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(product: product),
      ),
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

  void _navigateToPromotions() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PromotionsScreen()),
    );
  }

  void _navigateToHome() {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  // ==================== HELPER METHODS ====================
  bool _isInNewArrivals(Map<String, dynamic> product) {
    return product['isNew'] == true;
  }

  bool _isInBestDeals(Map<String, dynamic> product) {
    return product['id'] == 1 || product['id'] == 2 || product['id'] == 3 || product['id'] == 4 ||
           product['id'] == 31 || product['id'] == 60 || product['id'] == 85 ||
           product['id'] == 108 || product['id'] == 119;
  }

  bool _isUsed(Map<String, dynamic> product) {
    return product['isUsed'] == true;
  }

  // ==================== ADD TO CART ====================
  void _addToCart(Map<String, dynamic> product) {
    final int productId = product['id'] as int;
    setState(() {
      _cartProducts[productId] = true;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '${product['name']} added to cart 🛒',
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF10B981),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  // ==================== BADGE TYPE DETECTION ====================
  String _getBadgeType(Map<String, dynamic> product) {
    if (widget.categoryName == 'Best Deals' && _isInBestDeals(product)) {
      return 'best';
    }
    if (widget.categoryName == 'New Arrivals' && _isInNewArrivals(product)) {
      return 'new';
    }
    if (_isUsed(product)) {
      return 'used';
    }
    if (_isInNewArrivals(product)) {
      return 'new_regular';
    }
    return 'none';
  }

  bool get _isMainCategory {
    return widget.categoryName == 'Smartphones' ||
           widget.categoryName == 'Tablets' ||
           widget.categoryName == 'Wearables' ||
           widget.categoryName == 'Accessories';
  }

  bool get _isBrandView {
    return !_isMainCategory &&
           widget.initialFilter != null &&
           widget.initialFilter != 'All';
  }

  // ==================== FILTERED PRODUCTS ====================
  List<Map<String, dynamic>> get _filteredProducts {
    List<Map<String, dynamic>> filtered = List.from(ProductData.allProducts);
    
    // ========== APPLY SEARCH QUERY ==========
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((product) {
        final name = product['name'].toString().toLowerCase();
        final brand = product['brand'].toString().toLowerCase();
        final category = product['category'].toString().toLowerCase();
        final searchQuery = _searchQuery.toLowerCase();
        return name.contains(searchQuery) || 
               brand.contains(searchQuery) || 
               category.contains(searchQuery);
      }).toList();
    }
    
    if (widget.categoryName == 'New Arrivals') {
      filtered = filtered.where((p) => p['isNew'] == true).toList();
      if (_selectedFilter != 'All') {
        filtered = filtered.where((p) => p['brand'] == _selectedFilter).toList();
      }
      _applySort(filtered);
      return filtered;
    }
    
    if (widget.categoryName == 'Best Deals') {
      filtered = filtered.where((p) => _isInBestDeals(p)).toList();
      if (_selectedFilter != 'All') {
        filtered = filtered.where((p) => p['brand'] == _selectedFilter).toList();
      }
      _applySort(filtered);
      return filtered;
    }
    
    if (_isBrandView) {
      final selectedBrand =
          _selectedFilter == 'All'
              ? widget.initialFilter!
              : _selectedFilter;

      filtered = filtered
          .where((p) => p['brand'] == selectedBrand)
          .toList();

      _applySort(filtered);
      return filtered;
    }
    
    if (_isMainCategory) {
      filtered = filtered.where((p) => p['category'] == widget.categoryName).toList();
      if (_selectedFilter != 'All') {
        filtered = filtered.where((p) => p['brand'] == _selectedFilter).toList();
      }
      _applySort(filtered);
      return filtered;
    }
    
    if (_selectedFilter != 'All') {
      filtered = filtered.where((p) => p['brand'] == _selectedFilter).toList();
    }
    
    _applySort(filtered);
    return filtered;
  }

  void _applySort(List<Map<String, dynamic>> filtered) {
    switch (_selectedSort) {
      case 'Price: Low to High':
        filtered.sort((a, b) => a['price'].compareTo(b['price']));
        break;
      case 'Price: High to Low':
        filtered.sort((a, b) => b['price'].compareTo(a['price']));
        break;
      case 'Rating: High to Low':
        filtered.sort((a, b) => b['rating'].compareTo(a['rating']));
        break;
      case 'Newest':
        filtered.sort((a, b) => (b['isNew'] ? 1 : 0).compareTo(a['isNew'] ? 1 : 0));
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedFilter = widget.initialFilter ?? 'All';
    _searchQuery = widget.searchQuery ?? '';
    if (widget.initialFilter != null) {
      _showSubCategories = false;
    }
  }

  void _selectSubCategory(String brandName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryScreen(
          categoryName: widget.categoryName,
          subCategory: null,
          initialFilter: brandName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final productCount = _filteredProducts.length;
    final displayName = widget.categoryName;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(displayName),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // ==================== APP BAR ====================
  PreferredSizeWidget _buildAppBar(String title) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF0F172A)),
        onPressed: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          } else {
            _navigateToHome();
          }
        },
      ),
      title: Text(
        _showSubCategories && _isMainCategory ? 'Browse $title' : title,
        style: const TextStyle(
          color: Color(0xFF0F172A),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search_rounded, color: Color(0xFF0F172A)),
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
              icon: const Icon(Icons.shopping_cart_outlined, color: Color(0xFF0F172A)),
              onPressed: _navigateToCart, // ✅ FIXED: Navigates to cart
            ),
            Positioned(
              right: 6,
              top: 6,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(color: Color(0xFFFF3B30), shape: BoxShape.circle),
                child: Text(
                  '${_cartProducts.values.where((v) => v).length}',
                  style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildBody() {
    if (_showSubCategories && _isMainCategory) {
      return _buildSubCategoriesGrid();
    }

    final productCount = _filteredProducts.length;
    
    return Column(
      children: [
        _buildFilterSection(productCount),
        _buildProductCount(productCount),
        Expanded(
          child: productCount == 0
              ? _buildEmptyState()
              : _buildProductGrid(),
        ),
      ],
    );
  }

  Widget _buildSubCategoriesGrid() {
    final subCats = _subCategories[widget.categoryName] ?? [];
    
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(
            'Browse by Brand',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: subCats.length,
              itemBuilder: (context, index) {
                final sub = subCats[index];
                return _buildSubCategoryCard(sub);
              },
            ),
          ),
        ],
      ),
    );
  }

  // ==================== SVG BRAND LOGO CARD ====================
  Widget _buildSubCategoryCard(Map<String, dynamic> sub) {
    final Color brandColor = Color(sub['color'] as int);
    final String iconPath = sub['iconPath'];
    
    return InkWell(
      onTap: () => _selectSubCategory(sub['name']),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: brandColor.withOpacity(0.08),
                shape: BoxShape.circle,
                border: Border.all(
                  color: brandColor.withOpacity(0.15),
                  width: 1,
                ),
              ),
              child: SizedBox(
                height: 36,
                width: 36,
                child: SvgPicture.asset(
                  iconPath,
                  height: 36,
                  width: 36,
                  color: brandColor,
                  placeholderBuilder: (context) => Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.branding_watermark_rounded,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        color: brandColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          sub['name'][0],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: brandColor,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              sub['name'],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              sub['count'],
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection(int productCount) {
    if (_showSubCategories) {
      return const SizedBox.shrink();
    }

    final showFilters = _isBrandView || 
                        _isMainCategory ||
                        widget.categoryName == 'New Arrivals' ||
                        widget.categoryName == 'Best Deals';

    if (!showFilters) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$productCount products found',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<String>(
                value: _selectedSort,
                onChanged: (value) {
                  setState(() {
                    _selectedSort = value!;
                  });
                },
                underline: const SizedBox(),
                icon: const Icon(Icons.sort_rounded, size: 18),
                items: _sortOptions.map((sort) {
                  return DropdownMenuItem(
                    value: sort,
                    child: Text(
                      sort,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _filters.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final filter = _filters[index];
                final isSelected = _selectedFilter == filter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(filter),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                    selectedColor: const Color(0xFF007BF6),
                    backgroundColor: Colors.grey.shade100,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey.shade700,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      fontSize: 13,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected ? Colors.transparent : Colors.grey.shade300,
                      ),
                    ),
                    elevation: 0,
                    pressElevation: 0,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$productCount products found',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  value: _selectedSort,
                  onChanged: (value) {
                    setState(() {
                      _selectedSort = value!;
                    });
                  },
                  underline: const SizedBox(),
                  icon: const Icon(Icons.sort_rounded, size: 18),
                  items: _sortOptions.map((sort) {
                    return DropdownMenuItem(
                      value: sort,
                      child: Text(
                        sort,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductCount(int count) {
    if (_showSubCategories) {
      return const SizedBox.shrink();
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Showing $count products',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 12,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.view_module_rounded, size: 20),
            color: Colors.grey.shade600,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
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
          Icon(Icons.search_off_rounded, size: 64, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            'No products found',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {
              setState(() {
                _selectedFilter = 'All';
              });
            },
            child: const Text('Clear filters'),
          ),
        ],
      ),
    );
  }

  // ==================== PRODUCT GRID ====================
  Widget _buildProductGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.68,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: _filteredProducts.length,
      itemBuilder: (context, index) {
        final product = _filteredProducts[index];
        return _buildProductCard(product);
      },
    );
  }

  // ==================== PRODUCT CARD WITH FAVORITE ICON & CLICKABLE ====================
  Widget _buildProductCard(Map<String, dynamic> product) {
    final String badgeType = _getBadgeType(product);
    final bool isBestDeal = badgeType == 'best';
    final bool isNew = badgeType == 'new';
    final bool isUsed = badgeType == 'used';
    final bool isNewRegular = badgeType == 'new_regular';
    
    final bool hasDiscount = isBestDeal;
    final int? discountedPrice = hasDiscount ? (product['price'] * 0.85).round() : null;
    final bool productIsUsed = _isUsed(product);
    
    final int productId = product['id'] as int;
    final bool isFavorited = _favoritedProducts[productId] ?? false;
    final bool isInCart = _cartProducts[productId] ?? false;

    return GestureDetector(
      onTap: () => _navigateToProductDetail(product),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200, width: 0.8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 6,
              offset: const Offset(0, 3),
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
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset(
                        product['image'],
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.phone_android_rounded, size: 32, color: Colors.grey);
                        },
                      ),
                    ),
                  ),
                  // Badge
                  if (isBestDeal)
                    Positioned(
                      left: 4,
                      top: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF3B30),
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFF3B30).withOpacity(0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Text(
                          'BEST',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 7,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  else if (isNew)
                    Positioned(
                      left: 4,
                      top: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF10B981), Color(0xFF059669)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF10B981).withOpacity(0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Text(
                          'NEW',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 7,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  else if (isUsed)
                    Positioned(
                      left: 4,
                      top: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6B7280),
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF6B7280).withOpacity(0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Text(
                          'USED',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 7,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  else if (isNewRegular)
                    Positioned(
                      left: 4,
                      top: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: const Text(
                          'NEW',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  else
                    const SizedBox.shrink(),
                  // FAVORITE ICON - Top Right Corner
                  Positioned(
                    right: 4,
                    top: 4,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _favoritedProducts[productId] = !isFavorited;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFavorited ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                          color: isFavorited ? const Color(0xFFFF3B30) : const Color(0xFF94A3B8),
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
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                              decoration: BoxDecoration(
                                color: const Color(0xFF007BF6).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Text(
                                product['brand'],
                                style: const TextStyle(
                                  color: Color(0xFF007BF6),
                                  fontSize: 7,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (productIsUsed && !isUsed && !isBestDeal && !isNew && !isNewRegular)
                              const SizedBox(width: 4),
                            if (productIsUsed && !isUsed && !isBestDeal && !isNew && !isNewRegular)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF6B7280).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: const Text(
                                  'USED',
                                  style: TextStyle(
                                    color: Color(0xFF6B7280),
                                    fontSize: 6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 1),
                        Text(
                          product['name'],
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0F172A),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star_rounded, color: Colors.amber, size: 9),
                            const SizedBox(width: 2),
                            Text(
                              '${product['rating']}',
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
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (hasDiscount)
                              Text(
                                '\$${product['price']}',
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey.shade500,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            Text(
                              hasDiscount ? '\$$discountedPrice' : '\$${product['price']}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: productIsUsed && !isBestDeal ? const Color(0xFF6B7280) : const Color(0xFF0F172A),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            if (!isInCart) {
                              _addToCart(product);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Already in cart! 🛒'),
                                  duration: Duration(seconds: 1),
                                  backgroundColor: Colors.orange,
                                ),
                              );
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: isInCart ? const Color(0xFF10B981) : const Color(0xFF007BF6),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: (isInCart ? const Color(0xFF10B981) : const Color(0xFF007BF6)).withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              isInCart ? Icons.check_rounded : Icons.add_rounded,
                              color: Colors.white,
                              size: 12,
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