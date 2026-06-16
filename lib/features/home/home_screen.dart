import 'dart:async';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentBottomIndex = 0;
  int _selectedCategoryIndex = 0;
  
  // Flagship Auto-scrolling Banner Configurations
  final PageController _bannerPageController = PageController(initialPage: 0);
  int _currentBannerIndex = 0;
  Timer? _bannerTimer;

  // Modernized configuration housing unique background setups for image asset fallbacks
  final List<Map<String, String>> _bannerConfigs = [
    {
      'image': 'assets/images/ipbanner1.png',
      'fallbackColorStart': '0xFFE2E8F0',
      'fallbackColorEnd': '0xFFCBD5E1',
      'title': 'Premium Smartphones',
      'subtitle': 'Up to 40% Off',
      'cta': 'Shop Now →',
    },
    {
      'image': 'assets/images/ipbanner2.png',
      'fallbackColorStart': '0xFFF1F5F9',
      'fallbackColorEnd': '0xFFE2E8F0',
      'title': 'Wearable Tech',
      'subtitle': 'New Arrivals',
      'cta': 'Explore →',
    },
    {
      'image': 'assets/images/banner3.png',
      'fallbackColorStart': '0xFFEFF6FF',
      'fallbackColorEnd': '0xFFDBEAFE',
      'title': 'Accessories Sale',
      'subtitle': 'Up to 25% Off',
      'cta': 'View Deals →',
    },
  ];

  // Dynamic state repository explicitly tracking heart activation states by unique deal ID keys
  final Map<int, bool> _favoritedDeals = {};

  // Brands Strip Configuration
  final List<Map<String, dynamic>> _brands = [
    {'name': 'Apple', 'icon': Icons.phone_iphone_rounded},
    {'name': 'Samsung', 'icon': Icons.android_rounded},
    {'name': 'Xiaomi', 'icon': Icons.star_border_rounded}, 
    {'name': 'Oppo', 'icon': Icons.waves_rounded},
  ];
  String _selectedBrand = 'Apple';

  // Category Configuration
  final List<Map<String, dynamic>> _categories = [
    {'name': 'Phones', 'icon': Icons.phone_android_rounded, 'count': '142 Models'},
    {'name': 'Tablets', 'icon': Icons.tablet_mac_rounded, 'count': '48 Models'},
    {'name': 'Wearables', 'icon': Icons.watch_rounded, 'count': '64 Models'},
    {'name': 'Accessories', 'icon': Icons.headphones_rounded, 'count': '210 Models'},
  ];

  @override
  void initState() {
    super.initState();
    _bannerTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_bannerPageController.hasClients) {
        int nextPage = _currentBannerIndex + 1;
        if (nextPage >= _bannerConfigs.length) {
          nextPage = 0;
        }
        _bannerPageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 700),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildPremiumAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            
            // 1. Unobstructed, Distinct Graphic Banner Slider Slider 
            _buildFlagshipBannerSlider(),
            const SizedBox(height: 24),

            // 2. Category Tiles Layout Grid
            _buildSectionHeader('Explore Categories', showSeeAll: false),
            const SizedBox(height: 14),
            _buildCategoryTilesGrid(),
            const SizedBox(height: 26),

            // 3. Brand Selection Strip
            _buildSectionHeader('Popular Brands', showSeeAll: false),
            const SizedBox(height: 14),
            _buildBrandsStrip(),
            const SizedBox(height: 24),

            // 4. New Arrivals Horizontal Deck
            _buildSectionHeader('New Arrivals', onSeeAllPressed: () {}),
            const SizedBox(height: 14),
            _buildNewArrivalsHorizontalList(),
            const SizedBox(height: 26),

            // 5. Best Deals Showcase Section with working Interactive Hearts
            _buildSectionHeader('Best Deals', onSeeAllPressed: () {}),
            const SizedBox(height: 14),
            _buildBestDealsVerticalSection(),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  PreferredSizeWidget _buildPremiumAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: IconButton(
          icon: const Icon(Icons.menu_rounded, color: Color(0xFF0F172A), size: 26),
          onPressed: () {},
        ),
      ),
      title: const Text(
        'PhoneHub',
        style: TextStyle(
          color: Color(0xFF007BF6),
          fontWeight: FontWeight.w900,
          fontSize: 24,
          letterSpacing: -0.8,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search_rounded, color: Color(0xFF0F172A), size: 24),
          onPressed: () {},
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
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(color: Color(0xFFEF4444), shape: BoxShape.circle),
                child: const Text(
                  '2',
                  style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
        const SizedBox(width: 12),
      ],
    );
  }

  Widget _buildFlagshipBannerSlider() {
    return Column(
      children: [
        SizedBox(
          height: 185,
          child: PageView.builder(
            controller: _bannerPageController,
            itemCount: _bannerConfigs.length,
            onPageChanged: (index) {
              setState(() {
                _currentBannerIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final config = _bannerConfigs[index];
              final int startColorHex = int.parse(config['fallbackColorStart']!);
              final int endColorHex = int.parse(config['fallbackColorEnd']!);

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Background color
                      Container(
                        color: Color(startColorHex),
                      ),
                      // Image with reduced opacity so text is visible
                      Opacity(
                        opacity: 0.6,
                        child: Image.asset(
                          config['image']!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Color(startColorHex), Color(endColorHex)],
                                ),
                              ),
                              alignment: Alignment.center,
                              child: const Icon(Icons.image_not_supported_outlined, size: 40, color: Colors.black),
                            );
                          },
                        ),
                      ),
                      // Gradient overlay for better text readability
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.6),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      // Text overlay on banner
                      Positioned(
                        left: 20,
                        bottom: 20,
                        right: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              config['title']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 8,
                                    color: Colors.black38,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              config['subtitle']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                shadows: [
                                  Shadow(
                                    blurRadius: 8,
                                    color: Colors.black38,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                config['cta']!,
                                style: const TextStyle(
                                  color: Color(0xFF007BF6),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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

  Widget _buildCategoryTilesGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.45,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          final cat = _categories[index];
          bool isSelected = _selectedCategoryIndex == index;
          return InkWell(
            onTap: () {
              setState(() {
                _selectedCategoryIndex = index;
              });
            },
            borderRadius: BorderRadius.circular(16),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF007BF6) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? Colors.transparent : const Color(0xFFF1F5F9),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isSelected ? const Color(0xFF007BF6).withOpacity(0.18) : Colors.black.withOpacity(0.02),
                    blurRadius: 10,
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
                    child: Icon(
                      cat['icon'],
                      color: isSelected ? Colors.white : const Color(0xFF007BF6),
                      size: 22,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    cat['name'],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    cat['count'],
                    style: TextStyle(
                      fontSize: 11,
                      color: isSelected ? Colors.white.withOpacity(0.8) : const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBrandsStrip() {
    return SizedBox(
      height: 44,
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
            child: ChoiceChip(
              avatar: Icon(brand['icon'], size: 16, color: isSelected ? Colors.white : const Color(0xFF64748B)),
              label: Text(brand['name']),
              selected: isSelected,
              onSelected: (bool selected) {
                setState(() {
                  _selectedBrand = brand['name'];
                });
              },
              selectedColor: const Color(0xFF0F172A),
              backgroundColor: Colors.white,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF334155),
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: isSelected ? Colors.transparent : const Color(0xFFE2E8F0)),
              ),
              elevation: 0,
              pressElevation: 0,
              showCheckmark: false,
            ),
          );
        },
      ),
    );
  }

  Widget _buildNewArrivalsHorizontalList() {
    final List<Map<String, dynamic>> arrivals = [
      {'name': 'iPhone 17 Pro Max', 'price': '\$1399', 'tag': 'Apple', 'img': 'assets/images/ip17promax.png'},
      {'name': 'iPhone 17 Air', 'price': '\$1099', 'tag': 'Apple', 'img': 'assets/images/ip17air.png'},
      {'name': 'Galaxy S24 Ultra', 'price': '\$1299', 'tag': 'Samsung', 'img': 'assets/images/onboarding_compare.png'},
    ];

    return SizedBox(
      height: 245,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: arrivals.length,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final item = arrivals[index];
          return Container(
            width: 165,
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE2E8F0), width: 0.8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.015),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                )
              ]
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(14)),
                      padding: const EdgeInsets.all(8),
                      child: Image.asset(
                        item['img'],
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.phone_android_rounded, size: 44, color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    item['tag'].toUpperCase(),
                    style: const TextStyle(color: Color(0xFF007BF6), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 0.3),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item['name'],
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF0F172A)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
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

  Widget _buildBestDealsVerticalSection() {
    final List<Map<String, dynamic>> deals = [
      {'id': 1, 'name': 'Pixel 8 Pro 256GB', 'price': '\$849', 'oldPrice': '\$999', 'discount': '-15%', 'img': 'assets/images/onboarding_phone.png'},
      {'id': 2, 'name': 'iPhone 17 Base Standard', 'price': '\$799', 'oldPrice': '\$899', 'discount': '-11%', 'img': 'assets/images/ip17.png'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: deals.length,
        itemBuilder: (context, index) {
          final item = deals[index];
          final int id = item['id'] as int;
          // Get current favorite state, default to false if not set
          bool isFav = _favoritedDeals[id] ?? false;

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0), width: 0.8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.01),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                )
              ]
            ),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.all(6),
                  child: Image.asset(
                    item['img'],
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.phone_android_rounded, size: 36, color: Colors.grey),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(color: const Color(0xFFFEF2F2), borderRadius: BorderRadius.circular(4)),
                        child: Text(
                          item['discount'],
                          style: const TextStyle(color: Color(0xFFEF4444), fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF0F172A)),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            item['price'],
                            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Color(0xFFEF4444)),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            item['oldPrice'],
                            style: const TextStyle(decoration: TextDecoration.lineThrough, color: Color(0xFF94A3B8), fontSize: 12),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                // FIXED: Heart button now properly toggles between filled and border heart
                IconButton(
                  icon: Icon(
                    isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded, 
                    color: isFav ? const Color(0xFFEF4444) : const Color(0xFF94A3B8),
                    size: 28,
                  ),
                  onPressed: () {
                    setState(() {
                      // Toggle the favorite state for this specific deal
                      _favoritedDeals[id] = !isFav;
                      print('Deal ${item['name']} favorited: ${_favoritedDeals[id]}'); // Debug print
                    });
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title, {bool showSeeAll = true, VoidCallback? onSeeAllPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF0F172A), letterSpacing: -0.2),
          ),
          if (showSeeAll)
            TextButton(
              onPressed: onSeeAllPressed,
              style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
              child: const Row(
                children: [
                  Text('See All', style: TextStyle(color: Color(0xFF007BF6), fontWeight: FontWeight.bold, fontSize: 13)),
                  SizedBox(width: 1),
                  Icon(Icons.chevron_right_rounded, color: Color(0xFF007BF6), size: 16)
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, -4),
          )
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentBottomIndex,
        onTap: (index) {
          setState(() {
            _currentBottomIndex = index;
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