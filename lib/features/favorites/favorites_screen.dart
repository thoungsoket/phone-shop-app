import 'package:flutter/material.dart';
import '../cart/cart_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      {
        'name': 'Quantum Pro X',
        'detail': '256GB • Titanium Silver',
        'price': '\$999',
        'image': 'assets/images/quantum_pro_x.png',
      },
      {
        'name': 'Aero Fold 4',
        'detail': '512GB • Midnight Black',
        'price': '\$1,299',
        'image': 'assets/images/aero_fold_4.png',
      },
      {
        'name': 'iPhone 15 Pro',
        'detail': '256GB • Natural Titanium',
        'price': '\$1,199',
        'image': 'assets/images/iphone_15_pro.png',
      },
      {
        'name': 'Galaxy S24 Ultra',
        'detail': '512GB • Titanium Gray',
        'price': '\$1,149',
        'image': 'assets/images/galaxy_s24_ultra.png',
      },
      {
        'name': 'Pixel 8 Pro',
        'detail': '128GB • Obsidian Black',
        'price': '\$899',
        'image': 'assets/images/pixel_8_pro.png',
      },
    ];

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
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Favorites',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '5 Saved Devices',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF3FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Toggle Empty State',
                  style: TextStyle(
                    color: Color(0xFF0066E6),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          for (final product in products) FavoriteProductCard(product: product),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF0066E6),
        unselectedItemColor: Colors.black54,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.compare_arrows),
            label: 'Compare',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront_outlined),
            label: 'Nearby',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class FavoriteProductCard extends StatelessWidget {
  final Map<String, String> product;

  const FavoriteProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.close,
              size: 18,
              color: Colors.black.withOpacity(0.6),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Container(
              height: 220,
              width: double.infinity,
              color: const Color(0xFFF8FAFC),
              child: Image.asset(product['image']!, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              product['name']!,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              product['detail']!,
              style: const TextStyle(color: Colors.black54),
            ),
          ),
          const Divider(height: 28),
          Row(
            children: [
              Text(
                product['price']!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0066E6),
                ),
              ),
              const Spacer(),
              Container(
                height: 48,
                width: 48,
                decoration: const BoxDecoration(
                  color: Color(0xFF00C2FF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add_shopping_cart, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
