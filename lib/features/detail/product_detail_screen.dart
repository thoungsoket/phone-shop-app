import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _selectedColorIndex = 0;
  int _selectedStorageIndex = 0;
  bool _isFavorited = false;
  int _selectedImageIndex = 0;

  // ========== APPLE SMARTPHONES - EACH COLOR HAS UNIQUE IMAGE ==========
  final Map<String, List<Map<String, dynamic>>> _appleColorVariants = {
    'iPhone 17 Pro Max': [
      {'name': 'Natural Titanium', 'color': Color(0xFFBFBFBF), 'image': 'assets/images/iphone17_promax_natural.png'},
      {'name': 'Black Titanium', 'color': Color(0xFF2C2C2C), 'image': 'assets/images/iphone17_promax_black.png'},
      {'name': 'White Titanium', 'color': Color(0xFFF5F5F5), 'image': 'assets/images/iphone17_promax_white.png'},
      {'name': 'Gold', 'color': Color(0xFFD4AF37), 'image': 'assets/images/iphone17_promax_gold.png'},
    ],
    'iPhone 17 Pro': [
      {'name': 'Black Titanium', 'color': Color(0xFF2C2C2C), 'image': 'assets/images/iphone17_pro_black.png'},
      {'name': 'Natural Titanium', 'color': Color(0xFFBFBFBF), 'image': 'assets/images/iphone17_pro_natural.png'},
      {'name': 'White Titanium', 'color': Color(0xFFF5F5F5), 'image': 'assets/images/iphone17_pro_white.png'},
      {'name': 'Gold', 'color': Color(0xFFD4AF37), 'image': 'assets/images/iphone17_pro_gold.png'},
    ],
    'iPhone 17': [
      {'name': 'Midnight', 'color': Color(0xFF1A1A2E), 'image': 'assets/images/iphone17_midnight.png'},
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/iphone17_black.png'},
      {'name': 'Starlight', 'color': Color(0xFFF5F5DC), 'image': 'assets/images/iphone17_starlight.png'},
      {'name': 'Blue', 'color': Color(0xFF007AFF), 'image': 'assets/images/iphone17_blue.png'},
      {'name': 'Pink', 'color': Color(0xFFFFB6C1), 'image': 'assets/images/iphone17_pink.png'},
    ],
    'iPhone 16 Pro Max': [
      {'name': 'Natural Titanium', 'color': Color(0xFFBFBFBF), 'image': 'assets/images/iphone16_promax_natural.png'},
      {'name': 'Black Titanium', 'color': Color(0xFF2C2C2C), 'image': 'assets/images/iphone16_promax_black.png'},
      {'name': 'White Titanium', 'color': Color(0xFFF5F5F5), 'image': 'assets/images/iphone16_promax_white.png'},
      {'name': 'Gold', 'color': Color(0xFFD4AF37), 'image': 'assets/images/iphone16_promax_gold.png'},
    ],
    'iPhone 16 Pro': [
      {'name': 'Black Titanium', 'color': Color(0xFF2C2C2C), 'image': 'assets/images/iphone16_pro_black.png'},
      {'name': 'Natural Titanium', 'color': Color(0xFFBFBFBF), 'image': 'assets/images/iphone16_pro_natural.png'},
      {'name': 'White Titanium', 'color': Color(0xFFF5F5F5), 'image': 'assets/images/iphone16_pro_white.png'},
      {'name': 'Gold', 'color': Color(0xFFD4AF37), 'image': 'assets/images/iphone16_pro_gold.png'},
    ],
    'iPhone 16 Plus': [
      {'name': 'Midnight', 'color': Color(0xFF1A1A2E), 'image': 'assets/images/iphone16_plus_midnight.png'},
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/iphone16_plus_black.png'},
      {'name': 'Starlight', 'color': Color(0xFFF5F5DC), 'image': 'assets/images/iphone16_plus_starlight.png'},
      {'name': 'Blue', 'color': Color(0xFF007AFF), 'image': 'assets/images/iphone16_plus_blue.png'},
      {'name': 'Pink', 'color': Color(0xFFFFB6C1), 'image': 'assets/images/iphone16_plus_pink.png'},
    ],
    'iPhone 16': [
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/iphone16_black.png'},
      {'name': 'Midnight', 'color': Color(0xFF1A1A2E), 'image': 'assets/images/iphone16_midnight.png'},
      {'name': 'Starlight', 'color': Color(0xFFF5F5DC), 'image': 'assets/images/iphone16_starlight.png'},
      {'name': 'Blue', 'color': Color(0xFF007AFF), 'image': 'assets/images/iphone16_blue.png'},
      {'name': 'Pink', 'color': Color(0xFFFFB6C1), 'image': 'assets/images/iphone16_pink.png'},
    ],
    'iPhone 15 Pro Max': [
      {'name': 'Natural Titanium', 'color': Color(0xFFBFBFBF), 'image': 'assets/images/iphone15_promax_natural.png'},
      {'name': 'Black Titanium', 'color': Color(0xFF2C2C2C), 'image': 'assets/images/iphone15_promax_black.png'},
      {'name': 'White Titanium', 'color': Color(0xFFF5F5F5), 'image': 'assets/images/iphone15_promax_white.png'},
      {'name': 'Gold', 'color': Color(0xFFD4AF37), 'image': 'assets/images/iphone15_promax_gold.png'},
    ],
    'iPhone 15 Pro': [
      {'name': 'Black Titanium', 'color': Color(0xFF2C2C2C), 'image': 'assets/images/iphone15_pro_black.png'},
      {'name': 'Natural Titanium', 'color': Color(0xFFBFBFBF), 'image': 'assets/images/iphone15_pro_natural.png'},
      {'name': 'White Titanium', 'color': Color(0xFFF5F5F5), 'image': 'assets/images/iphone15_pro_white.png'},
      {'name': 'Gold', 'color': Color(0xFFD4AF37), 'image': 'assets/images/iphone15_pro_gold.png'},
    ],
    'iPhone 15': [
      {'name': 'Midnight', 'color': Color(0xFF1A1A2E), 'image': 'assets/images/iphone15_midnight.png'},
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/iphone15_black.png'},
      {'name': 'Starlight', 'color': Color(0xFFF5F5DC), 'image': 'assets/images/iphone15_starlight.png'},
      {'name': 'Blue', 'color': Color(0xFF007AFF), 'image': 'assets/images/iphone15_blue.png'},
      {'name': 'Pink', 'color': Color(0xFFFFB6C1), 'image': 'assets/images/iphone15_pink.png'},
    ],
    'iPhone XR': [
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/iphonexr_black.png'},
      {'name': 'White', 'color': Color(0xFFFFFFFF), 'image': 'assets/images/iphonexr_white.png'},
      {'name': 'Blue', 'color': Color(0xFF007AFF), 'image': 'assets/images/iphonexr_blue.png'},
      {'name': 'Red', 'color': Color(0xFFFF3B30), 'image': 'assets/images/iphonexr_red.png'},
      {'name': 'Yellow', 'color': Color(0xFFFFCC00), 'image': 'assets/images/iphonexr_yellow.png'},
    ],
    'iPhone XS Max': [
      {'name': 'Gold', 'color': Color(0xFFD4AF37), 'image': 'assets/images/iphonexsmax_gold.png'},
      {'name': 'Silver', 'color': Color(0xFFC0C0C0), 'image': 'assets/images/iphonexsmax_silver.png'},
      {'name': 'Space Gray', 'color': Color(0xFF2C2C2C), 'image': 'assets/images/iphonexsmax_spacegray.png'},
    ],
  };

  // ========== SAMSUNG SMARTPHONES - EACH COLOR HAS UNIQUE IMAGE ==========
  final Map<String, List<Map<String, dynamic>>> _samsungColorVariants = {
    'Galaxy S26 Ultra': [
      {'name': 'Titanium Black', 'color': Color(0xFF1A1A1A), 'image': 'assets/images/s26_ultra_black.png'},
      {'name': 'Titanium Gray', 'color': Color(0xFF8C8C8C), 'image': 'assets/images/s26_ultra_gray.png'},
      {'name': 'Titanium White', 'color': Color(0xFFFFFFFF), 'image': 'assets/images/s26_ultra_white.png'},
    ],
    'Galaxy S26 Plus': [
      {'name': 'Mint', 'color': Color(0xFF98FF98), 'image': 'assets/images/s26_plus_mint.png'},
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/s26_plus_black.png'},
      {'name': 'White', 'color': Color(0xFFFFFFFF), 'image': 'assets/images/s26_plus_white.png'},
    ],
    'Galaxy S26': [
      {'name': 'Lavender', 'color': Color(0xFFB6A1D9), 'image': 'assets/images/s26_lavender.png'},
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/s26_black.png'},
      {'name': 'White', 'color': Color(0xFFFFFFFF), 'image': 'assets/images/s26_white.png'},
    ],
    'Galaxy Z Fold 7': [
      {'name': 'Titanium Black', 'color': Color(0xFF1A1A1A), 'image': 'assets/images/zfold7_black.png'},
      {'name': 'Silver', 'color': Color(0xFFC0C0C0), 'image': 'assets/images/zfold7_silver.png'},
    ],
    'Galaxy Z Flip 7': [
      {'name': 'Mint', 'color': Color(0xFF98FF98), 'image': 'assets/images/zflip7_mint.png'},
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/zflip7_black.png'},
    ],
    'Galaxy Z Fold 6': [
      {'name': 'Phantom Black', 'color': Color(0xFF0A0A0A), 'image': 'assets/images/zfold6_black.png'},
      {'name': 'Silver', 'color': Color(0xFFC0C0C0), 'image': 'assets/images/zfold6_silver.png'},
    ],
    'Galaxy Z Flip 6': [
      {'name': 'Light Blue', 'color': Color(0xFF87CEEB), 'image': 'assets/images/zflip6_blue.png'},
      {'name': 'Cream', 'color': Color(0xFFFFFDD0), 'image': 'assets/images/zflip6_cream.png'},
    ],
    'Galaxy A55 5G': [
      {'name': 'White', 'color': Color(0xFFFFFFFF), 'image': 'assets/images/a55_5g_white.png'},
      {'name': 'Lavender', 'color': Color(0xFFB6A1D9), 'image': 'assets/images/a55_5g_lavender.png'},
    ],
    'Galaxy A35 5G': [
      {'name': 'White', 'color': Color(0xFFFFFFFF), 'image': 'assets/images/a35_5g_white.png'},
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/a35_5g_black.png'},
    ],
    'Galaxy S25 Ultra': [
      {'name': 'Titanium Gray', 'color': Color(0xFF8C8C8C), 'image': 'assets/images/s25_ultra_gray.png'},
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/s25_ultra_black.png'},
      {'name': 'White', 'color': Color(0xFFFFFFFF), 'image': 'assets/images/s25_ultra_white.png'},
    ],
    'Galaxy S25 Plus': [
      {'name': 'Mint', 'color': Color(0xFF98FF98), 'image': 'assets/images/s25_plus_mint.png'},
      {'name': 'White', 'color': Color(0xFFFFFFFF), 'image': 'assets/images/s25_plus_white.png'},
    ],
  };

  // ========== XIAOMI SMARTPHONES - EACH COLOR HAS UNIQUE IMAGE ==========
  final Map<String, List<Map<String, dynamic>>> _xiaomiColorVariants = {
    'Xiaomi 15 Pro': [
      {'name': 'Silver', 'color': Color(0xFFC0C0C0), 'image': 'assets/images/xiaomi15_pro_silver.png'},
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/xiaomi15_pro_black.png'},
      {'name': 'White', 'color': Color(0xFFFFFFFF), 'image': 'assets/images/xiaomi15_pro_white.png'},
    ],
    'Xiaomi 15': [
      {'name': 'Mint', 'color': Color(0xFF98FF98), 'image': 'assets/images/xiaomi15_mint.png'},
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/xiaomi15_black.png'},
      {'name': 'White', 'color': Color(0xFFFFFFFF), 'image': 'assets/images/xiaomi15_white.png'},
    ],
    'Xiaomi 14 Pro': [
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/xiaomi14_pro_black.png'},
      {'name': 'Silver', 'color': Color(0xFFC0C0C0), 'image': 'assets/images/xiaomi14_pro_silver.png'},
    ],
    'Xiaomi 14': [
      {'name': 'Green', 'color': Color(0xFF228B22), 'image': 'assets/images/xiaomi14_green.png'},
      {'name': 'White', 'color': Color(0xFFFFFFFF), 'image': 'assets/images/xiaomi14_white.png'},
    ],
    'Xiaomi 14T Pro': [
      {'name': 'Titanium Gray', 'color': Color(0xFF8C8C8C), 'image': 'assets/images/xiaomi14t_pro_gray.png'},
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/xiaomi14t_pro_black.png'},
    ],
    'Xiaomi 13T Pro': [
      {'name': 'Mint', 'color': Color(0xFF98FF98), 'image': 'assets/images/xiaomi13t_pro_mint.png'},
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/xiaomi13t_pro_black.png'},
    ],
    'Xiaomi 13': [
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/xiaomi13_black.png'},
      {'name': 'White', 'color': Color(0xFFFFFFFF), 'image': 'assets/images/xiaomi13_white.png'},
    ],
    'Xiaomi 12 Pro': [
      {'name': 'Light Blue', 'color': Color(0xFF87CEEB), 'image': 'assets/images/xiaomi12_pro_blue.png'},
      {'name': 'Gray', 'color': Color(0xFF808080), 'image': 'assets/images/xiaomi12_pro_gray.png'},
    ],
    'Xiaomi 12': [
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/xiaomi12_black.png'},
      {'name': 'Gray', 'color': Color(0xFF808080), 'image': 'assets/images/xiaomi12_gray.png'},
    ],
    'Xiaomi Poco F6': [
      {'name': 'Rose Gold', 'color': Color(0xFFE8B4B8), 'image': 'assets/images/poco_f6_rosegold.png'},
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/poco_f6_black.png'},
    ],
  };

  // ========== OPPO SMARTPHONES - EACH COLOR HAS UNIQUE IMAGE ==========
  final Map<String, List<Map<String, dynamic>>> _oppoColorVariants = {
    'Oppo Find X8 Ultra': [
      {'name': 'White', 'color': Color(0xFFFFFFFF), 'image': 'assets/images/findx8_ultra_white.png'},
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/findx8_ultra_black.png'},
      {'name': 'Silver', 'color': Color(0xFFC0C0C0), 'image': 'assets/images/findx8_ultra_silver.png'},
    ],
    'Oppo Find X8 Pro': [
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/findx8_pro_black.png'},
      {'name': 'White', 'color': Color(0xFFFFFFFF), 'image': 'assets/images/findx8_pro_white.png'},
    ],
    'Oppo Find X8': [
      {'name': 'Light Pink', 'color': Color(0xFFFFB6C1), 'image': 'assets/images/findx8_pink.png'},
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/findx8_black.png'},
    ],
    'Oppo Find X7 Ultra': [
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/findx7_ultra_black.png'},
      {'name': 'Silver', 'color': Color(0xFFC0C0C0), 'image': 'assets/images/findx7_ultra_silver.png'},
    ],
    'Oppo Find X7': [
      {'name': 'Silver', 'color': Color(0xFFC0C0C0), 'image': 'assets/images/findx7_silver.png'},
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/findx7_black.png'},
    ],
    'Oppo Reno 13 Pro': [
      {'name': 'White', 'color': Color(0xFFFFFFFF), 'image': 'assets/images/reno13_pro_white.png'},
      {'name': 'Silver', 'color': Color(0xFFC0C0C0), 'image': 'assets/images/reno13_pro_silver.png'},
    ],
    'Oppo Reno 13': [
      {'name': 'White', 'color': Color(0xFFFFFFFF), 'image': 'assets/images/reno13_white.png'},
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/reno13_black.png'},
    ],
    'Oppo Reno 12 Pro': [
      {'name': 'Silver', 'color': Color(0xFFC0C0C0), 'image': 'assets/images/reno12_pro_silver.png'},
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/reno12_pro_black.png'},
    ],
    'Oppo Reno 12': [
      {'name': 'Silver', 'color': Color(0xFFC0C0C0), 'image': 'assets/images/reno12_silver.png'},
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/reno12_black.png'},
    ],
    'Oppo A79 5G': [
      {'name': 'Mint', 'color': Color(0xFF98FF98), 'image': 'assets/images/a79_5g_mint.png'},
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/a79_5g_black.png'},
    ],
  };

  // ========== ONEPLUS SMARTPHONES - EACH COLOR HAS UNIQUE IMAGE ==========
  final Map<String, List<Map<String, dynamic>>> _oneplusColorVariants = {
    'OnePlus 12': [
      {'name': 'Flowy Emerald', 'color': Color(0xFF50C878), 'image': 'assets/images/oneplus12_emerald.png'},
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/oneplus12_black.png'},
      {'name': 'White', 'color': Color(0xFFFFFFFF), 'image': 'assets/images/oneplus12_white.png'},
    ],
    'OnePlus 12R': [
      {'name': 'Light Blue', 'color': Color(0xFF87CEEB), 'image': 'assets/images/oneplus12r_blue.png'},
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/oneplus12r_black.png'},
    ],
    'OnePlus 11': [
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/oneplus11_black.png'},
      {'name': 'Silver', 'color': Color(0xFFC0C0C0), 'image': 'assets/images/oneplus11_silver.png'},
    ],
    'OnePlus Nord 4': [
      {'name': 'Silver', 'color': Color(0xFFC0C0C0), 'image': 'assets/images/nord4_silver.png'},
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/nord4_black.png'},
    ],
    'OnePlus Nord 3': [
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/nord3_black.png'},
      {'name': 'Silver', 'color': Color(0xFFC0C0C0), 'image': 'assets/images/nord3_silver.png'},
    ],
    'OnePlus Open': [
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/oneplus_open_black.png'},
      {'name': 'Silver', 'color': Color(0xFFC0C0C0), 'image': 'assets/images/oneplus_open_silver.png'},
    ],
  };

  // ========== VIVO SMARTPHONES - EACH COLOR HAS UNIQUE IMAGE ==========
  final Map<String, List<Map<String, dynamic>>> _vivoColorVariants = {
    'Vivo X100 Ultra': [
      {'name': 'White', 'color': Color(0xFFFFFFFF), 'image': 'assets/images/vivo_x100_ultra_white.png'},
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/vivo_x100_ultra_black.png'},
      {'name': 'Titanium', 'color': Color(0xFF8C8C8C), 'image': 'assets/images/vivo_x100_ultra_titanium.png'},
    ],
    'Vivo X100 Pro': [
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/vivo_x100_pro_black.png'},
      {'name': 'White', 'color': Color(0xFFFFFFFF), 'image': 'assets/images/vivo_x100_pro_white.png'},
    ],
    'Vivo X100': [
      {'name': 'Orange', 'color': Color(0xFFFFA500), 'image': 'assets/images/vivo_x100_orange.png'},
      {'name': 'Silver', 'color': Color(0xFFC0C0C0), 'image': 'assets/images/vivo_x100_silver.png'},
    ],
    'Vivo V40 Pro': [
      {'name': 'Grey', 'color': Color(0xFF808080), 'image': 'assets/images/vivo_v40_pro_grey.png'},
      {'name': 'Silver', 'color': Color(0xFFC0C0C0), 'image': 'assets/images/vivo_v40_pro_silver.png'},
    ],
    'Vivo V40': [
      {'name': 'Purple', 'color': Color(0xFF800080), 'image': 'assets/images/vivo_v40_purple.png'},
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/vivo_v40_black.png'},
    ],
  };

  // ========== TABLETS - EACH COLOR HAS UNIQUE IMAGE ==========
  final Map<String, List<Map<String, dynamic>>> _tabletColorVariants = {
    'iPad Pro M4 13"': [
      {'name': 'Space Gray', 'color': Color(0xFF2C2C2C), 'image': 'assets/images/ipad_pro_m4_13_gray.png'},
      {'name': 'Silver', 'color': Color(0xFFC0C0C0), 'image': 'assets/images/ipad_pro_m4_13_silver.png'},
    ],
    'iPad Pro M4 11"': [
      {'name': 'Space Gray', 'color': Color(0xFF2C2C2C), 'image': 'assets/images/ipad_pro_m4_11_gray.png'},
      {'name': 'Silver', 'color': Color(0xFFC0C0C0), 'image': 'assets/images/ipad_pro_m4_11_silver.png'},
    ],
    'iPad Air M3': [
      {'name': 'Space Gray', 'color': Color(0xFF2C2C2C), 'image': 'assets/images/ipad_air_m3_gray.png'},
      {'name': 'Silver', 'color': Color(0xFFC0C0C0), 'image': 'assets/images/ipad_air_m3_silver.png'},
      {'name': 'Blue', 'color': Color(0xFF007AFF), 'image': 'assets/images/ipad_air_m3_blue.png'},
    ],
    'Galaxy Tab S10 Ultra': [
      {'name': 'Titanium Black', 'color': Color(0xFF1A1A1A), 'image': 'assets/images/tab_s10_ultra_black.png'},
      {'name': 'Silver', 'color': Color(0xFFC0C0C0), 'image': 'assets/images/tab_s10_ultra_silver.png'},
    ],
    'Galaxy Tab S10 Plus': [
      {'name': 'Silver', 'color': Color(0xFFC0C0C0), 'image': 'assets/images/tab_s10_plus_silver.png'},
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/tab_s10_plus_black.png'},
    ],
    'Xiaomi Pad 7 Pro': [
      {'name': 'Silver', 'color': Color(0xFFC0C0C0), 'image': 'assets/images/pad7_pro_silver.png'},
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/pad7_pro_black.png'},
    ],
    'Oppo Pad 4 Pro': [
      {'name': 'Silver', 'color': Color(0xFFC0C0C0), 'image': 'assets/images/pad4_pro_silver.png'},
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/pad4_pro_black.png'},
    ],
  };

  // ========== WEARABLES - EACH COLOR HAS UNIQUE IMAGE ==========
  final Map<String, List<Map<String, dynamic>>> _wearableColorVariants = {
    'Apple Watch Ultra 3': [
      {'name': 'Titanium', 'color': Color(0xFF8C8C8C), 'image': 'assets/images/watch_ultra3_titanium.png'},
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/watch_ultra3_black.png'},
    ],
    'Apple Watch Series 10': [
      {'name': 'Silver', 'color': Color(0xFFC0C0C0), 'image': 'assets/images/watch_series10_silver.png'},
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/watch_series10_black.png'},
      {'name': 'Rose Gold', 'color': Color(0xFFE8B4B8), 'image': 'assets/images/watch_series10_rosegold.png'},
    ],
    'Galaxy Watch 7 Ultra': [
      {'name': 'Titanium', 'color': Color(0xFF8C8C8C), 'image': 'assets/images/watch7_ultra_titanium.png'},
      {'name': 'Silver', 'color': Color(0xFFC0C0C0), 'image': 'assets/images/watch7_ultra_silver.png'},
    ],
    'Galaxy Watch 7': [
      {'name': 'Silver', 'color': Color(0xFFC0C0C0), 'image': 'assets/images/watch7_silver.png'},
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/watch7_black.png'},
    ],
    'Xiaomi Watch 3 Pro': [
      {'name': 'Silver', 'color': Color(0xFFC0C0C0), 'image': 'assets/images/watch3_pro_silver.png'},
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/watch3_pro_black.png'},
    ],
    'Oppo Watch 5 Pro': [
      {'name': 'Silver', 'color': Color(0xFFC0C0C0), 'image': 'assets/images/watch5_pro_silver.png'},
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/watch5_pro_black.png'},
    ],
  };

  // ========== ACCESSORIES - EACH COLOR HAS UNIQUE IMAGE ==========
  final Map<String, List<Map<String, dynamic>>> _accessoryColorVariants = {
    'AirPods Pro 3': [
      {'name': 'White', 'color': Color(0xFFFFFFFF), 'image': 'assets/images/airpods_pro3_white.png'},
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/airpods_pro3_black.png'},
    ],
    'AirPods Max 2': [
      {'name': 'Silver', 'color': Color(0xFFC0C0C0), 'image': 'assets/images/airpods_max2_silver.png'},
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/airpods_max2_black.png'},
      {'name': 'Blue', 'color': Color(0xFF007AFF), 'image': 'assets/images/airpods_max2_blue.png'},
    ],
    'Galaxy Buds 3 Pro': [
      {'name': 'Silver', 'color': Color(0xFFC0C0C0), 'image': 'assets/images/buds3_pro_silver.png'},
      {'name': 'White', 'color': Color(0xFFFFFFFF), 'image': 'assets/images/buds3_pro_white.png'},
    ],
    'Xiaomi Buds 4 Pro': [
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/buds4_pro_black.png'},
      {'name': 'White', 'color': Color(0xFFFFFFFF), 'image': 'assets/images/buds4_pro_white.png'},
    ],
    'Oppo Enco X4': [
      {'name': 'White', 'color': Color(0xFFFFFFFF), 'image': 'assets/images/enco_x4_white.png'},
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/enco_x4_black.png'},
    ],
    'OnePlus Buds Pro 3': [
      {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/oneplus_buds_pro3_black.png'},
      {'name': 'White', 'color': Color(0xFFFFFFFF), 'image': 'assets/images/oneplus_buds_pro3_white.png'},
    ],
  };

  // ========== DEFAULT VARIANTS ==========
  final List<Map<String, dynamic>> _defaultColorVariants = [
    {'name': 'Black', 'color': Color(0xFF000000), 'image': 'assets/images/placeholder.png'},
    {'name': 'White', 'color': Color(0xFFFFFFFF), 'image': 'assets/images/placeholder.png'},
    {'name': 'Silver', 'color': Color(0xFFC0C0C0), 'image': 'assets/images/placeholder.png'},
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

    // Check Apple
    if (productName.contains('iPhone')) {
      for (final entry in _appleColorVariants.entries) {
        if (productName.contains(entry.key) || entry.key.contains(productName)) {
          return entry.value;
        }
      }
      for (final entry in _appleColorVariants.entries) {
        if (productName.contains('iPhone') && entry.key.contains('iPhone')) {
          return entry.value;
        }
      }
    }

    // Check Samsung
    if (productName.contains('Galaxy')) {
      for (final entry in _samsungColorVariants.entries) {
        if (productName.contains(entry.key) || entry.key.contains(productName)) {
          return entry.value;
        }
      }
    }

    // Check Xiaomi
    if (productName.contains('Xiaomi')) {
      for (final entry in _xiaomiColorVariants.entries) {
        if (productName.contains(entry.key) || entry.key.contains(productName)) {
          return entry.value;
        }
      }
    }

    // Check Oppo
    if (productName.contains('Oppo') || productName.contains('Find') || productName.contains('Reno')) {
      for (final entry in _oppoColorVariants.entries) {
        if (productName.contains(entry.key) || entry.key.contains(productName)) {
          return entry.value;
        }
      }
    }

    // Check OnePlus
    if (productName.contains('OnePlus')) {
      for (final entry in _oneplusColorVariants.entries) {
        if (productName.contains(entry.key) || entry.key.contains(productName)) {
          return entry.value;
        }
      }
    }

    // Check Vivo
    if (productName.contains('Vivo')) {
      for (final entry in _vivoColorVariants.entries) {
        if (productName.contains(entry.key) || entry.key.contains(productName)) {
          return entry.value;
        }
      }
    }

    // Check Tablets
    if (category == 'Tablets' || productName.contains('Pad') || productName.contains('iPad') || productName.contains('Tab')) {
      for (final entry in _tabletColorVariants.entries) {
        if (productName.contains(entry.key) || entry.key.contains(productName)) {
          return entry.value;
        }
      }
    }

    // Check Wearables
    if (category == 'Wearables' || productName.contains('Watch') || productName.contains('Band')) {
      for (final entry in _wearableColorVariants.entries) {
        if (productName.contains(entry.key) || entry.key.contains(productName)) {
          return entry.value;
        }
      }
    }

    // Check Accessories
    if (category == 'Accessories' || productName.contains('Buds') || productName.contains('AirPods') || productName.contains('Charger')) {
      for (final entry in _accessoryColorVariants.entries) {
        if (productName.contains(entry.key) || entry.key.contains(productName)) {
          return entry.value;
        }
      }
    }

    return _defaultColorVariants;
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

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final String productName = product['name']?.toString() ?? 'Product';
    final int basePrice = _getPriceAsInt();
    final double rating = _getRatingAsDouble();
    final String brand = product['brand']?.toString() ?? 'Brand';
    final String imagePath = product['image']?.toString() ?? 'assets/images/placeholder.png';

    final List<Map<String, dynamic>> colorVariants = _colorVariants;
    if (_selectedColorIndex >= colorVariants.length) {
      _selectedColorIndex = 0;
    }

    final currentColor = colorVariants[_selectedColorIndex];
    final String currentImage = currentColor?['image'] as String? ?? imagePath;
    final String currentColorName = currentColor?['name'] as String? ?? 'Default';
    final Color currentColorValue = currentColor?['color'] as Color? ?? Colors.grey;

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
                          return const Icon(Icons.phone_android_rounded, size: 80, color: Colors.grey);
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
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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
                                const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
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
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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
    );
  }

  // ========== APP BAR ==========
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF0F172A)),
        onPressed: () => Navigator.pop(context),
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
            _isFavorited ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            color: _isFavorited ? const Color(0xFFFF3B30) : const Color(0xFF94A3B8),
            size: 24,
          ),
          onPressed: () {
            setState(() {
              _isFavorited = !_isFavorited;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  _isFavorited ? 'Added to favorites ❤️' : 'Removed from favorites',
                ),
                duration: const Duration(seconds: 1),
                backgroundColor: _isFavorited ? const Color(0xFFFF3B30) : Colors.grey,
              ),
            );
          },
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
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              colorVariants[_selectedColorIndex]['name'],
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: isSelected ? color : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? Colors.transparent : Colors.grey.shade300,
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
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
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
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
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
                    color: isSelected ? Colors.transparent : Colors.grey.shade300,
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
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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
                            color: isSelected ? Colors.white : Colors.grey.shade700,
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
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('🛒 Added to cart!'),
                  backgroundColor: Color(0xFF007BF6),
                ),
              );
            },
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
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
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
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Reserve in Store',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
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
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Available at Phnom Penh Branch',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
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
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 13,
                  ),
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
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 13,
                  ),
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
                  content: Text('✅ Reserved successfully! Pick up at Phnom Penh Branch'),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Full Specifications',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ..._fullSpecs.map((section) {
          final items = section['items'] as List<Map<String, dynamic>>? ?? [];
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.shade200),
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
              ),
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
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
      default:
        return Icons.circle_outlined;
    }
  }

  final List<Map<String, dynamic>> _fullSpecs = [
    {'title': 'General', 'items': [
      {'label': 'Brand', 'value': 'Apple'},
      {'label': 'Model', 'value': 'iPhone 17 Pro Max'},
      {'label': 'Release Date', 'value': 'September 2026'},
      {'label': 'Status', 'value': 'Available'},
    ]},
    {'title': 'Display', 'items': [
      {'label': 'Type', 'value': 'Super Retina XDR OLED'},
      {'label': 'Size', 'value': '6.9 inches'},
      {'label': 'Resolution', 'value': '2796 x 1290 pixels'},
      {'label': 'Refresh Rate', 'value': '120Hz'},
      {'label': 'Brightness', 'value': '2000 nits (peak)'},
    ]},
    {'title': 'Performance', 'items': [
      {'label': 'Processor', 'value': 'A19 Pro Chip'},
      {'label': 'CPU', 'value': '6-core CPU'},
      {'label': 'GPU', 'value': '6-core GPU'},
      {'label': 'Neural Engine', 'value': '16-core'},
    ]},
    {'title': 'Camera', 'items': [
      {'label': 'Main Camera', 'value': '48MP Main'},
      {'label': 'Ultra Wide', 'value': '12MP'},
      {'label': 'Telephoto', 'value': '12MP'},
      {'label': 'LiDAR Scanner', 'value': 'Yes'},
      {'label': 'Video Recording', 'value': '8K at 60fps'},
    ]},
    {'title': 'Battery & Charging', 'items': [
      {'label': 'Battery Capacity', 'value': '4,685 mAh'},
      {'label': 'Charging', 'value': 'Fast Charging'},
      {'label': 'Wireless Charging', 'value': 'Yes (MagSafe)'},
      {'label': 'Battery Life', 'value': 'Up to 29 hours'},
    ]},
    {'title': 'Connectivity', 'items': [
      {'label': '5G', 'value': 'Yes'},
      {'label': 'Wi-Fi', 'value': 'Wi-Fi 7'},
      {'label': 'Bluetooth', 'value': '5.4'},
      {'label': 'NFC', 'value': 'Yes'},
      {'label': 'USB', 'value': 'USB-C 3.2'},
    ]},
    {'title': 'Sensors', 'items': [
      {'label': 'Face ID', 'value': 'Yes'},
      {'label': 'Accelerometer', 'value': 'Yes'},
      {'label': 'Gyroscope', 'value': 'Yes'},
      {'label': 'Barometer', 'value': 'Yes'},
    ]},
  ];
}