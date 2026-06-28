import 'package:flutter/material.dart';
import '../../features/data/product_data.dart';
import '../../features/detail/product_detail_screen.dart'; // ✅ ADD THIS IMPORT

class ProductSearchDelegate extends SearchDelegate<String> {
  final List<Map<String, dynamic>> allProducts;
  
  final List<String> recentSearches = [
    'iPhone 17 Pro Max',
    'Galaxy S26 Ultra',
    'AirPods Pro 3',
    'Galaxy Tab S10 Ultra',
    'Xiaomi 15 Pro'
  ];

  ProductSearchDelegate({required this.allProducts});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = allProducts.where((product) {
      final name = product['name'].toString().toLowerCase();
      final brand = product['brand'].toString().toLowerCase();
      final category = product['category'].toString().toLowerCase();
      final searchQuery = query.toLowerCase();
      return name.contains(searchQuery) ||
          brand.contains(searchQuery) ||
          category.contains(searchQuery);
    }).toList();

    if (results.isEmpty) {
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
            Text(
              'Try searching for "iPhone", "Samsung", or "Xiaomi"',
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
              icon: const Icon(Icons.refresh_rounded, size: 16),
              label: const Text('Clear Search'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF007BF6),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final product = results[index];
        return _buildProductTile(context, product);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? []
        : allProducts.where((product) {
            final name = product['name'].toString().toLowerCase();
            final brand = product['brand'].toString().toLowerCase();
            final category = product['category'].toString().toLowerCase();
            final searchQuery = query.toLowerCase();
            return name.contains(searchQuery) || 
                   brand.contains(searchQuery) ||
                   category.contains(searchQuery);
          }).toList();

    if (query.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Searches',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Clear recent searches functionality
                  },
                  child: const Text(
                    'Clear All',
                    style: TextStyle(
                      color: Color(0xFF007BF6),
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...recentSearches.map((search) => ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF007BF6).withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.history_rounded,
                  color: Color(0xFF007BF6),
                  size: 18,
                ),
              ),
              title: Text(
                search,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.close_rounded, size: 16, color: Colors.grey.shade400),
                onPressed: () {
                  // Remove from recent searches
                },
              ),
              onTap: () {
                query = search;
                showResults(context);
              },
            )),
          ],
        ),
      );
    }

    if (suggestions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off_rounded, size: 48, color: Colors.grey.shade300),
            const SizedBox(height: 8),
            Text(
              'No suggestions found',
              style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                showResults(context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF007BF6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Search for "$query"',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final product = suggestions[index];
        return _buildSuggestionTile(context, product);
      },
    );
  }

  // ✅ FIXED: Suggestion tile with navigation
  Widget _buildSuggestionTile(BuildContext context, Map<String, dynamic> product) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            product['image'],
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.phone_android_rounded, size: 24, color: Colors.grey),
          ),
        ),
      ),
      title: Text(
        product['name'],
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFF007BF6).withOpacity(0.1),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text(
              product['brand'],
              style: const TextStyle(
                color: Color(0xFF007BF6),
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '\$${product['price']}',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 6),
          Row(
            children: [
              const Icon(Icons.star_rounded, color: Colors.amber, size: 12),
              Text(
                '${product['rating']}',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFF007BF6).withOpacity(0.08),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          product['category'],
          style: const TextStyle(
            color: Color(0xFF007BF6),
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onTap: () {
        // ✅ FIXED: Navigate to product detail
        close(context, product['name']);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
    );
  }

  // ✅ FIXED: Product tile with navigation
  Widget _buildProductTile(BuildContext context, Map<String, dynamic> product) {
    bool isBestDeal = product['id'] == 1 || product['id'] == 31 ||
        product['id'] == 60 || product['id'] == 85 ||
        product['id'] == 108 || product['id'] == 119;
    bool isNew = product['isNew'] == true;
    bool isUsed = product['isUsed'] == true;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        leading: Stack(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  product['image'],
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.phone_android_rounded, size: 24, color: Colors.grey),
                ),
              ),
            ),
            if (isBestDeal)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF3B30),
                    borderRadius: BorderRadius.circular(3),
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
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981),
                    borderRadius: BorderRadius.circular(3),
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
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6B7280),
                    borderRadius: BorderRadius.circular(3),
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
              ),
          ],
        ),
        title: Text(
          product['name'],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${product['brand']} • ${product['category']}',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Text(
                  '\$${product['price']}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: isUsed ? const Color(0xFF6B7280) : const Color(0xFF0F172A),
                  ),
                ),
                if (isUsed) ...[
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B7280).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: const Text(
                      'Pre-owned',
                      style: TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.chevron_right_rounded),
          onPressed: () {
            // ✅ FIXED: Navigate to product detail
            close(context, product['name']);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailScreen(product: product),
              ),
            );
          },
        ),
        onTap: () {
          // ✅ FIXED: Navigate to product detail
          close(context, product['name']);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(product: product),
            ),
          );
        },
      ),
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF0F172A)),
        titleTextStyle: const TextStyle(
          color: Color(0xFF0F172A),
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Color(0xFF94A3B8)),
      ),
    );
  }
}