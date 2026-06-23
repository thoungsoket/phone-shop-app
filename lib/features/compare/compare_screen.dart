import 'package:flutter/material.dart';
import '../data/product_data.dart';

class CompareScreen extends StatefulWidget {
  const CompareScreen({super.key});

  @override
  State<CompareScreen> createState() => _CompareScreenState();
}

class _CompareScreenState extends State<CompareScreen> {
  List<Map<String, dynamic>> _selectedProducts = [];
  final int _maxCompare = 3;
  
  // Cache for product colors
  final Map<String, Color> _productColors = {};
  final Map<String, String> _productColorNames = {};
  final Map<String, Color> _productTextColors = {};

  // ========== PRODUCT TO COLOR MAPPING ==========
  static const Map<String, String> _productColorMap = {
    'iPhone 17 Pro Max': 'Orange',
    'iPhone 17 Pro': 'White',
    'iPhone 17': 'Purple',
    'iPhone 16 Pro Max': 'White Titanium',
    'iPhone 16 Pro': 'Black Titanium',
    'iPhone 16 Plus': 'Pink',
    'iPhone 16': 'Lavender',
    'iPhone XR': 'Light Blue',
    'iPhone XS Max': 'Dark Grey',
    'iPhone 15 Pro Max': 'Natural Titanium',
    'iPhone 15 Pro': 'Black Titanium',
    'iPhone 15': 'Light Pink',
    'Galaxy S26 Ultra': 'Titanium Black',
    'Galaxy S26 Plus': 'Titanium Black',
    'Galaxy S26': 'White',
    'Galaxy Z Fold 7': 'Blue',
    'Galaxy Z Flip 7': 'Black',
    'Galaxy Z Fold 6': 'Grey',
    'Galaxy Z Flip 6': 'Light Blue',
    'Galaxy A55 5G': 'White',
    'Galaxy A35 5G': 'White',
    'Galaxy S25 Ultra': 'Titanium Gray',
    'Galaxy S25 Plus': 'White',
    'Xiaomi 15 Pro': 'Silver',
    'Xiaomi 15': 'Mint',
    'Xiaomi 14 Pro': 'Black',
    'Xiaomi 14': 'Green',
    'Xiaomi 14T Pro': 'Titanium Gray',
    'Xiaomi 13T Pro': 'Mint',
    'Xiaomi 13': 'Black',
    'Xiaomi 12 Pro': 'Light Blue',
    'Xiaomi 12': 'Black',
    'Xiaomi Poco F6': 'Rose Gold',
    'Oppo Find X8 Ultra': 'White',
    'Oppo Find X8 Pro': 'Black',
    'Oppo Find X8': 'Light Pink',
    'Oppo Find X7 Ultra': 'Black',
    'Oppo Find X7': 'Silver',
    'Oppo Reno 13 Pro': 'White',
    'Oppo Reno 13': 'White',
    'Oppo Reno 12 Pro': 'Silver',
    'Oppo Reno 12': 'Silver',
    'Oppo A79 5G': 'Mint',
    'OnePlus 12': 'Flowy Emerald',
    'OnePlus 12R': 'Light Blue',
    'OnePlus 11': 'Black',
    'OnePlus Nord 4': 'Silver',
    'OnePlus Nord 3': 'Black',
    'OnePlus Open': 'Black',
    'Vivo X100 Ultra': 'White',
    'Vivo X100 Pro': 'Black',
    'Vivo X100': 'Orange',
    'Vivo V40 Pro': 'Grey',
    'Vivo V40': 'Purple',
  };

  // ========== COLOR NAME TO HEX MAPPING ==========
  static const Map<String, Color> _colorHexMap = {
    'Black': Color(0xFF000000),
    'White': Color(0xFFFFFFFF),
    'Grey': Color(0xFF808080),
    'Silver': Color(0xFFC0C0C0),
    'Gold': Color(0xFFD4AF37),
    'Pink': Color(0xFFFFB6C1),
    'Purple': Color(0xFF800080),
    'Green': Color(0xFF228B22),
    'Orange': Color(0xFFFFA500),
    'Blue': Color(0xFF1E90FF),
    'Natural Titanium': Color(0xFFBFBFBF),
    'Black Titanium': Color(0xFF2C2C2C),
    'White Titanium': Color(0xFFE8E8E8),
    'Light Pink': Color(0xFFFFB6C1),
    'Lavender': Color(0xFFB6A1D9),
    'Light Blue': Color(0xFF87CEEB),
    'Dark Grey': Color(0xFF2C2C2C),
    'Titanium Black': Color(0xFF1A1A1A),
    'Titanium Gray': Color(0xFF8C8C8C),
    'Mint': Color(0xFF98FF98),
    'Rose Gold': Color(0xFFE8B4B8),
    'Flowy Emerald': Color(0xFF50C878),
  };

  // ========== SPECIFICATION KEYS ==========
  final List<String> _specKeys = [
    'processor',
    'ram',
    'storage',
    'battery',
    'camera',
    'display',
    'os',
  ];

  final List<String> _specLabels = [
    'Processor',
    'RAM',
    'Storage',
    'Battery',
    'Camera',
    'Display',
    'OS',
  ];

  // Phone specifications mapping
  final Map<String, Map<String, String>> _phoneSpecs = {
    'iPhone 17 Pro Max': {
      'processor': 'A19 Pro',
      'ram': '8GB',
      'storage': '256GB - 1TB',
      'battery': '4,685 mAh',
      'camera': '48MP Main, 12MP UW, 12MP Tele, LiDAR',
      'display': '6.9" Super Retina XDR 120Hz',
      'os': 'iOS 18',
    },
    'iPhone 17 Pro': {
      'processor': 'A19 Pro',
      'ram': '8GB',
      'storage': '128GB - 1TB',
      'battery': '3,655 mAh',
      'camera': '48MP Main, 12MP UW, 12MP Tele',
      'display': '6.3" Super Retina XDR 120Hz',
      'os': 'iOS 18',
    },
    'iPhone 17': {
      'processor': 'A19',
      'ram': '6GB',
      'storage': '128GB - 512GB',
      'battery': '3,274 mAh',
      'camera': '48MP Main, 12MP UW',
      'display': '6.1" Super Retina XDR',
      'os': 'iOS 18',
    },
    'iPhone 16 Pro Max': {
      'processor': 'A18 Pro',
      'ram': '8GB',
      'storage': '256GB - 1TB',
      'battery': '4,685 mAh',
      'camera': '48MP Main, 12MP UW, 12MP Tele, LiDAR',
      'display': '6.9" Super Retina XDR 120Hz',
      'os': 'iOS 17',
    },
    'iPhone 16 Pro': {
      'processor': 'A18 Pro',
      'ram': '8GB',
      'storage': '128GB - 1TB',
      'battery': '3,655 mAh',
      'camera': '48MP Main, 12MP UW, 12MP Tele',
      'display': '6.3" Super Retina XDR 120Hz',
      'os': 'iOS 17',
    },
    'iPhone 16 Plus': {
      'processor': 'A18',
      'ram': '6GB',
      'storage': '128GB - 512GB',
      'battery': '4,383 mAh',
      'camera': '48MP Main, 12MP UW',
      'display': '6.7" Super Retina XDR',
      'os': 'iOS 17',
    },
    'iPhone 16': {
      'processor': 'A18',
      'ram': '6GB',
      'storage': '128GB - 512GB',
      'battery': '3,274 mAh',
      'camera': '48MP Main, 12MP UW',
      'display': '6.1" Super Retina XDR',
      'os': 'iOS 17',
    },
    'iPhone XR': {
      'processor': 'A12 Bionic',
      'ram': '3GB',
      'storage': '64GB - 256GB',
      'battery': '2,942 mAh',
      'camera': '12MP Main',
      'display': '6.1" Liquid Retina HD',
      'os': 'iOS 17',
    },
    'iPhone XS Max': {
      'processor': 'A12 Bionic',
      'ram': '4GB',
      'storage': '64GB - 512GB',
      'battery': '3,174 mAh',
      'camera': '12MP Main, 12MP Tele',
      'display': '6.5" Super Retina HD',
      'os': 'iOS 17',
    },
    'iPhone 15 Pro Max': {
      'processor': 'A17 Pro',
      'ram': '8GB',
      'storage': '256GB - 1TB',
      'battery': '4,422 mAh',
      'camera': '48MP Main, 12MP UW, 12MP Tele',
      'display': '6.7" Super Retina XDR 120Hz',
      'os': 'iOS 17',
    },
    'iPhone 15 Pro': {
      'processor': 'A17 Pro',
      'ram': '8GB',
      'storage': '128GB - 1TB',
      'battery': '3,274 mAh',
      'camera': '48MP Main, 12MP UW, 12MP Tele',
      'display': '6.1" Super Retina XDR 120Hz',
      'os': 'iOS 17',
    },
    'iPhone 15': {
      'processor': 'A16 Bionic',
      'ram': '6GB',
      'storage': '128GB - 512GB',
      'battery': '3,349 mAh',
      'camera': '48MP Main, 12MP UW',
      'display': '6.1" Super Retina XDR',
      'os': 'iOS 17',
    },
    'Galaxy S26 Ultra': {
      'processor': 'Snapdragon 8 Gen 5',
      'ram': '16GB',
      'storage': '256GB - 1TB',
      'battery': '5,500 mAh',
      'camera': '200MP Main, 12MP UW, 50MP/10MP Tele',
      'display': '6.8" Dynamic AMOLED 2X 120Hz',
      'os': 'Android 15 (One UI 7)',
    },
    'Galaxy S26 Plus': {
      'processor': 'Snapdragon 8 Gen 5',
      'ram': '12GB',
      'storage': '256GB - 512GB',
      'battery': '4,900 mAh',
      'camera': '50MP Main, 12MP UW, 10MP Tele',
      'display': '6.7" Dynamic AMOLED 2X 120Hz',
      'os': 'Android 15 (One UI 7)',
    },
    'Galaxy S26': {
      'processor': 'Snapdragon 8 Gen 5',
      'ram': '8GB',
      'storage': '128GB - 512GB',
      'battery': '4,000 mAh',
      'camera': '50MP Main, 12MP UW',
      'display': '6.2" Dynamic AMOLED 2X 120Hz',
      'os': 'Android 15 (One UI 7)',
    },
    'Galaxy Z Fold 7': {
      'processor': 'Snapdragon 8 Gen 5',
      'ram': '16GB',
      'storage': '256GB - 1TB',
      'battery': '4,400 mAh',
      'camera': '50MP Main, 12MP UW, 10MP Tele',
      'display': '7.6" Dynamic AMOLED 2X 120Hz',
      'os': 'Android 15 (One UI 7)',
    },
    'Galaxy Z Flip 7': {
      'processor': 'Snapdragon 8 Gen 5',
      'ram': '12GB',
      'storage': '256GB - 512GB',
      'battery': '3,700 mAh',
      'camera': '50MP Main, 12MP UW',
      'display': '6.7" Dynamic AMOLED 2X 120Hz',
      'os': 'Android 15 (One UI 7)',
    },
    'Galaxy Z Fold 6': {
      'processor': 'Snapdragon 8 Gen 4',
      'ram': '12GB',
      'storage': '256GB - 1TB',
      'battery': '4,400 mAh',
      'camera': '50MP Main, 12MP UW, 10MP Tele',
      'display': '7.6" Dynamic AMOLED 2X 120Hz',
      'os': 'Android 14 (One UI 6)',
    },
    'Galaxy Z Flip 6': {
      'processor': 'Snapdragon 8 Gen 4',
      'ram': '12GB',
      'storage': '256GB - 512GB',
      'battery': '3,700 mAh',
      'camera': '50MP Main, 12MP UW',
      'display': '6.7" Dynamic AMOLED 2X 120Hz',
      'os': 'Android 14 (One UI 6)',
    },
    'Galaxy A55 5G': {
      'processor': 'Exynos 1480',
      'ram': '8GB',
      'storage': '128GB - 256GB',
      'battery': '5,000 mAh',
      'camera': '50MP Main, 12MP UW, 5MP Macro',
      'display': '6.6" Super AMOLED 120Hz',
      'os': 'Android 14 (One UI 6)',
    },
    'Galaxy A35 5G': {
      'processor': 'Exynos 1380',
      'ram': '8GB',
      'storage': '128GB - 256GB',
      'battery': '5,000 mAh',
      'camera': '50MP Main, 8MP UW, 5MP Macro',
      'display': '6.6" Super AMOLED 120Hz',
      'os': 'Android 14 (One UI 6)',
    },
    'Galaxy S25 Ultra': {
      'processor': 'Snapdragon 8 Gen 4',
      'ram': '16GB',
      'storage': '256GB - 1TB',
      'battery': '5,000 mAh',
      'camera': '200MP Main, 12MP UW, 50MP/10MP Tele',
      'display': '6.8" Dynamic AMOLED 2X 120Hz',
      'os': 'Android 14 (One UI 6)',
    },
    'Galaxy S25 Plus': {
      'processor': 'Snapdragon 8 Gen 4',
      'ram': '12GB',
      'storage': '256GB - 512GB',
      'battery': '4,900 mAh',
      'camera': '50MP Main, 12MP UW, 10MP Tele',
      'display': '6.7" Dynamic AMOLED 2X 120Hz',
      'os': 'Android 14 (One UI 6)',
    },
    'Galaxy Tab S10 Ultra': {
      'processor': 'MediaTek Dimensity 9300+',
      'ram': '16GB',
      'storage': '256GB - 1TB',
      'battery': '11,200 mAh',
      'camera': '13MP Main, 8MP UW',
      'display': '14.6" Dynamic AMOLED 2X 120Hz',
      'os': 'Android 14 (One UI 6)',
    },
    'Galaxy Tab S10 Plus': {
      'processor': 'MediaTek Dimensity 9300+',
      'ram': '12GB',
      'storage': '256GB - 512GB',
      'battery': '10,090 mAh',
      'camera': '13MP Main, 8MP UW',
      'display': '12.4" Dynamic AMOLED 2X 120Hz',
      'os': 'Android 14 (One UI 6)',
    },
    'Galaxy Tab S10': {
      'processor': 'MediaTek Dimensity 9300+',
      'ram': '12GB',
      'storage': '256GB - 512GB',
      'battery': '8,000 mAh',
      'camera': '13MP Main, 8MP UW',
      'display': '11.0" Dynamic AMOLED 2X 120Hz',
      'os': 'Android 14 (One UI 6)',
    },
    'Galaxy Tab S9 FE': {
      'processor': 'Exynos 1380',
      'ram': '8GB',
      'storage': '128GB - 256GB',
      'battery': '8,000 mAh',
      'camera': '8MP Main',
      'display': '10.9" TFT LCD 90Hz',
      'os': 'Android 13 (One UI 5)',
    },
    'Galaxy Tab A9+': {
      'processor': 'Snapdragon 695',
      'ram': '8GB',
      'storage': '128GB',
      'battery': '7,040 mAh',
      'camera': '8MP Main',
      'display': '11.0" TFT LCD 90Hz',
      'os': 'Android 13 (One UI 5)',
    },
    'Galaxy Tab A9': {
      'processor': 'MediaTek Helio G99',
      'ram': '8GB',
      'storage': '128GB',
      'battery': '5,100 mAh',
      'camera': '8MP Main',
      'display': '8.7" TFT LCD 60Hz',
      'os': 'Android 13 (One UI 5)',
    },
    'Galaxy Watch 7 Ultra': {
      'processor': 'Exynos W1000',
      'ram': '2GB',
      'storage': '32GB',
      'battery': '590 mAh',
      'camera': 'N/A',
      'display': '1.5" Super AMOLED',
      'os': 'Wear OS 5',
    },
    'Galaxy Watch 7': {
      'processor': 'Exynos W1000',
      'ram': '2GB',
      'storage': '32GB',
      'battery': '425 mAh',
      'camera': 'N/A',
      'display': '1.5" Super AMOLED',
      'os': 'Wear OS 5',
    },
    'Galaxy Watch 7 Classic': {
      'processor': 'Exynos W1000',
      'ram': '2GB',
      'storage': '32GB',
      'battery': '425 mAh',
      'camera': 'N/A',
      'display': '1.5" Super AMOLED',
      'os': 'Wear OS 5',
    },
    'Galaxy Watch FE': {
      'processor': 'Exynos W920',
      'ram': '1.5GB',
      'storage': '16GB',
      'battery': '247 mAh',
      'camera': 'N/A',
      'display': '1.2" Super AMOLED',
      'os': 'Wear OS 4',
    },
    'Galaxy Watch 6': {
      'processor': 'Exynos W930',
      'ram': '2GB',
      'storage': '16GB',
      'battery': '425 mAh',
      'camera': 'N/A',
      'display': '1.5" Super AMOLED',
      'os': 'Wear OS 4',
    },
    'Galaxy Watch 6 Classic': {
      'processor': 'Exynos W930',
      'ram': '2GB',
      'storage': '16GB',
      'battery': '425 mAh',
      'camera': 'N/A',
      'display': '1.5" Super AMOLED',
      'os': 'Wear OS 4',
    },
    'Galaxy Buds 3 Pro': {
      'processor': 'N/A',
      'ram': 'N/A',
      'storage': 'N/A',
      'battery': 'N/A',
      'camera': 'N/A',
      'display': 'N/A',
      'os': 'N/A',
    },
    'Galaxy Buds 3': {
      'processor': 'N/A',
      'ram': 'N/A',
      'storage': 'N/A',
      'battery': 'N/A',
      'camera': 'N/A',
      'display': 'N/A',
      'os': 'N/A',
    },
    'Galaxy Buds 2 Pro': {
      'processor': 'N/A',
      'ram': 'N/A',
      'storage': 'N/A',
      'battery': 'N/A',
      'camera': 'N/A',
      'display': 'N/A',
      'os': 'N/A',
    },
    'Galaxy S-Pen Pro': {
      'processor': 'N/A',
      'ram': 'N/A',
      'storage': 'N/A',
      'battery': 'N/A',
      'camera': 'N/A',
      'display': 'N/A',
      'os': 'N/A',
    },
    'Galaxy Wireless Charger': {
      'processor': 'N/A',
      'ram': 'N/A',
      'storage': 'N/A',
      'battery': 'N/A',
      'camera': 'N/A',
      'display': 'N/A',
      'os': 'N/A',
    },
    'Galaxy Smart Case': {
      'processor': 'N/A',
      'ram': 'N/A',
      'storage': 'N/A',
      'battery': 'N/A',
      'camera': 'N/A',
      'display': 'N/A',
      'os': 'N/A',
    },
    'Xiaomi 15 Pro': {
      'processor': 'Snapdragon 8 Gen 4',
      'ram': '16GB',
      'storage': '256GB - 1TB',
      'battery': '5,200 mAh',
      'camera': '50MP Main, 50MP UW, 50MP Tele',
      'display': '6.73" AMOLED 120Hz',
      'os': 'Android 15 (HyperOS 2)',
    },
    'Xiaomi 15': {
      'processor': 'Snapdragon 8 Gen 4',
      'ram': '12GB',
      'storage': '256GB - 512GB',
      'battery': '4,800 mAh',
      'camera': '50MP Main, 50MP UW, 50MP Tele',
      'display': '6.36" AMOLED 120Hz',
      'os': 'Android 15 (HyperOS 2)',
    },
    'Xiaomi 14 Pro': {
      'processor': 'Snapdragon 8 Gen 3',
      'ram': '16GB',
      'storage': '256GB - 1TB',
      'battery': '4,880 mAh',
      'camera': '50MP Main, 50MP UW, 50MP Tele',
      'display': '6.73" AMOLED 120Hz',
      'os': 'Android 14 (HyperOS)',
    },
    'Xiaomi 14': {
      'processor': 'Snapdragon 8 Gen 3',
      'ram': '12GB',
      'storage': '256GB - 512GB',
      'battery': '4,610 mAh',
      'camera': '50MP Main, 50MP UW, 50MP Tele',
      'display': '6.36" AMOLED 120Hz',
      'os': 'Android 14 (HyperOS)',
    },
    'Xiaomi 14T Pro': {
      'processor': 'MediaTek Dimensity 9300+',
      'ram': '12GB',
      'storage': '256GB - 1TB',
      'battery': '5,000 mAh',
      'camera': '50MP Main, 12MP UW, 50MP Tele',
      'display': '6.67" AMOLED 144Hz',
      'os': 'Android 14 (HyperOS)',
    },
    'Xiaomi 13T Pro': {
      'processor': 'MediaTek Dimensity 9200+',
      'ram': '12GB',
      'storage': '256GB - 512GB',
      'battery': '5,000 mAh',
      'camera': '50MP Main, 12MP UW, 50MP Tele',
      'display': '6.67" AMOLED 144Hz',
      'os': 'Android 13 (MIUI 14)',
    },
    'Xiaomi 13': {
      'processor': 'Snapdragon 8 Gen 2',
      'ram': '12GB',
      'storage': '256GB - 512GB',
      'battery': '4,500 mAh',
      'camera': '50MP Main, 12MP UW, 10MP Tele',
      'display': '6.36" AMOLED 120Hz',
      'os': 'Android 13 (MIUI 14)',
    },
    'Xiaomi 12 Pro': {
      'processor': 'Snapdragon 8 Gen 1',
      'ram': '12GB',
      'storage': '256GB - 512GB',
      'battery': '4,600 mAh',
      'camera': '50MP Main, 50MP UW, 50MP Tele',
      'display': '6.73" AMOLED 120Hz',
      'os': 'Android 12 (MIUI 13)',
    },
    'Xiaomi 12': {
      'processor': 'Snapdragon 8 Gen 1',
      'ram': '8GB',
      'storage': '128GB - 256GB',
      'battery': '4,500 mAh',
      'camera': '50MP Main, 13MP UW, 5MP Macro',
      'display': '6.28" AMOLED 120Hz',
      'os': 'Android 12 (MIUI 13)',
    },
    'Xiaomi Poco F6': {
      'processor': 'Snapdragon 8s Gen 3',
      'ram': '12GB',
      'storage': '256GB - 512GB',
      'battery': '5,000 mAh',
      'camera': '50MP Main, 8MP UW',
      'display': '6.67" AMOLED 120Hz',
      'os': 'Android 14 (HyperOS)',
    },
    'Xiaomi Pad 7 Pro': {
      'processor': 'Snapdragon 8s Gen 3',
      'ram': '12GB',
      'storage': '256GB - 512GB',
      'battery': '10,000 mAh',
      'camera': '50MP Main',
      'display': '11.2" LCD 144Hz',
      'os': 'Android 14 (HyperOS)',
    },
    'Xiaomi Pad 7': {
      'processor': 'Snapdragon 7+ Gen 3',
      'ram': '8GB',
      'storage': '128GB - 256GB',
      'battery': '10,000 mAh',
      'camera': '13MP Main',
      'display': '11.2" LCD 144Hz',
      'os': 'Android 14 (HyperOS)',
    },
    'Xiaomi Pad 6': {
      'processor': 'Snapdragon 870',
      'ram': '8GB',
      'storage': '128GB - 256GB',
      'battery': '8,840 mAh',
      'camera': '13MP Main',
      'display': '11.0" LCD 144Hz',
      'os': 'Android 13 (MIUI 14)',
    },
    'Xiaomi Pad 6S Pro': {
      'processor': 'Snapdragon 8 Gen 2',
      'ram': '12GB',
      'storage': '256GB - 512GB',
      'battery': '10,000 mAh',
      'camera': '50MP Main',
      'display': '12.4" LCD 144Hz',
      'os': 'Android 14 (HyperOS)',
    },
    'Xiaomi Watch 3 Pro': {
      'processor': 'N/A',
      'ram': 'N/A',
      'storage': 'N/A',
      'battery': 'N/A',
      'camera': 'N/A',
      'display': 'N/A',
      'os': 'N/A',
    },
    'Xiaomi Watch 2 Pro': {
      'processor': 'N/A',
      'ram': 'N/A',
      'storage': 'N/A',
      'battery': 'N/A',
      'camera': 'N/A',
      'display': 'N/A',
      'os': 'N/A',
    },
    'Xiaomi Band 9': {
      'processor': 'N/A',
      'ram': 'N/A',
      'storage': 'N/A',
      'battery': 'N/A',
      'camera': 'N/A',
      'display': 'N/A',
      'os': 'N/A',
    },
    'Xiaomi Band 8 Pro': {
      'processor': 'N/A',
      'ram': 'N/A',
      'storage': 'N/A',
      'battery': 'N/A',
      'camera': 'N/A',
      'display': 'N/A',
      'os': 'N/A',
    },
    'Xiaomi Band 8': {
      'processor': 'N/A',
      'ram': 'N/A',
      'storage': 'N/A',
      'battery': 'N/A',
      'camera': 'N/A',
      'display': 'N/A',
      'os': 'N/A',
    },
    'Xiaomi Buds 4 Pro': {
      'processor': 'N/A',
      'ram': 'N/A',
      'storage': 'N/A',
      'battery': 'N/A',
      'camera': 'N/A',
      'display': 'N/A',
      'os': 'N/A',
    },
    'Xiaomi Buds 4': {
      'processor': 'N/A',
      'ram': 'N/A',
      'storage': 'N/A',
      'battery': 'N/A',
      'camera': 'N/A',
      'display': 'N/A',
      'os': 'N/A',
    },
    'Xiaomi Buds 3 Pro': {
      'processor': 'N/A',
      'ram': 'N/A',
      'storage': 'N/A',
      'battery': 'N/A',
      'camera': 'N/A',
      'display': 'N/A',
      'os': 'N/A',
    },
    'Xiaomi Power Bank 3': {
      'processor': 'N/A',
      'ram': 'N/A',
      'storage': 'N/A',
      'battery': 'N/A',
      'camera': 'N/A',
      'display': 'N/A',
      'os': 'N/A',
    },
    'Xiaomi 67W Charger': {
      'processor': 'N/A',
      'ram': 'N/A',
      'storage': 'N/A',
      'battery': 'N/A',
      'camera': 'N/A',
      'display': 'N/A',
      'os': 'N/A',
    },
    'Xiaomi Smart Band Strap': {
      'processor': 'N/A',
      'ram': 'N/A',
      'storage': 'N/A',
      'battery': 'N/A',
      'camera': 'N/A',
      'display': 'N/A',
      'os': 'N/A',
    },
    'Oppo Find X8 Ultra': {
      'processor': 'MediaTek Dimensity 9400',
      'ram': '16GB',
      'storage': '256GB - 1TB',
      'battery': '5,100 mAh',
      'camera': '50MP Main, 50MP UW, 50MP Tele',
      'display': '6.82" AMOLED 120Hz',
      'os': 'Android 15 (ColorOS 15)',
    },
    'Oppo Find X8 Pro': {
      'processor': 'MediaTek Dimensity 9400',
      'ram': '12GB',
      'storage': '256GB - 512GB',
      'battery': '4,800 mAh',
      'camera': '50MP Main, 50MP UW, 50MP Tele',
      'display': '6.78" AMOLED 120Hz',
      'os': 'Android 15 (ColorOS 15)',
    },
    'Oppo Find X8': {
      'processor': 'MediaTek Dimensity 9400',
      'ram': '12GB',
      'storage': '256GB - 512GB',
      'battery': '4,800 mAh',
      'camera': '50MP Main, 50MP UW, 50MP Tele',
      'display': '6.78" AMOLED 120Hz',
      'os': 'Android 15 (ColorOS 15)',
    },
    'Oppo Find X7 Ultra': {
      'processor': 'Snapdragon 8 Gen 3',
      'ram': '16GB',
      'storage': '256GB - 1TB',
      'battery': '5,000 mAh',
      'camera': '50MP Main, 50MP UW, 50MP Tele',
      'display': '6.82" AMOLED 120Hz',
      'os': 'Android 14 (ColorOS 14)',
    },
    'Oppo Find X7': {
      'processor': 'Snapdragon 8 Gen 3',
      'ram': '12GB',
      'storage': '256GB - 512GB',
      'battery': '4,800 mAh',
      'camera': '50MP Main, 50MP UW, 50MP Tele',
      'display': '6.78" AMOLED 120Hz',
      'os': 'Android 14 (ColorOS 14)',
    },
    'Oppo Reno 13 Pro': {
      'processor': 'MediaTek Dimensity 8300',
      'ram': '12GB',
      'storage': '256GB - 512GB',
      'battery': '5,100 mAh',
      'camera': '50MP Main, 8MP UW, 2MP Macro',
      'display': '6.7" AMOLED 120Hz',
      'os': 'Android 14 (ColorOS 14)',
    },
    'Oppo Reno 13': {
      'processor': 'MediaTek Dimensity 8300',
      'ram': '12GB',
      'storage': '256GB - 512GB',
      'battery': '5,100 mAh',
      'camera': '50MP Main, 8MP UW, 2MP Macro',
      'display': '6.7" AMOLED 120Hz',
      'os': 'Android 14 (ColorOS 14)',
    },
    'Oppo Reno 12 Pro': {
      'processor': 'MediaTek Dimensity 7300',
      'ram': '12GB',
      'storage': '256GB - 512GB',
      'battery': '5,000 mAh',
      'camera': '50MP Main, 8MP UW, 2MP Macro',
      'display': '6.7" AMOLED 120Hz',
      'os': 'Android 14 (ColorOS 14)',
    },
    'Oppo Reno 12': {
      'processor': 'MediaTek Dimensity 7300',
      'ram': '12GB',
      'storage': '256GB - 512GB',
      'battery': '5,000 mAh',
      'camera': '50MP Main, 8MP UW, 2MP Macro',
      'display': '6.7" AMOLED 120Hz',
      'os': 'Android 14 (ColorOS 14)',
    },
    'Oppo A79 5G': {
      'processor': 'MediaTek Dimensity 6020',
      'ram': '8GB',
      'storage': '128GB - 256GB',
      'battery': '5,000 mAh',
      'camera': '50MP Main, 2MP Depth',
      'display': '6.72" LCD 60Hz',
      'os': 'Android 13 (ColorOS 13)',
    },
    'Oppo Pad 4 Pro': {
      'processor': 'Snapdragon 8 Gen 3',
      'ram': '12GB',
      'storage': '256GB - 512GB',
      'battery': '9,510 mAh',
      'camera': '13MP Main',
      'display': '12.1" LCD 144Hz',
      'os': 'Android 14 (ColorOS 14)',
    },
    'Oppo Pad 3 Pro': {
      'processor': 'Snapdragon 8 Gen 3',
      'ram': '12GB',
      'storage': '256GB - 512GB',
      'battery': '9,510 mAh',
      'camera': '13MP Main',
      'display': '12.1" LCD 144Hz',
      'os': 'Android 14 (ColorOS 14)',
    },
    'Oppo Pad 3': {
      'processor': 'Snapdragon 8 Gen 3',
      'ram': '12GB',
      'storage': '256GB - 512GB',
      'battery': '9,510 mAh',
      'camera': '13MP Main',
      'display': '11.61" LCD 144Hz',
      'os': 'Android 14 (ColorOS 14)',
    },
    'Oppo Watch 5 Pro': {
      'processor': 'N/A',
      'ram': 'N/A',
      'storage': 'N/A',
      'battery': 'N/A',
      'camera': 'N/A',
      'display': 'N/A',
      'os': 'N/A',
    },
    'Oppo Watch 4 Pro': {
      'processor': 'N/A',
      'ram': 'N/A',
      'storage': 'N/A',
      'battery': 'N/A',
      'camera': 'N/A',
      'display': 'N/A',
      'os': 'N/A',
    },
    'Oppo Band 3': {
      'processor': 'N/A',
      'ram': 'N/A',
      'storage': 'N/A',
      'battery': 'N/A',
      'camera': 'N/A',
      'display': 'N/A',
      'os': 'N/A',
    },
    'Oppo Enco X4': {
      'processor': 'N/A',
      'ram': 'N/A',
      'storage': 'N/A',
      'battery': 'N/A',
      'camera': 'N/A',
      'display': 'N/A',
      'os': 'N/A',
    },
    'Oppo Enco X3': {
      'processor': 'N/A',
      'ram': 'N/A',
      'storage': 'N/A',
      'battery': 'N/A',
      'camera': 'N/A',
      'display': 'N/A',
      'os': 'N/A',
    },
    'Oppo Enco Air 4': {
      'processor': 'N/A',
      'ram': 'N/A',
      'storage': 'N/A',
      'battery': 'N/A',
      'camera': 'N/A',
      'display': 'N/A',
      'os': 'N/A',
    },
    'Oppo Enco Air 3': {
      'processor': 'N/A',
      'ram': 'N/A',
      'storage': 'N/A',
      'battery': 'N/A',
      'camera': 'N/A',
      'display': 'N/A',
      'os': 'N/A',
    },
    'Oppo SuperVOOC Charger': {
      'processor': 'N/A',
      'ram': 'N/A',
      'storage': 'N/A',
      'battery': 'N/A',
      'camera': 'N/A',
      'display': 'N/A',
      'os': 'N/A',
    },
    'OnePlus 12': {
      'processor': 'Snapdragon 8 Gen 3',
      'ram': '16GB',
      'storage': '256GB - 512GB',
      'battery': '5,400 mAh',
      'camera': '50MP Main, 48MP UW, 64MP Tele',
      'display': '6.82" AMOLED 120Hz',
      'os': 'Android 14 (OxygenOS 14)',
    },
    'OnePlus 12R': {
      'processor': 'Snapdragon 8 Gen 3',
      'ram': '12GB',
      'storage': '256GB - 512GB',
      'battery': '5,500 mAh',
      'camera': '50MP Main, 8MP UW, 2MP Macro',
      'display': '6.78" AMOLED 120Hz',
      'os': 'Android 14 (OxygenOS 14)',
    },
    'OnePlus 11': {
      'processor': 'Snapdragon 8 Gen 2',
      'ram': '12GB',
      'storage': '256GB - 512GB',
      'battery': '5,000 mAh',
      'camera': '50MP Main, 48MP UW, 32MP Tele',
      'display': '6.7" AMOLED 120Hz',
      'os': 'Android 13 (OxygenOS 13)',
    },
    'OnePlus Nord 4': {
      'processor': 'Snapdragon 7+ Gen 3',
      'ram': '12GB',
      'storage': '256GB - 512GB',
      'battery': '5,500 mAh',
      'camera': '50MP Main, 8MP UW',
      'display': '6.74" AMOLED 120Hz',
      'os': 'Android 14 (OxygenOS 14)',
    },
    'OnePlus Nord 3': {
      'processor': 'MediaTek Dimensity 9000',
      'ram': '8GB',
      'storage': '128GB - 256GB',
      'battery': '5,000 mAh',
      'camera': '50MP Main, 8MP UW, 2MP Macro',
      'display': '6.74" AMOLED 120Hz',
      'os': 'Android 13 (OxygenOS 13)',
    },
    'OnePlus Open': {
      'processor': 'Snapdragon 8 Gen 3',
      'ram': '16GB',
      'storage': '512GB - 1TB',
      'battery': '4,800 mAh',
      'camera': '48MP Main, 48MP UW, 64MP Tele',
      'display': '7.82" AMOLED 120Hz',
      'os': 'Android 14 (OxygenOS 14)',
    },
    'OnePlus Pad 2': {
      'processor': 'Snapdragon 8 Gen 3',
      'ram': '12GB',
      'storage': '256GB - 512GB',
      'battery': '9,510 mAh',
      'camera': '13MP Main',
      'display': '12.1" LCD 144Hz',
      'os': 'Android 14 (OxygenOS 14)',
    },
    'OnePlus Pad': {
      'processor': 'MediaTek Dimensity 9000',
      'ram': '8GB',
      'storage': '128GB - 256GB',
      'battery': '9,510 mAh',
      'camera': '13MP Main',
      'display': '11.61" LCD 144Hz',
      'os': 'Android 13 (OxygenOS 13)',
    },
    'OnePlus Buds Pro 3': {
      'processor': 'N/A',
      'ram': 'N/A',
      'storage': 'N/A',
      'battery': 'N/A',
      'camera': 'N/A',
      'display': 'N/A',
      'os': 'N/A',
    },
    'OnePlus Buds 3': {
      'processor': 'N/A',
      'ram': 'N/A',
      'storage': 'N/A',
      'battery': 'N/A',
      'camera': 'N/A',
      'display': 'N/A',
      'os': 'N/A',
    },
    'OnePlus Warp Charger': {
      'processor': 'N/A',
      'ram': 'N/A',
      'storage': 'N/A',
      'battery': 'N/A',
      'camera': 'N/A',
      'display': 'N/A',
      'os': 'N/A',
    },
    'Vivo X100 Ultra': {
      'processor': 'MediaTek Dimensity 9300+',
      'ram': '16GB',
      'storage': '256GB - 1TB',
      'battery': '5,500 mAh',
      'camera': '50MP Main, 50MP UW, 200MP Tele',
      'display': '6.78" AMOLED 120Hz',
      'os': 'Android 14 (Funtouch OS 14)',
    },
    'Vivo X100 Pro': {
      'processor': 'MediaTek Dimensity 9300',
      'ram': '16GB',
      'storage': '256GB - 512GB',
      'battery': '5,400 mAh',
      'camera': '50MP Main, 50MP UW, 50MP Tele',
      'display': '6.78" AMOLED 120Hz',
      'os': 'Android 14 (Funtouch OS 14)',
    },
    'Vivo X100': {
      'processor': 'MediaTek Dimensity 9300',
      'ram': '12GB',
      'storage': '256GB - 512GB',
      'battery': '5,000 mAh',
      'camera': '50MP Main, 50MP UW, 50MP Tele',
      'display': '6.78" AMOLED 120Hz',
      'os': 'Android 14 (Funtouch OS 14)',
    },
    'Vivo V40 Pro': {
      'processor': 'MediaTek Dimensity 8300',
      'ram': '12GB',
      'storage': '256GB - 512GB',
      'battery': '5,500 mAh',
      'camera': '50MP Main, 50MP UW, 50MP Tele',
      'display': '6.78" AMOLED 120Hz',
      'os': 'Android 14 (Funtouch OS 14)',
    },
    'Vivo V40': {
      'processor': 'MediaTek Dimensity 8300',
      'ram': '8GB',
      'storage': '128GB - 256GB',
      'battery': '5,500 mAh',
      'camera': '50MP Main, 50MP UW',
      'display': '6.78" AMOLED 120Hz',
      'os': 'Android 14 (Funtouch OS 14)',
    },
    'Vivo TWS 4': {
      'processor': 'N/A',
      'ram': 'N/A',
      'storage': 'N/A',
      'battery': 'N/A',
      'camera': 'N/A',
      'display': 'N/A',
      'os': 'N/A',
    },
    'Vivo TWS 3': {
      'processor': 'N/A',
      'ram': 'N/A',
      'storage': 'N/A',
      'battery': 'N/A',
      'camera': 'N/A',
      'display': 'N/A',
      'os': 'N/A',
    },
    'Vivo 80W Charger': {
      'processor': 'N/A',
      'ram': 'N/A',
      'storage': 'N/A',
      'battery': 'N/A',
      'camera': 'N/A',
      'display': 'N/A',
      'os': 'N/A',
    },
  };

  // ========== GET PRODUCT COLOR ==========
  Color _getProductColor(String productName) {
    final colorName = _productColorMap[productName] ?? 'Gray';
    return _colorHexMap[colorName] ?? Colors.grey.shade400;
  }

  // ========== GET PRODUCT COLOR NAME ==========
  String _getProductColorName(String productName) {
    return _productColorMap[productName] ?? 'Gray';
  }

  // Method to add/remove selected products
  void _toggleProductSelection(Map<String, dynamic> product) {
    setState(() {
      if (_selectedProducts.contains(product)) {
        _selectedProducts.remove(product);
      } else if (_selectedProducts.length < _maxCompare) {
        _selectedProducts.add(product);
        _cacheProductColor(product);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Maximum 3 phones can be compared'),
            backgroundColor: Color(0xFFFF3B30),
          ),
        );
      }
    });
  }

  // Cache product color
  void _cacheProductColor(Map<String, dynamic> product) {
    final String productName = product['name'] as String;
    final String imagePath = product['image'] as String;
    
    if (_productColors.containsKey(imagePath)) return;
    
    final Color color = _getProductColor(productName);
    final String colorName = _getProductColorName(productName);
    final bool isLight = color.computeLuminance() > 0.5;
    final Color textColor = isLight ? Colors.black : Colors.white;
    
    setState(() {
      _productColors[imagePath] = color;
      _productColorNames[imagePath] = colorName;
      _productTextColors[imagePath] = textColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(),
      body: _selectedProducts.isEmpty
          ? _buildEmptyState()
          : _buildCompareContent(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF0F172A)),
        onPressed: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          } else {
            Navigator.pushReplacementNamed(context, '/home');
          }
        },
      ),
      title: const Text(
        'Compare Devices',
        style: TextStyle(
          color: Color(0xFF0F172A),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        if (_selectedProducts.isNotEmpty)
          TextButton(
            onPressed: () {
              setState(() {
                _selectedProducts.clear();
                _productColors.clear();
                _productColorNames.clear();
                _productTextColors.clear();
              });
            },
            child: const Text(
              'Clear All',
              style: TextStyle(
                color: Color(0xFFFF3B30),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: const Color(0xFF007BF6).withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.compare_arrows_rounded,
              size: 64,
              color: Color(0xFF007BF6),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Compare Phones',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Select up to 3 phones to compare\nside-by-side specifications',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: _showPhoneSelectionDialog,
            icon: const Icon(Icons.add_rounded),
            label: const Text('Add Phone'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF007BF6),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 0,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '${_selectedProducts.length}/$_maxCompare selected',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // ========== MAIN COMPARE CONTENT ==========
  Widget _buildCompareContent() {
    return Column(
      children: [
        // Selected phones row
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Row(
            children: [
              ..._selectedProducts.map((product) => Expanded(
                child: _buildSelectedPhoneCard(product),
              )),
              if (_selectedProducts.length < _maxCompare)
                Expanded(
                  child: GestureDetector(
                    onTap: _showPhoneSelectionDialog,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 120,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF94A3B8),
                          width: 1.5,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.add_rounded,
                              color: Color(0xFF94A3B8),
                              size: 28,
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Add Phone',
                              style: TextStyle(
                                color: Color(0xFF94A3B8),
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // HORIZONTALLY SCROLLABLE COMPARE TABLE
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _buildCompareTable(),
            ),
          ),
        ),
      ],
    );
  }

  // ========== COMPARE TABLE ==========
  Widget _buildCompareTable() {
    final int columnCount = _selectedProducts.length;
    
    const double labelWidth = 120.0;
    const double productWidth = 200.0;
    final double totalWidth = labelWidth + (productWidth * columnCount);
    
    return SizedBox(
      width: totalWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          _buildTableHeader(labelWidth, productWidth),
          const SizedBox(height: 8),
          
          // Spec Rows
          ...List.generate(_specKeys.length, (index) {
            return Column(
              children: [
                _buildTableRow(
                  label: _specLabels[index],
                  values: _selectedProducts.map((p) {
                    return _getSpec(p['name'], _specKeys[index]);
                  }).toList(),
                  labelWidth: labelWidth,
                  productWidth: productWidth,
                ),
                if (index < _specKeys.length - 1) 
                  const Divider(height: 1, thickness: 0.5, color: Color(0xFFE2E8F0)),
              ],
            );
          }),
          
          // Color Row
          const Divider(height: 1, thickness: 0.5, color: Color(0xFFE2E8F0)),
          _buildColorTableRow(labelWidth, productWidth),
          
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // ========== TABLE HEADER ==========
  Widget _buildTableHeader(double labelWidth, double productWidth) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F7FF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: labelWidth,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'Specifications',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade700,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
            ),
          ),
          ..._selectedProducts.map((product) {
            final productName = product['name'] as String;
            final Color brandColor = _getProductColor(productName);
            
            return SizedBox(
              width: productWidth,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: brandColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        product['brand'] ?? 'Unknown',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: brandColor,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product['name'],
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // ========== TABLE ROW ==========
  Widget _buildTableRow({
    required String label,
    required List<String> values,
    required double labelWidth,
    required double productWidth,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: labelWidth,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
            ),
          ),
          ...values.map((value) => SizedBox(
            width: productWidth,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF1E293B),
                ),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )),
        ],
      ),
    );
  }

  // ========== COLOR TABLE ROW ==========
  Widget _buildColorTableRow(double labelWidth, double productWidth) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: labelWidth,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'Color',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
            ),
          ),
          ..._selectedProducts.map((product) {
            final String productName = product['name'] as String;
            final String imagePath = product['image'] as String;
            
            final Color bgColor = _productColors[imagePath] ?? _getProductColor(productName);
            final String colorName = _productColorNames[imagePath] ?? _getProductColorName(productName);
            final Color textColor = _productTextColors[imagePath] ?? 
                (bgColor.computeLuminance() > 0.5 ? Colors.black : Colors.white);
            
            if (!_productColors.containsKey(imagePath)) {
              _cacheProductColor(product);
            }
            
            return SizedBox(
              width: productWidth,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.2),
                        width: 0.5,
                      ),
                    ),
                    child: Text(
                      colorName,
                      style: TextStyle(
                        fontSize: 12,
                        color: textColor,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSelectedPhoneCard(Map<String, dynamic> product) {
    final String productName = product['name'] as String;
    final String imagePath = product['image'] as String;
    
    final Color displayColor = _productColors[imagePath] ?? _getProductColor(productName);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset(
                  product['image'],
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.phone_android_rounded, size: 30, color: Colors.grey),
                ),
              ),
              Positioned(
                top: -4,
                right: -4,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedProducts.remove(product);
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF3B30),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: displayColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              product['brand'] ?? 'Unknown',
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                color: displayColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            product['name'],
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w500,
              color: Color(0xFF64748B),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _getSpec(String productName, String specKey) {
    if (_phoneSpecs.containsKey(productName)) {
      return _phoneSpecs[productName]?[specKey] ?? 'N/A';
    }
    for (final entry in _phoneSpecs.entries) {
      if (productName.contains(entry.key) || entry.key.contains(productName)) {
        return entry.value[specKey] ?? 'N/A';
      }
    }
    final brand = _getBrandFromName(productName);
    if (brand == 'Apple') {
      return _getDefaultAppleSpec(specKey);
    } else if (brand == 'Samsung') {
      return _getDefaultSamsungSpec(specKey);
    } else if (brand == 'Xiaomi') {
      return _getDefaultXiaomiSpec(specKey);
    } else if (brand == 'Oppo') {
      return _getDefaultOppoSpec(specKey);
    } else if (brand == 'OnePlus') {
      return _getDefaultOnePlusSpec(specKey);
    } else if (brand == 'Vivo') {
      return _getDefaultVivoSpec(specKey);
    }
    return 'N/A';
  }

  String _getBrandFromName(String name) {
    if (name.contains('iPhone') || name.contains('iPad') || name.contains('Apple Watch') || name.contains('AirPods') || name.contains('Apple')) {
      return 'Apple';
    } else if (name.contains('Galaxy') || name.contains('Samsung')) {
      return 'Samsung';
    } else if (name.contains('Xiaomi')) {
      return 'Xiaomi';
    } else if (name.contains('Oppo') || name.contains('Find') || name.contains('Reno')) {
      return 'Oppo';
    } else if (name.contains('OnePlus')) {
      return 'OnePlus';
    } else if (name.contains('Vivo')) {
      return 'Vivo';
    }
    return 'Unknown';
  }

  String _getDefaultAppleSpec(String key) {
    const specs = {
      'processor': 'A18 Bionic',
      'ram': '8GB',
      'storage': '128GB - 512GB',
      'battery': '3,500+ mAh',
      'camera': '48MP Main, 12MP UW',
      'display': 'Super Retina XDR',
      'os': 'iOS 17+',
    };
    return specs[key] ?? 'N/A';
  }

  String _getDefaultSamsungSpec(String key) {
    const specs = {
      'processor': 'Snapdragon 8 Gen 3',
      'ram': '12GB',
      'storage': '128GB - 512GB',
      'battery': '4,500+ mAh',
      'camera': '50MP+ Main',
      'display': 'Dynamic AMOLED 2X',
      'os': 'Android 14+',
    };
    return specs[key] ?? 'N/A';
  }

  String _getDefaultXiaomiSpec(String key) {
    const specs = {
      'processor': 'Snapdragon 8 Gen 3',
      'ram': '12GB',
      'storage': '128GB - 512GB',
      'battery': '4,800+ mAh',
      'camera': '50MP Main',
      'display': 'AMOLED 120Hz',
      'os': 'Android 14+',
    };
    return specs[key] ?? 'N/A';
  }

  String _getDefaultOppoSpec(String key) {
    const specs = {
      'processor': 'MediaTek Dimensity 9300',
      'ram': '12GB',
      'storage': '128GB - 512GB',
      'battery': '4,500+ mAh',
      'camera': '50MP Main',
      'display': 'AMOLED 120Hz',
      'os': 'Android 14+',
    };
    return specs[key] ?? 'N/A';
  }

  String _getDefaultOnePlusSpec(String key) {
    const specs = {
      'processor': 'Snapdragon 8 Gen 3',
      'ram': '12GB',
      'storage': '128GB - 512GB',
      'battery': '5,000+ mAh',
      'camera': '50MP Main',
      'display': 'AMOLED 120Hz',
      'os': 'Android 14+',
    };
    return specs[key] ?? 'N/A';
  }

  String _getDefaultVivoSpec(String key) {
    const specs = {
      'processor': 'MediaTek Dimensity 9300',
      'ram': '12GB',
      'storage': '128GB - 512GB',
      'battery': '4,800+ mAh',
      'camera': '50MP Main',
      'display': 'AMOLED 120Hz',
      'os': 'Android 14+',
    };
    return specs[key] ?? 'N/A';
  }

  void _showPhoneSelectionDialog() {
    final allProducts = ProductData.allProducts;
    final availableProducts = allProducts
        .where((p) => !_selectedProducts.contains(p))
        .toList();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return CompareSelectionDialog(
          selectedProducts: _selectedProducts,
          availableProducts: availableProducts,
          maxCompare: _maxCompare,
          onProductTapped: _toggleProductSelection,
        );
      },
    );
  }
}

// Separate StatefulWidget for the selection dialog with search
class CompareSelectionDialog extends StatefulWidget {
  final List<Map<String, dynamic>> selectedProducts;
  final List<Map<String, dynamic>> availableProducts;
  final int maxCompare;
  final Function(Map<String, dynamic>) onProductTapped;

  const CompareSelectionDialog({
    super.key,
    required this.selectedProducts,
    required this.availableProducts,
    required this.maxCompare,
    required this.onProductTapped,
  });

  @override
  State<CompareSelectionDialog> createState() => _CompareSelectionDialogState();
}

class _CompareSelectionDialogState extends State<CompareSelectionDialog> {
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = _searchQuery.isEmpty
        ? widget.availableProducts
        : widget.availableProducts.where((product) {
            final name = product['name'].toString().toLowerCase();
            final brand = product['brand'].toString().toLowerCase();
            final query = _searchQuery.toLowerCase();
            return name.contains(query) || brand.contains(query);
          }).toList();

    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Select Phone to Compare',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${widget.selectedProducts.length}/${widget.maxCompare} selected • ${filteredProducts.length} available',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search phones...',
                        prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF94A3B8), size: 20),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear, size: 18),
                                onPressed: () {
                                  setState(() {
                                    _searchQuery = '';
                                    _searchController.clear();
                                  });
                                },
                              )
                            : null,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: filteredProducts.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off_rounded,
                            size: 48,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'No phones found',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Try a different search term',
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        final isSelected = widget.selectedProducts.contains(product);
                        
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: isSelected ? const Color(0xFF007BF6) : Colors.grey.shade200,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: ListTile(
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8FAFC),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.asset(
                                product['image'],
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.phone_android_rounded, size: 20, color: Colors.grey),
                              ),
                            ),
                            title: Text(
                              product['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            subtitle: Text(
                              '${product['brand']} • \$${product['price']}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            trailing: isSelected
                                ? const Icon(Icons.check_circle_rounded, color: Color(0xFF007BF6))
                                : null,
                            onTap: () {
                              widget.onProductTapped(product);
                              setState(() {});
                            },
                          ),
                        );
                      },
                    ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey.shade200)),
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF007BF6),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Done (${widget.selectedProducts.length} selected)',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}