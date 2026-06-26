import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../cart/cart_screen.dart';
import '../compare/compare_screen.dart';
import '../favorites/favorites_screen.dart';
import '../nearby/nearby_screen.dart';
import '../promotions/promotions_screen.dart';
import '../../state/app_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _selectedColorIndex = 0;
  int _selectedStorageIndex = 0;
  int _selectedImageIndex = 0;

  // ========== NAVIGATION METHODS ==========

  void _addCurrentProductToCart() {
    final colorVariants = _colorVariants;
    final selectedColor = colorVariants[_selectedColorIndex];
    final selectedStorage = _storageVariants[_selectedStorageIndex];

    context.read<CartProvider>().addProduct(
      widget.product,
      color: selectedColor['name']?.toString(),
      storage: selectedStorage['storage']?.toString(),
      image:
          selectedColor['image']?.toString() ??
          widget.product['image']?.toString(),
      price: (selectedStorage['price'] as num?)?.toDouble(),
    );
  }

  bool _toggleCurrentFavorite() {
    final colorVariants = _colorVariants;
    final selectedColor = colorVariants[_selectedColorIndex];
    final selectedStorage = _storageVariants[_selectedStorageIndex];

    return context.read<CartProvider>().toggleFavorite(
      widget.product,
      color: selectedColor['name']?.toString(),
      storage: selectedStorage['storage']?.toString(),
      image:
          selectedColor['image']?.toString() ??
          widget.product['image']?.toString(),
      price: (selectedStorage['price'] as num?)?.toDouble(),
    );
  }

  void _addToCartAndStay() {
    _addCurrentProductToCart();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Added to cart'),
        duration: Duration(seconds: 1),
        backgroundColor: Color(0xFF10B981),
      ),
    );
  }

  void _navigateToCart() {
    _addCurrentProductToCart();

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

  // ========== APPLE SMARTPHONES ==========
  final Map<String, List<Map<String, dynamic>>> _appleColorVariants = {
    'iPhone 17 Pro Max': [
      {
        'name': 'Orange',
        'color': Color(0xFFFF6B35),
        'image': 'assets/images/iphone17_promax_orange.png',
      },
      {
        'name': 'Deep Blue',
        'color': Color(0xFF003366),
        'image': 'assets/images/iphone17_promax_deep_blue.png',
      },
      {
        'name': 'Silver',
        'color': Color(0xFFE8E8E8),
        'image': 'assets/images/iphone17_promax_silver.png',
      },
    ],
    'iPhone 17 Pro': [
      {
        'name': 'Deep Blue',
        'color': Color(0xFF003366),
        'image': 'assets/images/iphone17_pro_deep_blue.png',
      },
      {
        'name': 'Orange',
        'color': Color(0xFFFF6B35),
        'image': 'assets/images/iphone17_pro_orange.png',
      },
      {
        'name': 'Silver',
        'color': Color(0xFFE8E8E8),
        'image': 'assets/images/iphone17_pro_silver.png',
      },
    ],
    'iPhone 17': [
      {
        'name': 'Lavender',
        'color': Color(0xFFB6A1D9),
        'image': 'assets/images/iphone17_lavender.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/iphone17_black.png',
      },
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/iphone17_white.png',
      },
      {
        'name': 'Mist Blue',
        'color': Color(0xFFB8D4E3),
        'image': 'assets/images/iphone17_mist_blue.png',
      },
      {
        'name': 'Sage',
        'color': Color(0xFF9CAF88),
        'image': 'assets/images/iphone17_sage.png',
      },
    ],
    'iPhone 16 Pro Max': [
      {
        'name': 'Desert Titanium',
        'color': Color(0xFFC4A87C),
        'image': 'assets/images/iphone16_promax_desert_titanium.png',
      },
      {
        'name': 'Black Titanium',
        'color': Color(0xFF2C2C2C),
        'image': 'assets/images/iphone16_promax_black_titanium.png',
      },
      {
        'name': 'Natural Titanium',
        'color': Color(0xFFBFBFBF),
        'image': 'assets/images/iphone16_promax_natural_titanium.png',
      },
      {
        'name': 'White Titanium',
        'color': Color(0xFFF5F5F5),
        'image': 'assets/images/iphone16_promax_white_titanium.png',
      },
    ],
    'iPhone 16 Pro': [
      {
        'name': 'Desert Titanium',
        'color': Color(0xFFC4A87C),
        'image': 'assets/images/iphone16_pro_desert_titanium.png',
      },
      {
        'name': 'Black Titanium',
        'color': Color(0xFF2C2C2C),
        'image': 'assets/images/iphone16_pro_black_titanium.png',
      },
      {
        'name': 'Natural Titanium',
        'color': Color(0xFFBFBFBF),
        'image': 'assets/images/iphone16_pro_natural_titanium.png',
      },
      {
        'name': 'White Titanium',
        'color': Color(0xFFF5F5F5),
        'image': 'assets/images/iphone16_pro_white_titanium.png',
      },
    ],
    'iPhone 16 Plus': [
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/iphone16_plus_white.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/iphone16_plus_black.png',
      },
      {
        'name': 'Teal',
        'color': Color(0xFF008080),
        'image': 'assets/images/iphone16_plus_teal.png',
      },
      {
        'name': 'Ultramarine',
        'color': Color(0xFF120A8F),
        'image': 'assets/images/iphone16_plus_ultramarine.png',
      },
      {
        'name': 'Pink',
        'color': Color(0xFFFFB6C1),
        'image': 'assets/images/iphone16_plus_pink.png',
      },
    ],
    'iPhone 16': [
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/iphone16_black.png',
      },
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/iphone16_white.png',
      },
      {
        'name': 'Ultramarine',
        'color': Color(0xFF120A8F),
        'image': 'assets/images/iphone16_ultramarine.png',
      },
      {
        'name': 'Teal',
        'color': Color(0xFF008080),
        'image': 'assets/images/iphone16_teal.png',
      },
      {
        'name': 'Pink',
        'color': Color(0xFFFFB6C1),
        'image': 'assets/images/iphone16_pink.png',
      },
    ],
    'iPhone 15 Pro Max': [
      {
        'name': 'Natural Titanium',
        'color': Color(0xFFBFBFBF),
        'image': 'assets/images/iphone15_promax_natural_titanium.png',
      },
      {
        'name': 'Blue Titanium',
        'color': Color(0xFF4A6FA5),
        'image': 'assets/images/iphone15_promax_blue_titanium.png',
      },
      {
        'name': 'White Titanium',
        'color': Color(0xFFF5F5F5),
        'image': 'assets/images/iphone15_promax_white_titanium.png',
      },
      {
        'name': 'Black Titanium',
        'color': Color(0xFF2C2C2C),
        'image': 'assets/images/iphone15_promax_black_titanium.png',
      },
    ],
    'iPhone 15 Pro': [
      {
        'name': 'Black Titanium',
        'color': Color(0xFF2C2C2C),
        'image': 'assets/images/iphone15_pro_black_titanium.png',
      },
      {
        'name': 'Natural Titanium',
        'color': Color(0xFFBFBFBF),
        'image': 'assets/images/iphone15_pro_natural_titanium.png',
      },
      {
        'name': 'White Titanium',
        'color': Color(0xFFF5F5F5),
        'image': 'assets/images/iphone15_pro_white_titanium.png',
      },
      {
        'name': 'Blue Titanium',
        'color': Color(0xFF4A6FA5),
        'image': 'assets/images/iphone15_pro_blue_titanium.png',
      },
    ],
    'iPhone 15': [
      {
        'name': 'Yellow',
        'color': Color(0xFFFFD700),
        'image': 'assets/images/iphone15_yellow.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/iphone15_black.png',
      },
      {
        'name': 'Green',
        'color': Color(0xFF00A86B),
        'image': 'assets/images/iphone15_green.png',
      },
      {
        'name': 'Blue',
        'color': Color(0xFF007AFF),
        'image': 'assets/images/iphone15_blue.png',
      },
      {
        'name': 'Pink',
        'color': Color(0xFFFFB6C1),
        'image': 'assets/images/iphone15_pink.png',
      },
    ],
    'iPhone XR': [
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/iphonexr_black.png',
      },
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/iphonexr_white.png',
      },
      {
        'name': 'Blue',
        'color': Color(0xFF007AFF),
        'image': 'assets/images/iphonexr_blue.png',
      },
      {
        'name': 'Red',
        'color': Color(0xFFFF3B30),
        'image': 'assets/images/iphonexr_red.png',
      },
    ],
    'iPhone XS Max': [
      {
        'name': 'Gold',
        'color': Color(0xFFD4AF37),
        'image': 'assets/images/iphonexsmax_gold.png',
      },
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/iphonexsmax_silver.png',
      },
      {
        'name': 'Space Gray',
        'color': Color(0xFF2C2C2C),
        'image': 'assets/images/iphonexsmax_spacegray.png',
      },
    ],
  };

  // ========== SAMSUNG SMARTPHONES ==========
  final Map<String, List<Map<String, dynamic>>> _samsungColorVariants = {
    'Galaxy S26 Ultra': [
      {
        'name': 'Titanium Black',
        'color': Color(0xFF1A1A1A),
        'image': 'assets/images/s26_ultra_black.png',
      },
      {
        'name': 'Titanium Gray',
        'color': Color(0xFF8C8C8C),
        'image': 'assets/images/s26_ultra_gray.png',
      },
      {
        'name': 'Titanium White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/s26_ultra_white.png',
      },
    ],
    'Galaxy S26 Plus': [
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/s26_plus_black.png',
      },
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/s26_plus_white.png',
      },
    ],
    'Galaxy S26': [
      {
        'name': 'Lavender',
        'color': Color(0xFFB6A1D9),
        'image': 'assets/images/s26_lavender.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/s26_black.png',
      },
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/s26_white.png',
      },
    ],
    'Galaxy Z Fold 7': [
      {
        'name': 'Titanium Black',
        'color': Color(0xFF1A1A1A),
        'image': 'assets/images/zfold7_black.png',
      },
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/zfold7_silver.png',
      },
    ],
    'Galaxy Z Flip 7': [
      {
        'name': 'Mint',
        'color': Color(0xFF98FF98),
        'image': 'assets/images/zflip7_mint.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/zflip7_black.png',
      },
    ],
    'Galaxy Z Fold 6': [
      {
        'name': 'Phantom Black',
        'color': Color(0xFF0A0A0A),
        'image': 'assets/images/zfold6_black.png',
      },
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/zfold6_silver.png',
      },
    ],
    'Galaxy Z Flip 6': [
      {
        'name': 'Light Blue',
        'color': Color(0xFF87CEEB),
        'image': 'assets/images/zflip6_blue.png',
      },
      {
        'name': 'Yellow',
        'color': Color(0xFFFFD700),
        'image': 'assets/images/zflip6_yellow.png',
      },
    ],
    'Galaxy A55 5G': [
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/a55_5g_white.png',
      },
      {
        'name': 'Lavender',
        'color': Color(0xFFB6A1D9),
        'image': 'assets/images/a55_5g_lavender.png',
      },
    ],
    'Galaxy A35 5G': [
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/a35_5g_white.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/a35_5g_black.png',
      },
    ],
    'Galaxy S25 Ultra': [
      {
        'name': 'Titanium Gray',
        'color': Color(0xFF8C8C8C),
        'image': 'assets/images/s25_ultra_gray.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/s25_ultra_black.png',
      },
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/s25_ultra_white.png',
      },
    ],
    'Galaxy S25 Plus': [
      {
        'name': 'Mint',
        'color': Color(0xFF98FF98),
        'image': 'assets/images/s25_plus_mint.png',
      },
      {
        'name': 'Navy',
        'color': Color(0xFF000080),
        'image': 'assets/images/s25_plus_navy.png',
      },
    ],
  };

  // ========== XIAOMI SMARTPHONES ==========
  final Map<String, List<Map<String, dynamic>>> _xiaomiColorVariants = {
    'Xiaomi 15 Pro': [
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/xiaomi15_pro_black.png',
      },
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/xiaomi15_pro_white.png',
      },
    ],
    'Xiaomi 15': [
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/xiaomi15_black.png',
      },
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/xiaomi15_white.png',
      },
    ],
    'Xiaomi 14 Pro': [
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/xiaomi14_pro_black.png',
      },
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/xiaomi14_pro_silver.png',
      },
    ],
    'Xiaomi 14': [
      {
        'name': 'Green',
        'color': Color(0xFF228B22),
        'image': 'assets/images/xiaomi14_green.png',
      },
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/xiaomi14_white.png',
      },
    ],
    'Xiaomi 14T Pro': [
      {
        'name': 'Titanium Gray',
        'color': Color(0xFF8C8C8C),
        'image': 'assets/images/xiaomi14t_pro_gray.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/xiaomi14t_pro_black.png',
      },
    ],
    'Xiaomi 13T Pro': [
      {
        'name': 'Blue',
        'color': Color(0xFF007AFF),
        'image': 'assets/images/xiaomi13t_pro_blue.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/xiaomi13t_pro_black.png',
      },
    ],
    'Xiaomi 13': [
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/xiaomi13_black.png',
      },
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/xiaomi13_white.png',
      },
    ],
    'Xiaomi 12 Pro': [
      {
        'name': 'Light Blue',
        'color': Color(0xFF87CEEB),
        'image': 'assets/images/xiaomi12_pro_blue.png',
      },
      {
        'name': 'Purple',
        'color': Color(0xFF800080),
        'image': 'assets/images/xiaomi12_pro_purple.png',
      },
    ],
    'Xiaomi 12': [
      {
        'name': 'Blue',
        'color': Color(0xFF007AFF),
        'image': 'assets/images/xiaomi12_blue.png',
      },
      {
        'name': 'Gray',
        'color': Color(0xFF808080),
        'image': 'assets/images/xiaomi12_gray.png',
      },
    ],
    'Xiaomi Poco F6': [
      {
        'name': 'Rose Gold',
        'color': Color(0xFFE8B4B8),
        'image': 'assets/images/poco_f6_rosegold.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/poco_f6_black.png',
      },
    ],
  };

  // ========== OPPO SMARTPHONES ==========
  final Map<String, List<Map<String, dynamic>>> _oppoColorVariants = {
    'Oppo Find X8 Ultra': [
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/findx8_ultra_white.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/findx8_ultra_black.png',
      },
      {
        'name': 'Pink',
        'color': Color(0xFFFFB6C1),
        'image': 'assets/images/findx8_ultra_pink.png',
      },
    ],
    'Oppo Find X8 Pro': [
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/findx8_pro_black.png',
      },
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/findx8_pro_white.png',
      },
    ],
    'Oppo Find X8': [
      {
        'name': 'Light Pink',
        'color': Color(0xFFFFB6C1),
        'image': 'assets/images/findx8_pink.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/findx8_black.png',
      },
    ],
    'Oppo Find X7 Ultra': [
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/findx7_ultra_black.png',
      },
      {
        'name': 'Blue',
        'color': Color(0xFF007AFF),
        'image': 'assets/images/findx7_ultra_blue.png',
      },
    ],
    'Oppo Find X7': [
      {
        'name': 'Purple',
        'color': Color(0xFF800080),
        'image': 'assets/images/findx7_purple.png',
      },
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/findx7_white.png',
      },
    ],
    'Oppo Reno 13 Pro': [
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/reno13_pro_white.png',
      },
      {
        'name': 'Gray',
        'color': Color(0xFF808080),
        'image': 'assets/images/reno13_pro_gray.png',
      },
    ],
    'Oppo Reno 13': [
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/reno13_white.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/reno13_black.png',
      },
    ],
    'Oppo Reno 12 Pro': [
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/reno12_pro_silver.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/reno12_pro_black.png',
      },
    ],
    'Oppo Reno 12': [
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/reno12_silver.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/reno12_black.png',
      },
    ],
    'Oppo A79 5G': [
      {
        'name': 'Mint',
        'color': Color(0xFF98FF98),
        'image': 'assets/images/a79_5g_mint.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/a79_5g_black.png',
      },
    ],
  };

  // ========== ONEPLUS SMARTPHONES ==========
  final Map<String, List<Map<String, dynamic>>> _oneplusColorVariants = {
    'OnePlus 12': [
      {
        'name': 'Flowy Emerald',
        'color': Color(0xFF50C878),
        'image': 'assets/images/oneplus12_emerald.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/oneplus12_black.png',
      },
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/oneplus12_white.png',
      },
    ],
    'OnePlus 12R': [
      {
        'name': 'Light Blue',
        'color': Color(0xFF87CEEB),
        'image': 'assets/images/oneplus12r_blue.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/oneplus12r_black.png',
      },
    ],
    'OnePlus 11': [
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/oneplus11_black.png',
      },
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/oneplus11_silver.png',
      },
    ],
    'OnePlus Nord 4': [
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/nord4_silver.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/nord4_black.png',
      },
    ],
    'OnePlus Nord 3': [
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/nord3_black.png',
      },
      {
        'name': 'Green',
        'color': Color(0xFF00A86B),
        'image': 'assets/images/nord3_green.png',
      },
    ],
    'OnePlus Open': [
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/oneplus_open_black.png',
      },
      {
        'name': 'Green',
        'color': Color(0xFF00A86B),
        'image': 'assets/images/oneplus_open_green.png',
      },
    ],
  };

  // ========== VIVO SMARTPHONES ==========
  final Map<String, List<Map<String, dynamic>>> _vivoColorVariants = {
    'Vivo X100 Ultra': [
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/vivo_x100_ultra_white.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/vivo_x100_ultra_black.png',
      },
      {
        'name': 'Titanium',
        'color': Color(0xFF8C8C8C),
        'image': 'assets/images/vivo_x100_ultra_titanium.png',
      },
    ],
    'Vivo X100 Pro': [
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/vivo_x100_pro_black.png',
      },
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/vivo_x100_pro_white.png',
      },
    ],
    'Vivo X100': [
      {
        'name': 'Orange',
        'color': Color(0xFFFFA500),
        'image': 'assets/images/vivo_x100_orange.png',
      },
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/vivo_x100_silver.png',
      },
    ],
    'Vivo V40 Pro': [
      {
        'name': 'Grey',
        'color': Color(0xFF808080),
        'image': 'assets/images/vivo_v40_pro_grey.png',
      },
      {
        'name': 'Blue',
        'color': Color(0xFF007AFF),
        'image': 'assets/images/vivo_v40_pro_blue.png',
      },
    ],
    'Vivo V40': [
      {
        'name': 'Purple',
        'color': Color(0xFF800080),
        'image': 'assets/images/vivo_v40_purple.png',
      },
      {
        'name': 'Gray',
        'color': Color(0xFF808080),
        'image': 'assets/images/vivo_v40_gray.png',
      },
    ],
  };

  // ========== TABLETS ==========
  final Map<String, List<Map<String, dynamic>>> _tabletColorVariants = {
    'iPad Pro M4 13"': [
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/ipad_pro_m4_13_black.png',
      },
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/ipad_pro_m4_13_silver.png',
      },
    ],
    'iPad Pro M4 11"': [
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/ipad_pro_m4_11_black.png',
      },
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/ipad_pro_m4_11_silver.png',
      },
    ],
    'iPad Air M3': [
      {
        'name': 'Space Gray',
        'color': Color(0xFF2C2C2C),
        'image': 'assets/images/ipad_air_m3_gray.png',
      },
      {
        'name': 'Purple',
        'color': Color(0xFF800080),
        'image': 'assets/images/ipad_air_m3_purple.png',
      },
      {
        'name': 'Blue',
        'color': Color(0xFF007AFF),
        'image': 'assets/images/ipad_air_m3_blue.png',
      },
    ],
    'iPad 10th Gen': [
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/ipad_10th_silver.png',
      },
      {
        'name': 'Blue',
        'color': Color(0xFF007AFF),
        'image': 'assets/images/ipad_10th_blue.png',
      },
      {
        'name': 'Pink',
        'color': Color(0xFFFFB6C1),
        'image': 'assets/images/ipad_10th_pink.png',
      },
      {
        'name': 'Yellow',
        'color': Color(0xFFFFD700),
        'image': 'assets/images/ipad_10th_yellow.png',
      },
    ],
    'iPad Mini 7': [
      {
        'name': 'Space Gray',
        'color': Color(0xFF2C2C2C),
        'image': 'assets/images/ipad_mini7_gray.png',
      },
      {
        'name': 'Blue',
        'color': Color(0xFF007AFF),
        'image': 'assets/images/ipad_mini7_blue.png',
      },
      {
        'name': 'Pink',
        'color': Color(0xFFFFB6C1),
        'image': 'assets/images/ipad_mini7_pink.png',
      },
      {
        'name': 'Purple',
        'color': Color(0xFF800080),
        'image': 'assets/images/ipad_mini7_purple.png',
      },
    ],
    'iPad 9th Gen': [
      {
        'name': 'Space Gray',
        'color': Color(0xFF2C2C2C),
        'image': 'assets/images/ipad_9th_gray.png',
      },
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/ipad_9th_silver.png',
      },
    ],
    'Galaxy Tab S10 Ultra': [
      {
        'name': 'Titanium Black',
        'color': Color(0xFF1A1A1A),
        'image': 'assets/images/tab_s10_ultra_black.png',
      },
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/tab_s10_ultra_silver.png',
      },
    ],
    'Galaxy Tab S10 Plus': [
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/tab_s10_plus_silver.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/tab_s10_plus_black.png',
      },
    ],
    'Galaxy Tab S10': [
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/tab_s10_silver.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/tab_s10_black.png',
      },
    ],
    'Galaxy Tab S9 FE': [
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/tab_s9_fe_silver.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/tab_s9_fe_black.png',
      },
    ],
    'Galaxy Tab A9+': [
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/tab_a9_plus_silver.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/tab_a9_plus_black.png',
      },
    ],
    'Galaxy Tab A9': [
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/tab_a9_silver.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/tab_a9_black.png',
      },
    ],
    'Xiaomi Pad 7 Pro': [
      {
        'name': 'Green',
        'color': Color(0xFF00A86B),
        'image': 'assets/images/pad7_pro_green.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/pad7_pro_black.png',
      },
    ],
    'Xiaomi Pad 7': [
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/pad7_silver.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/pad7_black.png',
      },
    ],
    'Xiaomi Pad 6': [
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/pad6_silver.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/pad6_black.png',
      },
    ],
    'Xiaomi Pad 6S Pro': [
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/pad6s_pro_silver.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/pad6s_pro_black.png',
      },
    ],
    'Oppo Pad 4 Pro': [
      {
        'name': 'Pink',
        'color': Color(0xFFFFB6C1),
        'image': 'assets/images/pad4_pro_pink.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/pad4_pro_black.png',
      },
    ],
    'Oppo Pad 3 Pro': [
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/pad3_pro_silver.png',
      },
      {
        'name': 'Gold',
        'color': Color(0xFFD4AF37),
        'image': 'assets/images/pad3_pro_gold.png',
      },
    ],
    'Oppo Pad 3': [
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/pad3_silver.png',
      },
      {
        'name': 'Purple',
        'color': Color(0xFF800080),
        'image': 'assets/images/pad3_purple.png',
      },
    ],
    'OnePlus Pad 2': [
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/oneplus_pad2_silver.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/oneplus_pad2_black.png',
      },
    ],
    'OnePlus Pad': [
      {
        'name': 'Green',
        'color': Color(0xFF00A86B),
        'image': 'assets/images/oneplus_pad_green.png',
      },
      {
        'name': 'Gray',
        'color': Color(0xFF808080),
        'image': 'assets/images/oneplus_pad_gray.png',
      },
    ],
  };

  // ========== WEARABLES ==========
  final Map<String, List<Map<String, dynamic>>> _wearableColorVariants = {
    'Apple Watch Ultra 3': [
      {
        'name': 'Titanium',
        'color': Color(0xFF8C8C8C),
        'image': 'assets/images/watch_ultra3_titanium.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/watch_ultra3_black.png',
      },
    ],
    'Apple Watch Series 10': [
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/watch_series10_silver.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/watch_series10_black.png',
      },
      {
        'name': 'Rose Gold',
        'color': Color(0xFFE8B4B8),
        'image': 'assets/images/watch_series10_rosegold.png',
      },
    ],
    'Apple Watch SE 3': [
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/watch_se3_silver.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/watch_se3_black.png',
      },
    ],
    'Apple Watch Series 9': [
      {
        'name': 'Aluminium',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/watch_series9_aluminium.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/watch_series9_black.png',
      },
      {
        'name': 'Pink',
        'color': Color(0xFFFFB6C1),
        'image': 'assets/images/watch_series9_pink.png',
      },
    ],
    'Apple Watch Ultra 2': [
      {
        'name': 'Titanium',
        'color': Color(0xFF8C8C8C),
        'image': 'assets/images/watch_ultra2_titanium.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/watch_ultra2_black.png',
      },
    ],
    'Galaxy Watch 7 Ultra': [
      {
        'name': 'Titanium',
        'color': Color(0xFF8C8C8C),
        'image': 'assets/images/watch7_ultra_titanium.png',
      },
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/watch7_ultra_white.png',
      },
    ],
    'Galaxy Watch 7': [
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/watch7_silver.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/watch7_black.png',
      },
    ],
    'Galaxy Watch 7 Classic': [
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/watch7_classic_silver.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/watch7_classic_black.png',
      },
    ],
    'Galaxy Watch FE': [
      {
        'name': 'Light Blue',
        'color': Color(0xFF87CEEB),
        'image': 'assets/images/watch_fe_light_blue.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/watch_fe_black.png',
      },
    ],
    'Galaxy Watch 6': [
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/watch6_silver.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/watch6_black.png',
      },
    ],
    'Galaxy Watch 6 Classic': [
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/watch6_classic_silver.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/watch6_classic_black.png',
      },
    ],
    'Xiaomi Watch 3 Pro': [
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/watch3_pro_silver.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/watch3_pro_black.png',
      },
    ],
    'Xiaomi Watch 2 Pro': [
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/watch2_pro_silver.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/watch2_pro_black.png',
      },
    ],
    'Xiaomi Band 9': [
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/band9_silver.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/band9_black.png',
      },
    ],
    'Xiaomi Band 8 Pro': [
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/band8_pro_silver.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/band8_pro_black.png',
      },
    ],
    'Xiaomi Band 8': [
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/band8_silver.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/band8_black.png',
      },
    ],
    'Oppo Watch 5 Pro': [
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/watch5_pro_silver.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/watch5_pro_black.png',
      },
    ],
    'Oppo Watch 4 Pro': [
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/watch4_pro_silver.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/watch4_pro_black.png',
      },
    ],
    'Oppo Band 3': [
      {
        'name': 'Pink',
        'color': Color(0xFFFFB6C1),
        'image': 'assets/images/band3_pink.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/band3_black.png',
      },
    ],
  };

  // ========== ACCESSORIES ==========
  final Map<String, List<Map<String, dynamic>>> _accessoryColorVariants = {
    'AirPods Pro 3': [
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/airpods_pro3_white.png',
      },
    ],
    'AirPods Max 2': [
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/airpods_max2_silver.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/airpods_max2_black.png',
      },
      {
        'name': 'Blue',
        'color': Color(0xFF007AFF),
        'image': 'assets/images/airpods_max2_blue.png',
      },
    ],
    'AirPods 4': [
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/airpods4_white.png',
      },
    ],
    'AirPods Pro 2': [
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/airpods_pro2_white.png',
      },
    ],
    'MagSafe Battery Pack': [
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/magsafe_battery_white.png',
      },
    ],
    'Apple Pencil Pro': [
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/pencil_pro_white.png',
      },
    ],
    'Magic Keyboard': [
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/magic_keyboard_white.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/magic_keyboard_black.png',
      },
    ],
    'Galaxy Buds 3 Pro': [
      {
        'name': 'Silver',
        'color': Color(0xFFC0C0C0),
        'image': 'assets/images/buds3_pro_silver.png',
      },
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/buds3_pro_white.png',
      },
    ],
    'Galaxy Buds 3': [
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/buds3_white.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/buds3_black.png',
      },
    ],
    'Galaxy Buds 2 Pro': [
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/buds2_pro_white.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/buds2_pro_black.png',
      },
    ],
    'Galaxy S-Pen Pro': [
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/spen_pro_black.png',
      },
    ],
    'Galaxy Wireless Charger': [
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/wireless_charger_white.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/wireless_charger_black.png',
      },
    ],
    'Galaxy Smart Case': [
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/smart_case_black.png',
      },
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/smart_case_white.png',
      },
    ],
    'Xiaomi Buds 4 Pro': [
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/buds4_pro_black.png',
      },
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/buds4_pro_white.png',
      },
    ],
    'Xiaomi Buds 4': [
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/buds4_white.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/buds4_black.png',
      },
    ],
    'Xiaomi Buds 3 Pro': [
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/buds3_pro_white.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/buds3_pro_black.png',
      },
    ],
    'Xiaomi Power Bank 3': [
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/power_bank3_white.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/power_bank3_black.png',
      },
    ],
    'Xiaomi 67W Charger': [
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/67w_charger_white.png',
      },
    ],
    'Xiaomi Smart Band Strap': [
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/band_strap_black.png',
      },
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/band_strap_white.png',
      },
    ],
    'Oppo Enco X4': [
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/enco_x4_white.png',
      },
    ],
    'Oppo Enco X3': [
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/enco_x3_white.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/enco_x3_black.png',
      },
    ],
    'Oppo Enco Air 4': [
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/enco_air4_white.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/enco_air4_black.png',
      },
    ],
    'Oppo Enco Air 3': [
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/enco_air3_white.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/enco_air3_black.png',
      },
    ],
    'Oppo SuperVOOC Charger': [
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/supervooc_charger_white.png',
      },
    ],
    'OnePlus Buds Pro 3': [
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/oneplus_buds_pro3_black.png',
      },
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/oneplus_buds_pro3_white.png',
      },
    ],
    'OnePlus Buds 3': [
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/oneplus_buds3_white.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/oneplus_buds3_black.png',
      },
    ],
    'OnePlus Warp Charger': [
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/warp_charger_white.png',
      },
    ],
    'Vivo TWS 4': [
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/vivo_tws4_white.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/vivo_tws4_black.png',
      },
    ],
    'Vivo TWS 3': [
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/vivo_tws3_white.png',
      },
      {
        'name': 'Black',
        'color': Color(0xFF000000),
        'image': 'assets/images/vivo_tws3_black.png',
      },
    ],
    'Vivo 80W Charger': [
      {
        'name': 'White',
        'color': Color(0xFFFFFFFF),
        'image': 'assets/images/vivo_80w_charger_white.png',
      },
    ],
  };

  // ========== DEFAULT VARIANTS ==========
  final List<Map<String, dynamic>> _defaultColorVariants = [
    {
      'name': 'Black',
      'color': Color(0xFF000000),
      'image': 'assets/images/placeholder.png',
    },
    {
      'name': 'White',
      'color': Color(0xFFFFFFFF),
      'image': 'assets/images/placeholder.png',
    },
    {
      'name': 'Silver',
      'color': Color(0xFFC0C0C0),
      'image': 'assets/images/placeholder.png',
    },
  ];

  final List<Map<String, dynamic>> _storageVariants = [
    {'storage': '128GB', 'price': 999},
    {'storage': '256GB', 'price': 1099},
    {'storage': '512GB', 'price': 1299},
    {'storage': '1TB', 'price': 1499},
  ];

  // ========== GET COLOR VARIANTS ==========
  List<Map<String, dynamic>> get _colorVariants {
    final productName = widget.product['name']?.toString() ?? '';
    final category = widget.product['category']?.toString() ?? '';

    List<Map<String, dynamic>>? variants;

    // Check Apple
    if (productName.contains('iPhone')) {
      for (final entry in _appleColorVariants.entries) {
        if (productName.contains(entry.key)) {
          variants = entry.value;
          break;
        }
      }
      if (variants == null) {
        for (final entry in _appleColorVariants.entries) {
          if (entry.key.contains('iPhone') && productName.contains('iPhone')) {
            variants = entry.value;
            break;
          }
        }
      }
    }

    // Check Samsung
    if (productName.contains('Galaxy') && variants == null) {
      for (final entry in _samsungColorVariants.entries) {
        if (productName.contains(entry.key) ||
            entry.key.contains(productName)) {
          variants = entry.value;
          break;
        }
      }
    }

    // Check Xiaomi
    if (productName.contains('Xiaomi') && variants == null) {
      for (final entry in _xiaomiColorVariants.entries) {
        if (productName.contains(entry.key) ||
            entry.key.contains(productName)) {
          variants = entry.value;
          break;
        }
      }
    }

    // Check Oppo
    if ((productName.contains('Oppo') ||
            productName.contains('Find') ||
            productName.contains('Reno')) &&
        variants == null) {
      for (final entry in _oppoColorVariants.entries) {
        if (productName.contains(entry.key) ||
            entry.key.contains(productName)) {
          variants = entry.value;
          break;
        }
      }
    }

    // Check OnePlus
    if (productName.contains('OnePlus') && variants == null) {
      for (final entry in _oneplusColorVariants.entries) {
        if (productName.contains(entry.key) ||
            entry.key.contains(productName)) {
          variants = entry.value;
          break;
        }
      }
    }

    // Check Vivo
    if (productName.contains('Vivo') && variants == null) {
      for (final entry in _vivoColorVariants.entries) {
        if (productName.contains(entry.key) ||
            entry.key.contains(productName)) {
          variants = entry.value;
          break;
        }
      }
    }

    // Check Tablets
    if ((category == 'Tablets' ||
            productName.contains('Pad') ||
            productName.contains('iPad') ||
            productName.contains('Tab')) &&
        variants == null) {
      for (final entry in _tabletColorVariants.entries) {
        if (productName.contains(entry.key) ||
            entry.key.contains(productName)) {
          variants = entry.value;
          break;
        }
      }
      if (variants == null && productName.contains('iPad')) {
        for (final entry in _tabletColorVariants.entries) {
          if (entry.key.contains('iPad')) {
            variants = entry.value;
            break;
          }
        }
      }
    }

    // Check Wearables
    if ((category == 'Wearables' ||
            productName.contains('Watch') ||
            productName.contains('Band')) &&
        variants == null) {
      for (final entry in _wearableColorVariants.entries) {
        if (productName.contains(entry.key) ||
            entry.key.contains(productName)) {
          variants = entry.value;
          break;
        }
      }
    }

    // Check Accessories
    if ((category == 'Accessories' ||
            productName.contains('Buds') ||
            productName.contains('AirPods') ||
            productName.contains('Charger') ||
            productName.contains('Enco') ||
            productName.contains('Pencil') ||
            productName.contains('Keyboard') ||
            productName.contains('Case') ||
            productName.contains('S-Pen') ||
            productName.contains('Power Bank')) &&
        variants == null) {
      for (final entry in _accessoryColorVariants.entries) {
        if (productName.contains(entry.key) ||
            entry.key.contains(productName)) {
          variants = entry.value;
          break;
        }
      }
    }

    return variants ?? _defaultColorVariants;
  }

  // ========== HELPERS ==========
  int _getPriceAsInt() {
    final price = widget.product['price'];
    if (price == null) return 999;
    if (price is int) return price;
    if (price is String) {
      return int.tryParse(price.replaceAll('\$', '')) ?? 999;
    }
    return 999;
  }

  double _getRatingAsDouble() {
    final rating = widget.product['rating'];
    if (rating == null) return 4.5;
    if (rating is double) return rating;
    if (rating is int) return rating.toDouble();
    if (rating is String) {
      return double.tryParse(rating) ?? 4.5;
    }
    return 4.5;
  }

  // ========== GET PRODUCT SPECIFICATIONS ==========
  List<Map<String, dynamic>> _getProductSpecs() {
    final productName = widget.product['name']?.toString() ?? '';
    final brand = widget.product['brand']?.toString() ?? '';
    final category = widget.product['category']?.toString() ?? '';

    // iPhone 17 Pro Max
    if (productName == 'iPhone 17 Pro Max') {
      return [
        {
          'title': 'General',
          'items': [
            {'label': 'Brand', 'value': 'Apple'},
            {'label': 'Model', 'value': 'iPhone 17 Pro Max'},
            {'label': 'Release Date', 'value': 'September 2026'},
            {'label': 'Status', 'value': 'Available'},
          ],
        },
        {
          'title': 'Display',
          'items': [
            {'label': 'Type', 'value': 'Super Retina XDR OLED'},
            {'label': 'Size', 'value': '6.9 inches'},
            {'label': 'Resolution', 'value': '2796 x 1290 pixels'},
            {'label': 'Refresh Rate', 'value': '120Hz'},
            {'label': 'Brightness', 'value': '2000 nits (peak)'},
          ],
        },
        {
          'title': 'Performance',
          'items': [
            {'label': 'Processor', 'value': 'A19 Pro Chip'},
            {'label': 'CPU', 'value': '6-core CPU'},
            {'label': 'GPU', 'value': '6-core GPU'},
            {'label': 'Neural Engine', 'value': '16-core'},
          ],
        },
        {
          'title': 'Camera',
          'items': [
            {'label': 'Main Camera', 'value': '48MP Main'},
            {'label': 'Ultra Wide', 'value': '12MP'},
            {'label': 'Telephoto', 'value': '12MP'},
            {'label': 'LiDAR Scanner', 'value': 'Yes'},
            {'label': 'Video Recording', 'value': '8K at 60fps'},
          ],
        },
        {
          'title': 'Battery & Charging',
          'items': [
            {'label': 'Battery Capacity', 'value': '4,685 mAh'},
            {'label': 'Charging', 'value': 'Fast Charging'},
            {'label': 'Wireless Charging', 'value': 'Yes (MagSafe)'},
            {'label': 'Battery Life', 'value': 'Up to 29 hours'},
          ],
        },
        {
          'title': 'Connectivity',
          'items': [
            {'label': '5G', 'value': 'Yes'},
            {'label': 'Wi-Fi', 'value': 'Wi-Fi 7'},
            {'label': 'Bluetooth', 'value': '5.4'},
            {'label': 'NFC', 'value': 'Yes'},
            {'label': 'USB', 'value': 'USB-C 3.2'},
          ],
        },
        {
          'title': 'Sensors',
          'items': [
            {'label': 'Face ID', 'value': 'Yes'},
            {'label': 'Accelerometer', 'value': 'Yes'},
            {'label': 'Gyroscope', 'value': 'Yes'},
            {'label': 'Barometer', 'value': 'Yes'},
          ],
        },
      ];
    }

    // iPhone 17 Pro
    if (productName == 'iPhone 17 Pro') {
      return [
        {
          'title': 'General',
          'items': [
            {'label': 'Brand', 'value': 'Apple'},
            {'label': 'Model', 'value': 'iPhone 17 Pro'},
            {'label': 'Release Date', 'value': 'September 2026'},
            {'label': 'Status', 'value': 'Available'},
          ],
        },
        {
          'title': 'Display',
          'items': [
            {'label': 'Type', 'value': 'Super Retina XDR OLED'},
            {'label': 'Size', 'value': '6.3 inches'},
            {'label': 'Resolution', 'value': '2622 x 1206 pixels'},
            {'label': 'Refresh Rate', 'value': '120Hz'},
            {'label': 'Brightness', 'value': '2000 nits (peak)'},
          ],
        },
        {
          'title': 'Performance',
          'items': [
            {'label': 'Processor', 'value': 'A19 Pro Chip'},
            {'label': 'CPU', 'value': '6-core CPU'},
            {'label': 'GPU', 'value': '6-core GPU'},
            {'label': 'Neural Engine', 'value': '16-core'},
          ],
        },
        {
          'title': 'Camera',
          'items': [
            {'label': 'Main Camera', 'value': '48MP Main'},
            {'label': 'Ultra Wide', 'value': '12MP'},
            {'label': 'Telephoto', 'value': '12MP'},
            {'label': 'LiDAR Scanner', 'value': 'Yes'},
            {'label': 'Video Recording', 'value': '8K at 60fps'},
          ],
        },
        {
          'title': 'Battery & Charging',
          'items': [
            {'label': 'Battery Capacity', 'value': '4,000 mAh'},
            {'label': 'Charging', 'value': 'Fast Charging'},
            {'label': 'Wireless Charging', 'value': 'Yes (MagSafe)'},
            {'label': 'Battery Life', 'value': 'Up to 27 hours'},
          ],
        },
        {
          'title': 'Connectivity',
          'items': [
            {'label': '5G', 'value': 'Yes'},
            {'label': 'Wi-Fi', 'value': 'Wi-Fi 7'},
            {'label': 'Bluetooth', 'value': '5.4'},
            {'label': 'NFC', 'value': 'Yes'},
            {'label': 'USB', 'value': 'USB-C 3.2'},
          ],
        },
        {
          'title': 'Sensors',
          'items': [
            {'label': 'Face ID', 'value': 'Yes'},
            {'label': 'Accelerometer', 'value': 'Yes'},
            {'label': 'Gyroscope', 'value': 'Yes'},
            {'label': 'Barometer', 'value': 'Yes'},
          ],
        },
      ];
    }

    // iPhone 17
    if (productName == 'iPhone 17') {
      return [
        {
          'title': 'General',
          'items': [
            {'label': 'Brand', 'value': 'Apple'},
            {'label': 'Model', 'value': 'iPhone 17'},
            {'label': 'Release Date', 'value': 'September 2026'},
            {'label': 'Status', 'value': 'Available'},
          ],
        },
        {
          'title': 'Display',
          'items': [
            {'label': 'Type', 'value': 'Super Retina XDR OLED'},
            {'label': 'Size', 'value': '6.1 inches'},
            {'label': 'Resolution', 'value': '2532 x 1170 pixels'},
            {'label': 'Refresh Rate', 'value': '60Hz'},
            {'label': 'Brightness', 'value': '1600 nits (peak)'},
          ],
        },
        {
          'title': 'Performance',
          'items': [
            {'label': 'Processor', 'value': 'A19 Chip'},
            {'label': 'CPU', 'value': '6-core CPU'},
            {'label': 'GPU', 'value': '4-core GPU'},
            {'label': 'Neural Engine', 'value': '16-core'},
          ],
        },
        {
          'title': 'Camera',
          'items': [
            {'label': 'Main Camera', 'value': '48MP Main'},
            {'label': 'Ultra Wide', 'value': '12MP'},
            {'label': 'Video Recording', 'value': '4K at 60fps'},
          ],
        },
        {
          'title': 'Battery & Charging',
          'items': [
            {'label': 'Battery Capacity', 'value': '3,500 mAh'},
            {'label': 'Charging', 'value': 'Fast Charging'},
            {'label': 'Wireless Charging', 'value': 'Yes'},
            {'label': 'Battery Life', 'value': 'Up to 24 hours'},
          ],
        },
        {
          'title': 'Connectivity',
          'items': [
            {'label': '5G', 'value': 'Yes'},
            {'label': 'Wi-Fi', 'value': 'Wi-Fi 6'},
            {'label': 'Bluetooth', 'value': '5.3'},
            {'label': 'NFC', 'value': 'Yes'},
            {'label': 'USB', 'value': 'USB-C 2.0'},
          ],
        },
        {
          'title': 'Sensors',
          'items': [
            {'label': 'Face ID', 'value': 'Yes'},
            {'label': 'Accelerometer', 'value': 'Yes'},
            {'label': 'Gyroscope', 'value': 'Yes'},
            {'label': 'Barometer', 'value': 'Yes'},
          ],
        },
      ];
    }

    // iPhone 16 Pro Max
    if (productName == 'iPhone 16 Pro Max') {
      return [
        {
          'title': 'General',
          'items': [
            {'label': 'Brand', 'value': 'Apple'},
            {'label': 'Model', 'value': 'iPhone 16 Pro Max'},
            {'label': 'Release Date', 'value': 'September 2025'},
            {'label': 'Status', 'value': 'Available'},
          ],
        },
        {
          'title': 'Display',
          'items': [
            {'label': 'Type', 'value': 'Super Retina XDR OLED'},
            {'label': 'Size', 'value': '6.9 inches'},
            {'label': 'Resolution', 'value': '2796 x 1290 pixels'},
            {'label': 'Refresh Rate', 'value': '120Hz'},
            {'label': 'Brightness', 'value': '2000 nits (peak)'},
          ],
        },
        {
          'title': 'Performance',
          'items': [
            {'label': 'Processor', 'value': 'A18 Pro Chip'},
            {'label': 'CPU', 'value': '6-core CPU'},
            {'label': 'GPU', 'value': '6-core GPU'},
            {'label': 'Neural Engine', 'value': '16-core'},
          ],
        },
        {
          'title': 'Camera',
          'items': [
            {'label': 'Main Camera', 'value': '48MP Main'},
            {'label': 'Ultra Wide', 'value': '48MP'},
            {'label': 'Telephoto', 'value': '12MP (5x optical)'},
            {'label': 'LiDAR Scanner', 'value': 'Yes'},
            {'label': 'Video Recording', 'value': '4K at 120fps'},
          ],
        },
        {
          'title': 'Battery & Charging',
          'items': [
            {'label': 'Battery Capacity', 'value': '4,685 mAh'},
            {'label': 'Charging', 'value': 'Fast Charging'},
            {'label': 'Wireless Charging', 'value': 'Yes (MagSafe)'},
            {'label': 'Battery Life', 'value': 'Up to 29 hours'},
          ],
        },
        {
          'title': 'Connectivity',
          'items': [
            {'label': '5G', 'value': 'Yes'},
            {'label': 'Wi-Fi', 'value': 'Wi-Fi 7'},
            {'label': 'Bluetooth', 'value': '5.4'},
            {'label': 'NFC', 'value': 'Yes'},
            {'label': 'USB', 'value': 'USB-C 3.2'},
          ],
        },
        {
          'title': 'Sensors',
          'items': [
            {'label': 'Face ID', 'value': 'Yes'},
            {'label': 'Accelerometer', 'value': 'Yes'},
            {'label': 'Gyroscope', 'value': 'Yes'},
            {'label': 'Barometer', 'value': 'Yes'},
          ],
        },
      ];
    }

    // iPhone 16 Pro
    if (productName == 'iPhone 16 Pro') {
      return [
        {
          'title': 'General',
          'items': [
            {'label': 'Brand', 'value': 'Apple'},
            {'label': 'Model', 'value': 'iPhone 16 Pro'},
            {'label': 'Release Date', 'value': 'September 2025'},
            {'label': 'Status', 'value': 'Available'},
          ],
        },
        {
          'title': 'Display',
          'items': [
            {'label': 'Type', 'value': 'Super Retina XDR OLED'},
            {'label': 'Size', 'value': '6.3 inches'},
            {'label': 'Resolution', 'value': '2622 x 1206 pixels'},
            {'label': 'Refresh Rate', 'value': '120Hz'},
            {'label': 'Brightness', 'value': '2000 nits (peak)'},
          ],
        },
        {
          'title': 'Performance',
          'items': [
            {'label': 'Processor', 'value': 'A18 Pro Chip'},
            {'label': 'CPU', 'value': '6-core CPU'},
            {'label': 'GPU', 'value': '6-core GPU'},
            {'label': 'Neural Engine', 'value': '16-core'},
          ],
        },
        {
          'title': 'Camera',
          'items': [
            {'label': 'Main Camera', 'value': '48MP Main'},
            {'label': 'Ultra Wide', 'value': '48MP'},
            {'label': 'Telephoto', 'value': '12MP (5x optical)'},
            {'label': 'LiDAR Scanner', 'value': 'Yes'},
            {'label': 'Video Recording', 'value': '4K at 120fps'},
          ],
        },
        {
          'title': 'Battery & Charging',
          'items': [
            {'label': 'Battery Capacity', 'value': '4,000 mAh'},
            {'label': 'Charging', 'value': 'Fast Charging'},
            {'label': 'Wireless Charging', 'value': 'Yes (MagSafe)'},
            {'label': 'Battery Life', 'value': 'Up to 27 hours'},
          ],
        },
        {
          'title': 'Connectivity',
          'items': [
            {'label': '5G', 'value': 'Yes'},
            {'label': 'Wi-Fi', 'value': 'Wi-Fi 7'},
            {'label': 'Bluetooth', 'value': '5.4'},
            {'label': 'NFC', 'value': 'Yes'},
            {'label': 'USB', 'value': 'USB-C 3.2'},
          ],
        },
        {
          'title': 'Sensors',
          'items': [
            {'label': 'Face ID', 'value': 'Yes'},
            {'label': 'Accelerometer', 'value': 'Yes'},
            {'label': 'Gyroscope', 'value': 'Yes'},
            {'label': 'Barometer', 'value': 'Yes'},
          ],
        },
      ];
    }

    // iPhone 16 Plus
    if (productName == 'iPhone 16 Plus') {
      return [
        {
          'title': 'General',
          'items': [
            {'label': 'Brand', 'value': 'Apple'},
            {'label': 'Model', 'value': 'iPhone 16 Plus'},
            {'label': 'Release Date', 'value': 'September 2025'},
            {'label': 'Status', 'value': 'Available'},
          ],
        },
        {
          'title': 'Display',
          'items': [
            {'label': 'Type', 'value': 'Super Retina XDR OLED'},
            {'label': 'Size', 'value': '6.7 inches'},
            {'label': 'Resolution', 'value': '2796 x 1290 pixels'},
            {'label': 'Refresh Rate', 'value': '60Hz'},
            {'label': 'Brightness', 'value': '1600 nits (peak)'},
          ],
        },
        {
          'title': 'Performance',
          'items': [
            {'label': 'Processor', 'value': 'A18 Chip'},
            {'label': 'CPU', 'value': '6-core CPU'},
            {'label': 'GPU', 'value': '4-core GPU'},
            {'label': 'Neural Engine', 'value': '16-core'},
          ],
        },
        {
          'title': 'Camera',
          'items': [
            {'label': 'Main Camera', 'value': '48MP Main'},
            {'label': 'Ultra Wide', 'value': '12MP'},
            {'label': 'Video Recording', 'value': '4K at 60fps'},
          ],
        },
        {
          'title': 'Battery & Charging',
          'items': [
            {'label': 'Battery Capacity', 'value': '4,674 mAh'},
            {'label': 'Charging', 'value': 'Fast Charging'},
            {'label': 'Wireless Charging', 'value': 'Yes'},
            {'label': 'Battery Life', 'value': 'Up to 26 hours'},
          ],
        },
        {
          'title': 'Connectivity',
          'items': [
            {'label': '5G', 'value': 'Yes'},
            {'label': 'Wi-Fi', 'value': 'Wi-Fi 6'},
            {'label': 'Bluetooth', 'value': '5.3'},
            {'label': 'NFC', 'value': 'Yes'},
            {'label': 'USB', 'value': 'USB-C 2.0'},
          ],
        },
        {
          'title': 'Sensors',
          'items': [
            {'label': 'Face ID', 'value': 'Yes'},
            {'label': 'Accelerometer', 'value': 'Yes'},
            {'label': 'Gyroscope', 'value': 'Yes'},
            {'label': 'Barometer', 'value': 'Yes'},
          ],
        },
      ];
    }

    // iPhone 16
    if (productName == 'iPhone 16') {
      return [
        {
          'title': 'General',
          'items': [
            {'label': 'Brand', 'value': 'Apple'},
            {'label': 'Model', 'value': 'iPhone 16'},
            {'label': 'Release Date', 'value': 'September 2025'},
            {'label': 'Status', 'value': 'Available'},
          ],
        },
        {
          'title': 'Display',
          'items': [
            {'label': 'Type', 'value': 'Super Retina XDR OLED'},
            {'label': 'Size', 'value': '6.1 inches'},
            {'label': 'Resolution', 'value': '2532 x 1170 pixels'},
            {'label': 'Refresh Rate', 'value': '60Hz'},
            {'label': 'Brightness', 'value': '1600 nits (peak)'},
          ],
        },
        {
          'title': 'Performance',
          'items': [
            {'label': 'Processor', 'value': 'A18 Chip'},
            {'label': 'CPU', 'value': '6-core CPU'},
            {'label': 'GPU', 'value': '4-core GPU'},
            {'label': 'Neural Engine', 'value': '16-core'},
          ],
        },
        {
          'title': 'Camera',
          'items': [
            {'label': 'Main Camera', 'value': '48MP Main'},
            {'label': 'Ultra Wide', 'value': '12MP'},
            {'label': 'Video Recording', 'value': '4K at 60fps'},
          ],
        },
        {
          'title': 'Battery & Charging',
          'items': [
            {'label': 'Battery Capacity', 'value': '3,561 mAh'},
            {'label': 'Charging', 'value': 'Fast Charging'},
            {'label': 'Wireless Charging', 'value': 'Yes'},
            {'label': 'Battery Life', 'value': 'Up to 22 hours'},
          ],
        },
        {
          'title': 'Connectivity',
          'items': [
            {'label': '5G', 'value': 'Yes'},
            {'label': 'Wi-Fi', 'value': 'Wi-Fi 6'},
            {'label': 'Bluetooth', 'value': '5.3'},
            {'label': 'NFC', 'value': 'Yes'},
            {'label': 'USB', 'value': 'USB-C 2.0'},
          ],
        },
        {
          'title': 'Sensors',
          'items': [
            {'label': 'Face ID', 'value': 'Yes'},
            {'label': 'Accelerometer', 'value': 'Yes'},
            {'label': 'Gyroscope', 'value': 'Yes'},
            {'label': 'Barometer', 'value': 'Yes'},
          ],
        },
      ];
    }

    // iPhone 15 Pro Max
    if (productName == 'iPhone 15 Pro Max') {
      return [
        {
          'title': 'General',
          'items': [
            {'label': 'Brand', 'value': 'Apple'},
            {'label': 'Model', 'value': 'iPhone 15 Pro Max'},
            {'label': 'Release Date', 'value': 'September 2024'},
            {'label': 'Status', 'value': 'Available'},
          ],
        },
        {
          'title': 'Display',
          'items': [
            {'label': 'Type', 'value': 'Super Retina XDR OLED'},
            {'label': 'Size', 'value': '6.7 inches'},
            {'label': 'Resolution', 'value': '2796 x 1290 pixels'},
            {'label': 'Refresh Rate', 'value': '120Hz'},
            {'label': 'Brightness', 'value': '2000 nits (peak)'},
          ],
        },
        {
          'title': 'Performance',
          'items': [
            {'label': 'Processor', 'value': 'A17 Pro Chip'},
            {'label': 'CPU', 'value': '6-core CPU'},
            {'label': 'GPU', 'value': '6-core GPU'},
            {'label': 'Neural Engine', 'value': '16-core'},
          ],
        },
        {
          'title': 'Camera',
          'items': [
            {'label': 'Main Camera', 'value': '48MP Main'},
            {'label': 'Ultra Wide', 'value': '12MP'},
            {'label': 'Telephoto', 'value': '12MP (5x optical)'},
            {'label': 'LiDAR Scanner', 'value': 'Yes'},
            {'label': 'Video Recording', 'value': '4K at 60fps'},
          ],
        },
        {
          'title': 'Battery & Charging',
          'items': [
            {'label': 'Battery Capacity', 'value': '4,441 mAh'},
            {'label': 'Charging', 'value': 'Fast Charging'},
            {'label': 'Wireless Charging', 'value': 'Yes (MagSafe)'},
            {'label': 'Battery Life', 'value': 'Up to 29 hours'},
          ],
        },
        {
          'title': 'Connectivity',
          'items': [
            {'label': '5G', 'value': 'Yes'},
            {'label': 'Wi-Fi', 'value': 'Wi-Fi 6E'},
            {'label': 'Bluetooth', 'value': '5.3'},
            {'label': 'NFC', 'value': 'Yes'},
            {'label': 'USB', 'value': 'USB-C 3.0'},
          ],
        },
        {
          'title': 'Sensors',
          'items': [
            {'label': 'Face ID', 'value': 'Yes'},
            {'label': 'Accelerometer', 'value': 'Yes'},
            {'label': 'Gyroscope', 'value': 'Yes'},
            {'label': 'Barometer', 'value': 'Yes'},
          ],
        },
      ];
    }

    // iPhone 15 Pro
    if (productName == 'iPhone 15 Pro') {
      return [
        {
          'title': 'General',
          'items': [
            {'label': 'Brand', 'value': 'Apple'},
            {'label': 'Model', 'value': 'iPhone 15 Pro'},
            {'label': 'Release Date', 'value': 'September 2024'},
            {'label': 'Status', 'value': 'Available'},
          ],
        },
        {
          'title': 'Display',
          'items': [
            {'label': 'Type', 'value': 'Super Retina XDR OLED'},
            {'label': 'Size', 'value': '6.1 inches'},
            {'label': 'Resolution', 'value': '2556 x 1179 pixels'},
            {'label': 'Refresh Rate', 'value': '120Hz'},
            {'label': 'Brightness', 'value': '2000 nits (peak)'},
          ],
        },
        {
          'title': 'Performance',
          'items': [
            {'label': 'Processor', 'value': 'A17 Pro Chip'},
            {'label': 'CPU', 'value': '6-core CPU'},
            {'label': 'GPU', 'value': '6-core GPU'},
            {'label': 'Neural Engine', 'value': '16-core'},
          ],
        },
        {
          'title': 'Camera',
          'items': [
            {'label': 'Main Camera', 'value': '48MP Main'},
            {'label': 'Ultra Wide', 'value': '12MP'},
            {'label': 'Telephoto', 'value': '12MP (3x optical)'},
            {'label': 'LiDAR Scanner', 'value': 'Yes'},
            {'label': 'Video Recording', 'value': '4K at 60fps'},
          ],
        },
        {
          'title': 'Battery & Charging',
          'items': [
            {'label': 'Battery Capacity', 'value': '3,274 mAh'},
            {'label': 'Charging', 'value': 'Fast Charging'},
            {'label': 'Wireless Charging', 'value': 'Yes (MagSafe)'},
            {'label': 'Battery Life', 'value': 'Up to 23 hours'},
          ],
        },
        {
          'title': 'Connectivity',
          'items': [
            {'label': '5G', 'value': 'Yes'},
            {'label': 'Wi-Fi', 'value': 'Wi-Fi 6E'},
            {'label': 'Bluetooth', 'value': '5.3'},
            {'label': 'NFC', 'value': 'Yes'},
            {'label': 'USB', 'value': 'USB-C 3.0'},
          ],
        },
        {
          'title': 'Sensors',
          'items': [
            {'label': 'Face ID', 'value': 'Yes'},
            {'label': 'Accelerometer', 'value': 'Yes'},
            {'label': 'Gyroscope', 'value': 'Yes'},
            {'label': 'Barometer', 'value': 'Yes'},
          ],
        },
      ];
    }

    // iPhone 15
    if (productName == 'iPhone 15') {
      return [
        {
          'title': 'General',
          'items': [
            {'label': 'Brand', 'value': 'Apple'},
            {'label': 'Model', 'value': 'iPhone 15'},
            {'label': 'Release Date', 'value': 'September 2024'},
            {'label': 'Status', 'value': 'Available'},
          ],
        },
        {
          'title': 'Display',
          'items': [
            {'label': 'Type', 'value': 'Super Retina XDR OLED'},
            {'label': 'Size', 'value': '6.1 inches'},
            {'label': 'Resolution', 'value': '2556 x 1179 pixels'},
            {'label': 'Refresh Rate', 'value': '60Hz'},
            {'label': 'Brightness', 'value': '1600 nits (peak)'},
          ],
        },
        {
          'title': 'Performance',
          'items': [
            {'label': 'Processor', 'value': 'A16 Bionic'},
            {'label': 'CPU', 'value': '6-core CPU'},
            {'label': 'GPU', 'value': '5-core GPU'},
            {'label': 'Neural Engine', 'value': '16-core'},
          ],
        },
        {
          'title': 'Camera',
          'items': [
            {'label': 'Main Camera', 'value': '48MP Main'},
            {'label': 'Ultra Wide', 'value': '12MP'},
            {'label': 'Video Recording', 'value': '4K at 60fps'},
          ],
        },
        {
          'title': 'Battery & Charging',
          'items': [
            {'label': 'Battery Capacity', 'value': '3,349 mAh'},
            {'label': 'Charging', 'value': 'Fast Charging'},
            {'label': 'Wireless Charging', 'value': 'Yes'},
            {'label': 'Battery Life', 'value': 'Up to 20 hours'},
          ],
        },
        {
          'title': 'Connectivity',
          'items': [
            {'label': '5G', 'value': 'Yes'},
            {'label': 'Wi-Fi', 'value': 'Wi-Fi 6'},
            {'label': 'Bluetooth', 'value': '5.3'},
            {'label': 'NFC', 'value': 'Yes'},
            {'label': 'USB', 'value': 'USB-C 2.0'},
          ],
        },
        {
          'title': 'Sensors',
          'items': [
            {'label': 'Face ID', 'value': 'Yes'},
            {'label': 'Accelerometer', 'value': 'Yes'},
            {'label': 'Gyroscope', 'value': 'Yes'},
            {'label': 'Barometer', 'value': 'Yes'},
          ],
        },
      ];
    }

    // iPhone XR
    if (productName == 'iPhone XR') {
      return [
        {
          'title': 'General',
          'items': [
            {'label': 'Brand', 'value': 'Apple'},
            {'label': 'Model', 'value': 'iPhone XR'},
            {'label': 'Release Date', 'value': 'October 2018'},
            {'label': 'Status', 'value': 'Discontinued'},
          ],
        },
        {
          'title': 'Display',
          'items': [
            {'label': 'Type', 'value': 'Liquid Retina IPS LCD'},
            {'label': 'Size', 'value': '6.1 inches'},
            {'label': 'Resolution', 'value': '1792 x 828 pixels'},
            {'label': 'Refresh Rate', 'value': '60Hz'},
            {'label': 'Brightness', 'value': '625 nits (peak)'},
          ],
        },
        {
          'title': 'Performance',
          'items': [
            {'label': 'Processor', 'value': 'A12 Bionic'},
            {'label': 'CPU', 'value': '6-core CPU'},
            {'label': 'GPU', 'value': '4-core GPU'},
            {'label': 'Neural Engine', 'value': '8-core'},
          ],
        },
        {
          'title': 'Camera',
          'items': [
            {'label': 'Main Camera', 'value': '12MP Main'},
            {'label': 'Video Recording', 'value': '4K at 60fps'},
          ],
        },
        {
          'title': 'Battery & Charging',
          'items': [
            {'label': 'Battery Capacity', 'value': '2,942 mAh'},
            {'label': 'Charging', 'value': 'Fast Charging'},
            {'label': 'Wireless Charging', 'value': 'Yes (Qi)'},
            {'label': 'Battery Life', 'value': 'Up to 25 hours'},
          ],
        },
        {
          'title': 'Connectivity',
          'items': [
            {'label': '4G LTE', 'value': 'Yes'},
            {'label': 'Wi-Fi', 'value': 'Wi-Fi 5'},
            {'label': 'Bluetooth', 'value': '5.0'},
            {'label': 'NFC', 'value': 'Yes'},
            {'label': 'USB', 'value': 'Lightning'},
          ],
        },
        {
          'title': 'Sensors',
          'items': [
            {'label': 'Face ID', 'value': 'Yes'},
            {'label': 'Accelerometer', 'value': 'Yes'},
            {'label': 'Gyroscope', 'value': 'Yes'},
            {'label': 'Barometer', 'value': 'Yes'},
          ],
        },
      ];
    }

    // iPhone XS Max
    if (productName == 'iPhone XS Max') {
      return [
        {
          'title': 'General',
          'items': [
            {'label': 'Brand', 'value': 'Apple'},
            {'label': 'Model', 'value': 'iPhone XS Max'},
            {'label': 'Release Date', 'value': 'September 2018'},
            {'label': 'Status', 'value': 'Discontinued'},
          ],
        },
        {
          'title': 'Display',
          'items': [
            {'label': 'Type', 'value': 'Super Retina OLED'},
            {'label': 'Size', 'value': '6.5 inches'},
            {'label': 'Resolution', 'value': '2688 x 1242 pixels'},
            {'label': 'Refresh Rate', 'value': '60Hz'},
            {'label': 'Brightness', 'value': '625 nits (peak)'},
          ],
        },
        {
          'title': 'Performance',
          'items': [
            {'label': 'Processor', 'value': 'A12 Bionic'},
            {'label': 'CPU', 'value': '6-core CPU'},
            {'label': 'GPU', 'value': '4-core GPU'},
            {'label': 'Neural Engine', 'value': '8-core'},
          ],
        },
        {
          'title': 'Camera',
          'items': [
            {'label': 'Main Camera', 'value': '12MP Dual Camera'},
            {'label': 'Telephoto', 'value': '12MP'},
            {'label': 'Video Recording', 'value': '4K at 60fps'},
          ],
        },
        {
          'title': 'Battery & Charging',
          'items': [
            {'label': 'Battery Capacity', 'value': '3,174 mAh'},
            {'label': 'Charging', 'value': 'Fast Charging'},
            {'label': 'Wireless Charging', 'value': 'Yes (Qi)'},
            {'label': 'Battery Life', 'value': 'Up to 24 hours'},
          ],
        },
        {
          'title': 'Connectivity',
          'items': [
            {'label': '4G LTE', 'value': 'Yes'},
            {'label': 'Wi-Fi', 'value': 'Wi-Fi 5'},
            {'label': 'Bluetooth', 'value': '5.0'},
            {'label': 'NFC', 'value': 'Yes'},
            {'label': 'USB', 'value': 'Lightning'},
          ],
        },
        {
          'title': 'Sensors',
          'items': [
            {'label': 'Face ID', 'value': 'Yes'},
            {'label': 'Accelerometer', 'value': 'Yes'},
            {'label': 'Gyroscope', 'value': 'Yes'},
            {'label': 'Barometer', 'value': 'Yes'},
          ],
        },
      ];
    }

    // Galaxy S26 Ultra
    if (productName == 'Galaxy S26 Ultra') {
      return [
        {
          'title': 'General',
          'items': [
            {'label': 'Brand', 'value': 'Samsung'},
            {'label': 'Model', 'value': 'Galaxy S26 Ultra'},
            {'label': 'Release Date', 'value': 'February 2026'},
            {'label': 'Status', 'value': 'Available'},
          ],
        },
        {
          'title': 'Display',
          'items': [
            {'label': 'Type', 'value': 'Dynamic AMOLED 2X'},
            {'label': 'Size', 'value': '6.8 inches'},
            {'label': 'Resolution', 'value': '3088 x 1440 pixels'},
            {'label': 'Refresh Rate', 'value': '120Hz'},
            {'label': 'Brightness', 'value': '2600 nits (peak)'},
          ],
        },
        {
          'title': 'Performance',
          'items': [
            {'label': 'Processor', 'value': 'Snapdragon 8 Gen 4'},
            {'label': 'CPU', 'value': 'Octa-core'},
            {'label': 'GPU', 'value': 'Adreno 760'},
            {'label': 'RAM', 'value': '12GB/16GB'},
          ],
        },
        {
          'title': 'Camera',
          'items': [
            {'label': 'Main Camera', 'value': '200MP Main'},
            {'label': 'Ultra Wide', 'value': '50MP'},
            {'label': 'Telephoto', 'value': '50MP (10x optical)'},
            {'label': 'Periscope', 'value': '50MP (5x optical)'},
            {'label': 'Video Recording', 'value': '8K at 60fps'},
          ],
        },
        {
          'title': 'Battery & Charging',
          'items': [
            {'label': 'Battery Capacity', 'value': '5,000 mAh'},
            {'label': 'Charging', 'value': '65W Fast Charging'},
            {'label': 'Wireless Charging', 'value': 'Yes'},
            {'label': 'Battery Life', 'value': 'Up to 31 hours'},
          ],
        },
        {
          'title': 'Connectivity',
          'items': [
            {'label': '5G', 'value': 'Yes'},
            {'label': 'Wi-Fi', 'value': 'Wi-Fi 7'},
            {'label': 'Bluetooth', 'value': '5.4'},
            {'label': 'NFC', 'value': 'Yes'},
            {'label': 'USB', 'value': 'USB-C 3.2'},
          ],
        },
        {
          'title': 'Sensors',
          'items': [
            {'label': 'Fingerprint', 'value': 'Ultrasonic Under-Display'},
            {'label': 'Accelerometer', 'value': 'Yes'},
            {'label': 'Gyroscope', 'value': 'Yes'},
            {'label': 'Barometer', 'value': 'Yes'},
          ],
        },
      ];
    }

    // Galaxy S26 Plus
    if (productName == 'Galaxy S26 Plus') {
      return [
        {
          'title': 'General',
          'items': [
            {'label': 'Brand', 'value': 'Samsung'},
            {'label': 'Model', 'value': 'Galaxy S26 Plus'},
            {'label': 'Release Date', 'value': 'February 2026'},
            {'label': 'Status', 'value': 'Available'},
          ],
        },
        {
          'title': 'Display',
          'items': [
            {'label': 'Type', 'value': 'Dynamic AMOLED 2X'},
            {'label': 'Size', 'value': '6.7 inches'},
            {'label': 'Resolution', 'value': '3120 x 1440 pixels'},
            {'label': 'Refresh Rate', 'value': '120Hz'},
            {'label': 'Brightness', 'value': '2600 nits (peak)'},
          ],
        },
        {
          'title': 'Performance',
          'items': [
            {'label': 'Processor', 'value': 'Snapdragon 8 Gen 4'},
            {'label': 'CPU', 'value': 'Octa-core'},
            {'label': 'GPU', 'value': 'Adreno 760'},
            {'label': 'RAM', 'value': '12GB'},
          ],
        },
        {
          'title': 'Camera',
          'items': [
            {'label': 'Main Camera', 'value': '50MP Main'},
            {'label': 'Ultra Wide', 'value': '12MP'},
            {'label': 'Telephoto', 'value': '10MP (3x optical)'},
            {'label': 'Video Recording', 'value': '8K at 30fps'},
          ],
        },
        {
          'title': 'Battery & Charging',
          'items': [
            {'label': 'Battery Capacity', 'value': '4,900 mAh'},
            {'label': 'Charging', 'value': '45W Fast Charging'},
            {'label': 'Wireless Charging', 'value': 'Yes'},
            {'label': 'Battery Life', 'value': 'Up to 29 hours'},
          ],
        },
        {
          'title': 'Connectivity',
          'items': [
            {'label': '5G', 'value': 'Yes'},
            {'label': 'Wi-Fi', 'value': 'Wi-Fi 7'},
            {'label': 'Bluetooth', 'value': '5.4'},
            {'label': 'NFC', 'value': 'Yes'},
            {'label': 'USB', 'value': 'USB-C 3.2'},
          ],
        },
        {
          'title': 'Sensors',
          'items': [
            {'label': 'Fingerprint', 'value': 'Ultrasonic Under-Display'},
            {'label': 'Accelerometer', 'value': 'Yes'},
            {'label': 'Gyroscope', 'value': 'Yes'},
            {'label': 'Barometer', 'value': 'Yes'},
          ],
        },
      ];
    }

    // Galaxy S26
    if (productName == 'Galaxy S26') {
      return [
        {
          'title': 'General',
          'items': [
            {'label': 'Brand', 'value': 'Samsung'},
            {'label': 'Model', 'value': 'Galaxy S26'},
            {'label': 'Release Date', 'value': 'February 2026'},
            {'label': 'Status', 'value': 'Available'},
          ],
        },
        {
          'title': 'Display',
          'items': [
            {'label': 'Type', 'value': 'Dynamic AMOLED 2X'},
            {'label': 'Size', 'value': '6.2 inches'},
            {'label': 'Resolution', 'value': '2340 x 1080 pixels'},
            {'label': 'Refresh Rate', 'value': '120Hz'},
            {'label': 'Brightness', 'value': '2600 nits (peak)'},
          ],
        },
        {
          'title': 'Performance',
          'items': [
            {'label': 'Processor', 'value': 'Snapdragon 8 Gen 4'},
            {'label': 'CPU', 'value': 'Octa-core'},
            {'label': 'GPU', 'value': 'Adreno 760'},
            {'label': 'RAM', 'value': '8GB'},
          ],
        },
        {
          'title': 'Camera',
          'items': [
            {'label': 'Main Camera', 'value': '50MP Main'},
            {'label': 'Ultra Wide', 'value': '12MP'},
            {'label': 'Video Recording', 'value': '8K at 30fps'},
          ],
        },
        {
          'title': 'Battery & Charging',
          'items': [
            {'label': 'Battery Capacity', 'value': '4,000 mAh'},
            {'label': 'Charging', 'value': '25W Fast Charging'},
            {'label': 'Wireless Charging', 'value': 'Yes'},
            {'label': 'Battery Life', 'value': 'Up to 24 hours'},
          ],
        },
        {
          'title': 'Connectivity',
          'items': [
            {'label': '5G', 'value': 'Yes'},
            {'label': 'Wi-Fi', 'value': 'Wi-Fi 6'},
            {'label': 'Bluetooth', 'value': '5.3'},
            {'label': 'NFC', 'value': 'Yes'},
            {'label': 'USB', 'value': 'USB-C 3.2'},
          ],
        },
        {
          'title': 'Sensors',
          'items': [
            {'label': 'Fingerprint', 'value': 'Optical Under-Display'},
            {'label': 'Accelerometer', 'value': 'Yes'},
            {'label': 'Gyroscope', 'value': 'Yes'},
            {'label': 'Barometer', 'value': 'Yes'},
          ],
        },
      ];
    }

    // Galaxy Z Fold 7
    if (productName == 'Galaxy Z Fold 7') {
      return [
        {
          'title': 'General',
          'items': [
            {'label': 'Brand', 'value': 'Samsung'},
            {'label': 'Model', 'value': 'Galaxy Z Fold 7'},
            {'label': 'Release Date', 'value': 'August 2026'},
            {'label': 'Status', 'value': 'Available'},
          ],
        },
        {
          'title': 'Display',
          'items': [
            {'label': 'Type (Main)', 'value': 'Dynamic AMOLED 2X'},
            {'label': 'Size (Main)', 'value': '7.6 inches'},
            {'label': 'Type (Cover)', 'value': 'Dynamic AMOLED 2X'},
            {'label': 'Size (Cover)', 'value': '6.3 inches'},
            {'label': 'Refresh Rate', 'value': '120Hz'},
            {'label': 'Brightness', 'value': '2600 nits (peak)'},
          ],
        },
        {
          'title': 'Performance',
          'items': [
            {'label': 'Processor', 'value': 'Snapdragon 8 Gen 4'},
            {'label': 'CPU', 'value': 'Octa-core'},
            {'label': 'GPU', 'value': 'Adreno 760'},
            {'label': 'RAM', 'value': '16GB'},
          ],
        },
        {
          'title': 'Camera',
          'items': [
            {'label': 'Main Camera', 'value': '200MP Main'},
            {'label': 'Ultra Wide', 'value': '50MP'},
            {'label': 'Telephoto', 'value': '10MP (3x optical)'},
            {'label': 'Video Recording', 'value': '8K at 60fps'},
          ],
        },
        {
          'title': 'Battery & Charging',
          'items': [
            {'label': 'Battery Capacity', 'value': '4,800 mAh'},
            {'label': 'Charging', 'value': '45W Fast Charging'},
            {'label': 'Wireless Charging', 'value': 'Yes'},
            {'label': 'Battery Life', 'value': 'Up to 28 hours'},
          ],
        },
        {
          'title': 'Connectivity',
          'items': [
            {'label': '5G', 'value': 'Yes'},
            {'label': 'Wi-Fi', 'value': 'Wi-Fi 7'},
            {'label': 'Bluetooth', 'value': '5.4'},
            {'label': 'NFC', 'value': 'Yes'},
            {'label': 'USB', 'value': 'USB-C 3.2'},
          ],
        },
        {
          'title': 'Sensors',
          'items': [
            {'label': 'Fingerprint', 'value': 'Side-mounted'},
            {'label': 'Accelerometer', 'value': 'Yes'},
            {'label': 'Gyroscope', 'value': 'Yes'},
            {'label': 'Barometer', 'value': 'Yes'},
          ],
        },
      ];
    }

    // Galaxy Z Flip 7
    if (productName == 'Galaxy Z Flip 7') {
      return [
        {
          'title': 'General',
          'items': [
            {'label': 'Brand', 'value': 'Samsung'},
            {'label': 'Model', 'value': 'Galaxy Z Flip 7'},
            {'label': 'Release Date', 'value': 'August 2026'},
            {'label': 'Status', 'value': 'Available'},
          ],
        },
        {
          'title': 'Display',
          'items': [
            {'label': 'Type (Main)', 'value': 'Dynamic AMOLED 2X'},
            {'label': 'Size (Main)', 'value': '6.7 inches'},
            {'label': 'Type (Cover)', 'value': 'Super AMOLED'},
            {'label': 'Size (Cover)', 'value': '3.4 inches'},
            {'label': 'Refresh Rate', 'value': '120Hz'},
            {'label': 'Brightness', 'value': '2600 nits (peak)'},
          ],
        },
        {
          'title': 'Performance',
          'items': [
            {'label': 'Processor', 'value': 'Snapdragon 8 Gen 4'},
            {'label': 'CPU', 'value': 'Octa-core'},
            {'label': 'GPU', 'value': 'Adreno 760'},
            {'label': 'RAM', 'value': '12GB'},
          ],
        },
        {
          'title': 'Camera',
          'items': [
            {'label': 'Main Camera', 'value': '50MP Main'},
            {'label': 'Ultra Wide', 'value': '12MP'},
            {'label': 'Video Recording', 'value': '4K at 60fps'},
          ],
        },
        {
          'title': 'Battery & Charging',
          'items': [
            {'label': 'Battery Capacity', 'value': '4,000 mAh'},
            {'label': 'Charging', 'value': '25W Fast Charging'},
            {'label': 'Wireless Charging', 'value': 'Yes'},
            {'label': 'Battery Life', 'value': 'Up to 22 hours'},
          ],
        },
        {
          'title': 'Connectivity',
          'items': [
            {'label': '5G', 'value': 'Yes'},
            {'label': 'Wi-Fi', 'value': 'Wi-Fi 6E'},
            {'label': 'Bluetooth', 'value': '5.3'},
            {'label': 'NFC', 'value': 'Yes'},
            {'label': 'USB', 'value': 'USB-C 3.2'},
          ],
        },
        {
          'title': 'Sensors',
          'items': [
            {'label': 'Fingerprint', 'value': 'Side-mounted'},
            {'label': 'Accelerometer', 'value': 'Yes'},
            {'label': 'Gyroscope', 'value': 'Yes'},
            {'label': 'Barometer', 'value': 'Yes'},
          ],
        },
      ];
    }

    // Galaxy Z Fold 6
    if (productName == 'Galaxy Z Fold 6') {
      return [
        {
          'title': 'General',
          'items': [
            {'label': 'Brand', 'value': 'Samsung'},
            {'label': 'Model', 'value': 'Galaxy Z Fold 6'},
            {'label': 'Release Date', 'value': 'August 2025'},
            {'label': 'Status', 'value': 'Available'},
          ],
        },
        {
          'title': 'Display',
          'items': [
            {'label': 'Type (Main)', 'value': 'Dynamic AMOLED 2X'},
            {'label': 'Size (Main)', 'value': '7.6 inches'},
            {'label': 'Type (Cover)', 'value': 'Dynamic AMOLED 2X'},
            {'label': 'Size (Cover)', 'value': '6.3 inches'},
            {'label': 'Refresh Rate', 'value': '120Hz'},
            {'label': 'Brightness', 'value': '2600 nits (peak)'},
          ],
        },
        {
          'title': 'Performance',
          'items': [
            {'label': 'Processor', 'value': 'Snapdragon 8 Gen 3'},
            {'label': 'CPU', 'value': 'Octa-core'},
            {'label': 'GPU', 'value': 'Adreno 750'},
            {'label': 'RAM', 'value': '12GB'},
          ],
        },
        {
          'title': 'Camera',
          'items': [
            {'label': 'Main Camera', 'value': '200MP Main'},
            {'label': 'Ultra Wide', 'value': '50MP'},
            {'label': 'Telephoto', 'value': '10MP (3x optical)'},
            {'label': 'Video Recording', 'value': '8K at 30fps'},
          ],
        },
        {
          'title': 'Battery & Charging',
          'items': [
            {'label': 'Battery Capacity', 'value': '4,400 mAh'},
            {'label': 'Charging', 'value': '25W Fast Charging'},
            {'label': 'Wireless Charging', 'value': 'Yes'},
            {'label': 'Battery Life', 'value': 'Up to 26 hours'},
          ],
        },
        {
          'title': 'Connectivity',
          'items': [
            {'label': '5G', 'value': 'Yes'},
            {'label': 'Wi-Fi', 'value': 'Wi-Fi 6E'},
            {'label': 'Bluetooth', 'value': '5.3'},
            {'label': 'NFC', 'value': 'Yes'},
            {'label': 'USB', 'value': 'USB-C 3.2'},
          ],
        },
        {
          'title': 'Sensors',
          'items': [
            {'label': 'Fingerprint', 'value': 'Side-mounted'},
            {'label': 'Accelerometer', 'value': 'Yes'},
            {'label': 'Gyroscope', 'value': 'Yes'},
            {'label': 'Barometer', 'value': 'Yes'},
          ],
        },
      ];
    }

    // Galaxy Z Flip 6
    if (productName == 'Galaxy Z Flip 6') {
      return [
        {
          'title': 'General',
          'items': [
            {'label': 'Brand', 'value': 'Samsung'},
            {'label': 'Model', 'value': 'Galaxy Z Flip 6'},
            {'label': 'Release Date', 'value': 'August 2025'},
            {'label': 'Status', 'value': 'Available'},
          ],
        },
        {
          'title': 'Display',
          'items': [
            {'label': 'Type (Main)', 'value': 'Dynamic AMOLED 2X'},
            {'label': 'Size (Main)', 'value': '6.7 inches'},
            {'label': 'Type (Cover)', 'value': 'Super AMOLED'},
            {'label': 'Size (Cover)', 'value': '3.4 inches'},
            {'label': 'Refresh Rate', 'value': '120Hz'},
            {'label': 'Brightness', 'value': '2600 nits (peak)'},
          ],
        },
        {
          'title': 'Performance',
          'items': [
            {'label': 'Processor', 'value': 'Snapdragon 8 Gen 3'},
            {'label': 'CPU', 'value': 'Octa-core'},
            {'label': 'GPU', 'value': 'Adreno 750'},
            {'label': 'RAM', 'value': '12GB'},
          ],
        },
        {
          'title': 'Camera',
          'items': [
            {'label': 'Main Camera', 'value': '50MP Main'},
            {'label': 'Ultra Wide', 'value': '12MP'},
            {'label': 'Video Recording', 'value': '4K at 60fps'},
          ],
        },
        {
          'title': 'Battery & Charging',
          'items': [
            {'label': 'Battery Capacity', 'value': '4,000 mAh'},
            {'label': 'Charging', 'value': '25W Fast Charging'},
            {'label': 'Wireless Charging', 'value': 'Yes'},
            {'label': 'Battery Life', 'value': 'Up to 22 hours'},
          ],
        },
        {
          'title': 'Connectivity',
          'items': [
            {'label': '5G', 'value': 'Yes'},
            {'label': 'Wi-Fi', 'value': 'Wi-Fi 6E'},
            {'label': 'Bluetooth', 'value': '5.3'},
            {'label': 'NFC', 'value': 'Yes'},
            {'label': 'USB', 'value': 'USB-C 3.2'},
          ],
        },
        {
          'title': 'Sensors',
          'items': [
            {'label': 'Fingerprint', 'value': 'Side-mounted'},
            {'label': 'Accelerometer', 'value': 'Yes'},
            {'label': 'Gyroscope', 'value': 'Yes'},
            {'label': 'Barometer', 'value': 'Yes'},
          ],
        },
      ];
    }

    // Galaxy A55 5G
    if (productName == 'Galaxy A55 5G') {
      return [
        {
          'title': 'General',
          'items': [
            {'label': 'Brand', 'value': 'Samsung'},
            {'label': 'Model', 'value': 'Galaxy A55 5G'},
            {'label': 'Release Date', 'value': 'March 2024'},
            {'label': 'Status', 'value': 'Available'},
          ],
        },
        {
          'title': 'Display',
          'items': [
            {'label': 'Type', 'value': 'Super AMOLED'},
            {'label': 'Size', 'value': '6.6 inches'},
            {'label': 'Resolution', 'value': '2340 x 1080 pixels'},
            {'label': 'Refresh Rate', 'value': '120Hz'},
            {'label': 'Brightness', 'value': '1000 nits (peak)'},
          ],
        },
        {
          'title': 'Performance',
          'items': [
            {'label': 'Processor', 'value': 'Exynos 1480'},
            {'label': 'CPU', 'value': 'Octa-core'},
            {'label': 'GPU', 'value': 'Mali-G68'},
            {'label': 'RAM', 'value': '8GB'},
          ],
        },
        {
          'title': 'Camera',
          'items': [
            {'label': 'Main Camera', 'value': '50MP Main'},
            {'label': 'Ultra Wide', 'value': '12MP'},
            {'label': 'Macro', 'value': '5MP'},
            {'label': 'Video Recording', 'value': '4K at 30fps'},
          ],
        },
        {
          'title': 'Battery & Charging',
          'items': [
            {'label': 'Battery Capacity', 'value': '5,000 mAh'},
            {'label': 'Charging', 'value': '25W Fast Charging'},
            {'label': 'Battery Life', 'value': 'Up to 24 hours'},
          ],
        },
        {
          'title': 'Connectivity',
          'items': [
            {'label': '5G', 'value': 'Yes'},
            {'label': 'Wi-Fi', 'value': 'Wi-Fi 6'},
            {'label': 'Bluetooth', 'value': '5.3'},
            {'label': 'NFC', 'value': 'Yes'},
            {'label': 'USB', 'value': 'USB-C 2.0'},
          ],
        },
        {
          'title': 'Sensors',
          'items': [
            {'label': 'Fingerprint', 'value': 'Under-Display'},
            {'label': 'Accelerometer', 'value': 'Yes'},
            {'label': 'Gyroscope', 'value': 'Yes'},
            {'label': 'Barometer', 'value': 'Yes'},
          ],
        },
      ];
    }

    // Galaxy A35 5G
    if (productName == 'Galaxy A35 5G') {
      return [
        {
          'title': 'General',
          'items': [
            {'label': 'Brand', 'value': 'Samsung'},
            {'label': 'Model', 'value': 'Galaxy A35 5G'},
            {'label': 'Release Date', 'value': 'March 2024'},
            {'label': 'Status', 'value': 'Available'},
          ],
        },
        {
          'title': 'Display',
          'items': [
            {'label': 'Type', 'value': 'Super AMOLED'},
            {'label': 'Size', 'value': '6.6 inches'},
            {'label': 'Resolution', 'value': '2340 x 1080 pixels'},
            {'label': 'Refresh Rate', 'value': '120Hz'},
            {'label': 'Brightness', 'value': '1000 nits (peak)'},
          ],
        },
        {
          'title': 'Performance',
          'items': [
            {'label': 'Processor', 'value': 'Exynos 1380'},
            {'label': 'CPU', 'value': 'Octa-core'},
            {'label': 'GPU', 'value': 'Mali-G68'},
            {'label': 'RAM', 'value': '8GB'},
          ],
        },
        {
          'title': 'Camera',
          'items': [
            {'label': 'Main Camera', 'value': '50MP Main'},
            {'label': 'Ultra Wide', 'value': '8MP'},
            {'label': 'Macro', 'value': '5MP'},
            {'label': 'Video Recording', 'value': '4K at 30fps'},
          ],
        },
        {
          'title': 'Battery & Charging',
          'items': [
            {'label': 'Battery Capacity', 'value': '5,000 mAh'},
            {'label': 'Charging', 'value': '25W Fast Charging'},
            {'label': 'Battery Life', 'value': 'Up to 24 hours'},
          ],
        },
        {
          'title': 'Connectivity',
          'items': [
            {'label': '5G', 'value': 'Yes'},
            {'label': 'Wi-Fi', 'value': 'Wi-Fi 6'},
            {'label': 'Bluetooth', 'value': '5.3'},
            {'label': 'NFC', 'value': 'Yes'},
            {'label': 'USB', 'value': 'USB-C 2.0'},
          ],
        },
        {
          'title': 'Sensors',
          'items': [
            {'label': 'Fingerprint', 'value': 'Under-Display'},
            {'label': 'Accelerometer', 'value': 'Yes'},
            {'label': 'Gyroscope', 'value': 'Yes'},
            {'label': 'Barometer', 'value': 'Yes'},
          ],
        },
      ];
    }

    // Galaxy S25 Ultra
    if (productName == 'Galaxy S25 Ultra') {
      return [
        {
          'title': 'General',
          'items': [
            {'label': 'Brand', 'value': 'Samsung'},
            {'label': 'Model', 'value': 'Galaxy S25 Ultra'},
            {'label': 'Release Date', 'value': 'February 2025'},
            {'label': 'Status', 'value': 'Available'},
          ],
        },
        {
          'title': 'Display',
          'items': [
            {'label': 'Type', 'value': 'Dynamic AMOLED 2X'},
            {'label': 'Size', 'value': '6.8 inches'},
            {'label': 'Resolution', 'value': '3088 x 1440 pixels'},
            {'label': 'Refresh Rate', 'value': '120Hz'},
            {'label': 'Brightness', 'value': '2600 nits (peak)'},
          ],
        },
        {
          'title': 'Performance',
          'items': [
            {'label': 'Processor', 'value': 'Snapdragon 8 Gen 3'},
            {'label': 'CPU', 'value': 'Octa-core'},
            {'label': 'GPU', 'value': 'Adreno 750'},
            {'label': 'RAM', 'value': '12GB'},
          ],
        },
        {
          'title': 'Camera',
          'items': [
            {'label': 'Main Camera', 'value': '200MP Main'},
            {'label': 'Ultra Wide', 'value': '50MP'},
            {'label': 'Telephoto', 'value': '50MP (5x optical)'},
            {'label': 'Video Recording', 'value': '8K at 30fps'},
          ],
        },
        {
          'title': 'Battery & Charging',
          'items': [
            {'label': 'Battery Capacity', 'value': '5,000 mAh'},
            {'label': 'Charging', 'value': '45W Fast Charging'},
            {'label': 'Wireless Charging', 'value': 'Yes'},
            {'label': 'Battery Life', 'value': 'Up to 30 hours'},
          ],
        },
        {
          'title': 'Connectivity',
          'items': [
            {'label': '5G', 'value': 'Yes'},
            {'label': 'Wi-Fi', 'value': 'Wi-Fi 7'},
            {'label': 'Bluetooth', 'value': '5.3'},
            {'label': 'NFC', 'value': 'Yes'},
            {'label': 'USB', 'value': 'USB-C 3.2'},
          ],
        },
        {
          'title': 'Sensors',
          'items': [
            {'label': 'Fingerprint', 'value': 'Ultrasonic Under-Display'},
            {'label': 'Accelerometer', 'value': 'Yes'},
            {'label': 'Gyroscope', 'value': 'Yes'},
            {'label': 'Barometer', 'value': 'Yes'},
          ],
        },
      ];
    }

    // Galaxy S25 Plus
    if (productName == 'Galaxy S25 Plus') {
      return [
        {
          'title': 'General',
          'items': [
            {'label': 'Brand', 'value': 'Samsung'},
            {'label': 'Model', 'value': 'Galaxy S25 Plus'},
            {'label': 'Release Date', 'value': 'February 2025'},
            {'label': 'Status', 'value': 'Available'},
          ],
        },
        {
          'title': 'Display',
          'items': [
            {'label': 'Type', 'value': 'Dynamic AMOLED 2X'},
            {'label': 'Size', 'value': '6.7 inches'},
            {'label': 'Resolution', 'value': '3120 x 1440 pixels'},
            {'label': 'Refresh Rate', 'value': '120Hz'},
            {'label': 'Brightness', 'value': '2600 nits (peak)'},
          ],
        },
        {
          'title': 'Performance',
          'items': [
            {'label': 'Processor', 'value': 'Snapdragon 8 Gen 3'},
            {'label': 'CPU', 'value': 'Octa-core'},
            {'label': 'GPU', 'value': 'Adreno 750'},
            {'label': 'RAM', 'value': '12GB'},
          ],
        },
        {
          'title': 'Camera',
          'items': [
            {'label': 'Main Camera', 'value': '50MP Main'},
            {'label': 'Ultra Wide', 'value': '12MP'},
            {'label': 'Telephoto', 'value': '10MP (3x optical)'},
            {'label': 'Video Recording', 'value': '8K at 30fps'},
          ],
        },
        {
          'title': 'Battery & Charging',
          'items': [
            {'label': 'Battery Capacity', 'value': '4,900 mAh'},
            {'label': 'Charging', 'value': '45W Fast Charging'},
            {'label': 'Wireless Charging', 'value': 'Yes'},
            {'label': 'Battery Life', 'value': 'Up to 28 hours'},
          ],
        },
        {
          'title': 'Connectivity',
          'items': [
            {'label': '5G', 'value': 'Yes'},
            {'label': 'Wi-Fi', 'value': 'Wi-Fi 6E'},
            {'label': 'Bluetooth', 'value': '5.3'},
            {'label': 'NFC', 'value': 'Yes'},
            {'label': 'USB', 'value': 'USB-C 3.2'},
          ],
        },
        {
          'title': 'Sensors',
          'items': [
            {'label': 'Fingerprint', 'value': 'Ultrasonic Under-Display'},
            {'label': 'Accelerometer', 'value': 'Yes'},
            {'label': 'Gyroscope', 'value': 'Yes'},
            {'label': 'Barometer', 'value': 'Yes'},
          ],
        },
      ];
    }

    // Default specs for products not specifically defined
    return _defaultSpecs;
  }

  final List<Map<String, dynamic>> _defaultSpecs = [
    {
      'title': 'General',
      'items': [
        {'label': 'Brand', 'value': 'Various'},
        {'label': 'Status', 'value': 'Available'},
      ],
    },
    {
      'title': 'Specifications',
      'items': [
        {'label': 'Details', 'value': 'Check with manufacturer'},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final String productName = product['name']?.toString() ?? 'Product';
    final int basePrice = _getPriceAsInt();
    final double rating = _getRatingAsDouble();
    final String brand = product['brand']?.toString() ?? 'Brand';
    final String imagePath =
        product['image']?.toString() ?? 'assets/images/placeholder.png';

    final List<Map<String, dynamic>> colorVariants = _colorVariants;
    if (_selectedColorIndex >= colorVariants.length) {
      _selectedColorIndex = 0;
    }

    final currentColor = colorVariants[_selectedColorIndex];
    final String currentImage = currentColor['image'] as String? ?? imagePath;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ========== PRODUCT IMAGE ==========
                  Container(
                    height: 320,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        currentImage,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.phone_android_rounded,
                            size: 80,
                            color: Colors.grey,
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ========== PRODUCT INFO ==========
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Brand with icon
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF007BF6).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                brand,
                                style: const TextStyle(
                                  color: Color(0xFF007BF6),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  rating.toStringAsFixed(1),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  ' (245 reviews)',
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          productName,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Price & EMI
                        Row(
                          children: [
                            Text(
                              '\$${_storageVariants[_selectedStorageIndex]['price']}',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF007BF6),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF10B981).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Save \$${(basePrice - (_storageVariants[_selectedStorageIndex]['price'] as int)).abs()}',
                                style: const TextStyle(
                                  color: Color(0xFF10B981),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'EMI starts at \$${(basePrice / 12).round()}/month',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // ========== COLOR SWATCHES ==========
                        _buildColorSwatches(),
                        const SizedBox(height: 16),

                        // ========== STORAGE VARIANTS ==========
                        _buildStorageVariants(),
                        const SizedBox(height: 24),

                        // ========== SPECIFICATIONS ==========
                        _buildSpecifications(),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // ========== ACTION BUTTONS - FIXED AT BOTTOM ==========
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 15,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: _buildActionButtons(),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // ========== APP BAR ==========
  PreferredSizeWidget _buildAppBar() {
    final isFavorited = context.watch<CartProvider>().isFavorite(
      widget.product,
    );

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
      title: const Text(
        'Product Details',
        style: TextStyle(
          color: Color(0xFF0F172A),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(
            isFavorited
                ? Icons.favorite_rounded
                : Icons.favorite_border_rounded,
            color: isFavorited
                ? const Color(0xFFFF3B30)
                : const Color(0xFF94A3B8),
            size: 24,
          ),
          onPressed: () {
            final added = _toggleCurrentFavorite();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  added ? 'Added to favorites' : 'Removed from favorites',
                ),
                duration: const Duration(seconds: 1),
                backgroundColor: added ? const Color(0xFF10B981) : Colors.grey,
              ),
            );
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.add_shopping_cart_rounded,
            color: Color(0xFF0F172A),
          ),
          onPressed: _addToCartAndStay,
        ),
        IconButton(
          icon: const Icon(Icons.share_rounded, color: Color(0xFF0F172A)),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Share feature coming soon!'),
                duration: Duration(seconds: 1),
              ),
            );
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  // ========== COLOR SWATCHES ==========
  Widget _buildColorSwatches() {
    final List<Map<String, dynamic>> colorVariants = _colorVariants;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Color',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              colorVariants[_selectedColorIndex]['name'],
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: colorVariants.length,
            itemBuilder: (context, index) {
              final variant = colorVariants[index];
              final isSelected = _selectedColorIndex == index;
              final Color color = variant['color'];
              final bool isLight = color.computeLuminance() > 0.5;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedColorIndex = index;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? color : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? Colors.transparent
                          : Colors.grey.shade300,
                      width: 1.5,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: color.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : [],
                  ),
                  child: Center(
                    child: Text(
                      variant['name'],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w500,
                        color: isSelected
                            ? (isLight ? Colors.black : Colors.white)
                            : Colors.grey.shade700,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ========== STORAGE VARIANTS ==========
  Widget _buildStorageVariants() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Storage',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 3.0,
          ),
          itemCount: _storageVariants.length,
          itemBuilder: (context, index) {
            final variant = _storageVariants[index];
            final isSelected = _selectedStorageIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedStorageIndex = index;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? const LinearGradient(
                          colors: [Color(0xFF007BF6), Color(0xFF0056B3)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: isSelected ? null : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? Colors.transparent
                        : Colors.grey.shade300,
                    width: 1.5,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: const Color(0xFF007BF6).withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        variant['storage'] as String,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.white.withOpacity(0.2)
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '\$${variant['price']}',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? Colors.white
                                : Colors.grey.shade700,
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
      ],
    );
  }

  // ========== ACTION BUTTONS ==========
  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: _navigateToCart, // ✅ Navigates to cart
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF007BF6),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 2,
              shadowColor: const Color(0xFF007BF6).withOpacity(0.3),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_bag_rounded, size: 22),
                SizedBox(width: 10),
                Text(
                  'Buy Now',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: _showReserveDialog,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF007BF6),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(color: Color(0xFF007BF6), width: 2),
              ),
              elevation: 0,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.event_note_rounded, size: 22),
                SizedBox(width: 10),
                Text(
                  'Reserve',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ========== RESERVE DIALOG ==========
  void _showReserveDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Reserve in Store',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.storefront_rounded,
              size: 48,
              color: Color(0xFF007BF6),
            ),
            const SizedBox(height: 16),
            Text(
              'Reserve ${widget.product['name'] ?? 'Product'}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Text(
              'Available at Phnom Penh Branch',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(
                  Icons.check_circle_rounded,
                  color: Color(0xFF10B981),
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'Hold for 24 hours',
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.check_circle_rounded,
                  color: Color(0xFF10B981),
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'Free cancellation',
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    '✅ Reserved successfully! Pick up at Phnom Penh Branch',
                  ),
                  backgroundColor: Color(0xFF10B981),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF007BF6),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Confirm Reserve'),
          ),
        ],
      ),
    );
  }

  // ========== SPECIFICATIONS ==========
  Widget _buildSpecifications() {
    final specs = _getProductSpecs();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Full Specifications',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...specs.map((section) {
          final items = section['items'] as List<Map<String, dynamic>>? ?? [];
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.shade200),
            ),
            child: Theme(
              data: Theme.of(
                context,
              ).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                title: Text(
                  section['title'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF007BF6).withOpacity(0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getIconForSection(section['title'] as String),
                    color: const Color(0xFF007BF6),
                    size: 18,
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Column(
                      children: items.map((item) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  item['label'] as String,
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  item['value'] as String,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  // ========== GET ICON FOR SECTION ==========
  IconData _getIconForSection(String title) {
    switch (title) {
      case 'General':
        return Icons.info_outline_rounded;
      case 'Display':
        return Icons.screen_rotation_alt_rounded;
      case 'Performance':
        return Icons.speed_rounded;
      case 'Camera':
        return Icons.camera_alt_rounded;
      case 'Battery & Charging':
        return Icons.battery_6_bar_rounded;
      case 'Connectivity':
        return Icons.wifi_rounded;
      case 'Sensors':
        return Icons.sensors_rounded;
      case 'Features':
        return Icons.star_outline_rounded;
      case 'Audio':
        return Icons.audiotrack_rounded;
      default:
        return Icons.circle_outlined;
    }
  }

  // ========== BOTTOM NAVIGATION ==========
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
