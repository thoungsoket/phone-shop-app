import 'package:flutter/material.dart';

import '../common/phonehub_store.dart';
import '../data/product_data.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  int selectedTab = 0;

  final tabs = const [
    'All Media',
    'Product Photos',
    'Unboxing',
    'Reviews',
  ];

  List<Map<String, dynamic>> get newArrivals =>
      ProductData.allProducts.where((p) => p['isNew'] == true).take(6).toList();

  List<Map<String, dynamic>> get bestDeals =>
      ProductData.allProducts.where((p) => p['isUsed'] == true).take(6).toList();

  List<Map<String, dynamic>> get accessories => ProductData.allProducts
      .where((p) => p['category'] == 'Accessories')
      .take(6)
      .toList();

  List<Map<String, dynamic>> get productPhotos =>
      ProductData.allProducts.take(30).toList();

  List<Map<String, dynamic>> get unboxing =>
      ProductData.allProducts.where((p) => p['isNew'] == true).take(20).toList();

  bool _isSaved(Map<String, dynamic> product) {
    return PhoneHubStore.instance.favoriteGallery.any(
      (item) => item['name'] == product['name'].toString(),
    );
  }

  void _toggleSave(Map<String, dynamic> product) {
    final wasSaved = _isSaved(product);

    PhoneHubStore.instance.toggleGalleryFavorite(
      name: product['name'].toString(),
      image: product['image'].toString(),
      brand: product['brand'].toString(),
    );

    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(wasSaved ? 'Removed from saved photos' : 'Saved to profile'),
        duration: const Duration(seconds: 1),
        backgroundColor: wasSaved ? Colors.grey.shade700 : const Color(0xFF007BF6),
      ),
    );
  }

  void _openPreview(Map<String, dynamic> product, bool isVideo) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.black,
        insetPadding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            InteractiveViewer(
              child: Image.asset(
                product['image'],
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: Colors.white),
              ),
            ),
            if (isVideo)
              const Positioned.fill(
                child: Center(
                  child: CircleAvatar(
                    radius: 34,
                    backgroundColor: Colors.black54,
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 46,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded, color: Color(0xFF0F172A)),
          onPressed: () => Navigator.pushNamed(context, '/home'),
        ),
        centerTitle: true,
        title: const Text(
          'PhoneHub',
          style: TextStyle(
            color: Color(0xFF007BF6),
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/cart'),
            icon: const Icon(Icons.shopping_cart_outlined, color: Color(0xFF0F172A)),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
        children: [
          const Text(
            'Photos & Videos',
            style: TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Explore unboxings, reviews, and high-res product shots.',
            style: TextStyle(
              color: Color(0xFF64748B),
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 18),

          SizedBox(
            height: 38,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: tabs.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final active = selectedTab == index;

                return InkWell(
                  borderRadius: BorderRadius.circular(999),
                  onTap: () {
                    if (index == 3) {
                      Navigator.pushNamed(context, '/reviews');
                      return;
                    }

                    setState(() {
                      selectedTab = index;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: active ? const Color(0xFF007BF6) : Colors.white,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: active
                            ? const Color(0xFF007BF6)
                            : const Color(0xFFE2E8F0),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        tabs[index],
                        style: TextStyle(
                          color: active ? Colors.white : const Color(0xFF334155),
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 22),

          if (selectedTab == 0) ...[
            _GallerySection(
              title: 'New Arrivals',
              products: newArrivals,
              isVideo: false,
              isSaved: _isSaved,
              onSave: _toggleSave,
              onOpen: _openPreview,
            ),
            const SizedBox(height: 24),
            _GallerySection(
              title: 'Best Deals',
              products: bestDeals,
              isVideo: false,
              isSaved: _isSaved,
              onSave: _toggleSave,
              onOpen: _openPreview,
            ),
            const SizedBox(height: 24),
            _GallerySection(
              title: 'Accessories',
              products: accessories,
              isVideo: false,
              isSaved: _isSaved,
              onSave: _toggleSave,
              onOpen: _openPreview,
            ),
            const SizedBox(height: 24),
            _GallerySection(
              title: 'Latest Unboxing',
              products: unboxing.take(4).toList(),
              isVideo: true,
              isSaved: _isSaved,
              onSave: _toggleSave,
              onOpen: _openPreview,
            ),
          ] else if (selectedTab == 1) ...[
            _GallerySection(
              title: 'Product Photos',
              products: productPhotos,
              isVideo: false,
              isSaved: _isSaved,
              onSave: _toggleSave,
              onOpen: _openPreview,
            ),
          ] else if (selectedTab == 2) ...[
            _GallerySection(
              title: 'Unboxing Videos',
              products: unboxing,
              isVideo: true,
              isSaved: _isSaved,
              onSave: _toggleSave,
              onOpen: _openPreview,
            ),
          ],
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF007BF6),
        unselectedItemColor: const Color(0xFF94A3B8),
        onTap: (index) {
          if (index == 0) Navigator.pushNamed(context, '/home');
          if (index == 1) Navigator.pushNamed(context, '/compare');
          if (index == 2) Navigator.pushNamed(context, '/favorites');
          if (index == 3) Navigator.pushNamed(context, '/nearby');
          if (index == 4) Navigator.pushNamed(context, '/profile');
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.compare_arrows_rounded), label: 'Compare'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border_rounded), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.storefront_rounded), label: 'Nearby'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: 'Profile'),
        ],
      ),
    );
  }
}

class _GallerySection extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> products;
  final bool isVideo;
  final bool Function(Map<String, dynamic>) isSaved;
  final void Function(Map<String, dynamic>) onSave;
  final void Function(Map<String, dynamic>, bool) onOpen;

  const _GallerySection({
    required this.title,
    required this.products,
    required this.isVideo,
    required this.isSaved,
    required this.onSave,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF0F172A),
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
            const Spacer(),
            Text(
              '${products.length} items',
              style: const TextStyle(
                color: Color(0xFF007BF6),
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ...products.map(
          (product) => Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: _GalleryMediaCard(
              product: product,
              isVideo: isVideo,
              saved: isSaved(product),
              onTap: () => onOpen(product, isVideo),
              onSave: () => onSave(product),
            ),
          ),
        ),
      ],
    );
  }
}

class _GalleryMediaCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final bool isVideo;
  final bool saved;
  final VoidCallback onTap;
  final VoidCallback onSave;

  const _GalleryMediaCard({
    required this.product,
    required this.isVideo,
    required this.saved,
    required this.onTap,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final title = product['name']?.toString() ?? 'Product';
    final brand = product['brand']?.toString() ?? 'PhoneHub';
    final image = product['image']?.toString() ?? '';

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        height: 260,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              image,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return Container(
                  color: const Color(0xFFE2E8F0),
                  child: const Center(
                    child: Icon(
                      Icons.image_not_supported_rounded,
                      size: 52,
                      color: Color(0xFF64748B),
                    ),
                  ),
                );
              },
            ),

            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                onPressed: onSave,
                icon: Icon(
                  saved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                  color: saved ? const Color(0xFF007BF6) : Colors.white,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: saved ? Colors.white : Colors.black38,
                ),
              ),
            ),

            Positioned(
              top: 10,
              right: 10,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.35),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isVideo ? Icons.videocam_rounded : Icons.photo_camera_rounded,
                  color: Colors.white,
                  size: 17,
                ),
              ),
            ),

            if (isVideo)
              const Center(
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.black45,
                  child: Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 42,
                  ),
                ),
              ),

            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(14, 36, 14, 14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.78),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isVideo ? '$title Unboxing' : title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isVideo ? '4:20 • $brand Review' : '$brand product shot',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                      ),
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
}