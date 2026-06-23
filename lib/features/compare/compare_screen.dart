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
      'color': 'Natural Titanium',
    },
    'iPhone 17 Pro': {
      'processor': 'A19 Pro',
      'ram': '8GB',
      'storage': '128GB - 1TB',
      'battery': '3,655 mAh',
      'camera': '48MP Main, 12MP UW, 12MP Tele',
      'display': '6.3" Super Retina XDR 120Hz',
      'os': 'iOS 18',
      'color': 'Black Titanium',
    },
    'iPhone 17': {
      'processor': 'A19',
      'ram': '6GB',
      'storage': '128GB - 512GB',
      'battery': '3,274 mAh',
      'camera': '48MP Main, 12MP UW',
      'display': '6.1" Super Retina XDR',
      'os': 'iOS 18',
      'color': 'Midnight',
    },
    'iPhone 16 Pro Max': {
      'processor': 'A18 Pro',
      'ram': '8GB',
      'storage': '256GB - 1TB',
      'battery': '4,685 mAh',
      'camera': '48MP Main, 12MP UW, 12MP Tele, LiDAR',
      'display': '6.9" Super Retina XDR 120Hz',
      'os': 'iOS 17',
      'color': 'Natural Titanium',
    },
    'iPhone 16 Pro': {
      'processor': 'A18 Pro',
      'ram': '8GB',
      'storage': '128GB - 1TB',
      'battery': '3,655 mAh',
      'camera': '48MP Main, 12MP UW, 12MP Tele',
      'display': '6.3" Super Retina XDR 120Hz',
      'os': 'iOS 17',
      'color': 'Black Titanium',
    },
    'Galaxy S26 Ultra': {
      'processor': 'Snapdragon 8 Gen 5',
      'ram': '16GB',
      'storage': '256GB - 1TB',
      'battery': '5,500 mAh',
      'camera': '200MP Main, 12MP UW, 50MP/10MP Tele',
      'display': '6.8" Dynamic AMOLED 2X 120Hz',
      'os': 'Android 15 (One UI 7)',
      'color': 'Titanium Black',
    },
    'Galaxy S26 Plus': {
      'processor': 'Snapdragon 8 Gen 5',
      'ram': '12GB',
      'storage': '256GB - 512GB',
      'battery': '4,900 mAh',
      'camera': '50MP Main, 12MP UW, 10MP Tele',
      'display': '6.7" Dynamic AMOLED 2X 120Hz',
      'os': 'Android 15 (One UI 7)',
      'color': 'Mint',
    },
    'Galaxy S26': {
      'processor': 'Snapdragon 8 Gen 5',
      'ram': '8GB',
      'storage': '128GB - 512GB',
      'battery': '4,000 mAh',
      'camera': '50MP Main, 12MP UW',
      'display': '6.2" Dynamic AMOLED 2X 120Hz',
      'os': 'Android 15 (One UI 7)',
      'color': 'Lavender',
    },
    'Xiaomi 15 Pro': {
      'processor': 'Snapdragon 8 Gen 4',
      'ram': '16GB',
      'storage': '256GB - 1TB',
      'battery': '5,200 mAh',
      'camera': '50MP Main, 50MP UW, 50MP Tele',
      'display': '6.73" AMOLED 120Hz',
      'os': 'Android 15 (HyperOS 2)',
      'color': 'Silver',
    },
    'Xiaomi 15': {
      'processor': 'Snapdragon 8 Gen 4',
      'ram': '12GB',
      'storage': '256GB - 512GB',
      'battery': '4,800 mAh',
      'camera': '50MP Main, 50MP UW, 50MP Tele',
      'display': '6.36" AMOLED 120Hz',
      'os': 'Android 15 (HyperOS 2)',
      'color': 'Black',
    },
    'OnePlus 12': {
      'processor': 'Snapdragon 8 Gen 3',
      'ram': '16GB',
      'storage': '256GB - 512GB',
      'battery': '5,400 mAh',
      'camera': '50MP Main, 48MP UW, 64MP Tele',
      'display': '6.82" AMOLED 120Hz',
      'os': 'Android 14 (OxygenOS 14)',
      'color': 'Flowy Emerald',
    },
    'Vivo X100 Ultra': {
      'processor': 'MediaTek Dimensity 9300+',
      'ram': '16GB',
      'storage': '256GB - 1TB',
      'battery': '5,500 mAh',
      'camera': '50MP Main, 50MP UW, 200MP Tele',
      'display': '6.78" AMOLED 120Hz',
      'os': 'Android 14 (Funtouch OS 14)',
      'color': 'Titanium',
    },
    'Oppo Find X8 Ultra': {
      'processor': 'MediaTek Dimensity 9400',
      'ram': '16GB',
      'storage': '256GB - 1TB',
      'battery': '5,100 mAh',
      'camera': '50MP Main, 50MP UW, 50MP Tele',
      'display': '6.82" AMOLED 120Hz',
      'os': 'Android 15 (ColorOS 15)',
      'color': 'Black',
    },
    'Oppo Find X8 Pro': {
      'processor': 'MediaTek Dimensity 9400',
      'ram': '12GB',
      'storage': '256GB - 512GB',
      'battery': '4,800 mAh',
      'camera': '50MP Main, 50MP UW, 50MP Tele',
      'display': '6.78" AMOLED 120Hz',
      'os': 'Android 15 (ColorOS 15)',
      'color': 'White',
    },
  };

  // Method to add/remove selected products
  void _toggleProductSelection(Map<String, dynamic> product) {
    setState(() {
      if (_selectedProducts.contains(product)) {
        _selectedProducts.remove(product);
      } else if (_selectedProducts.length < _maxCompare) {
        _selectedProducts.add(product);
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
        const SizedBox(height: 4),
        // Spec comparison
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Rating
                _buildSpecRow('Rating', _selectedProducts.map((p) => 
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star_rounded, color: Colors.amber, size: 14),
                      Text(
                        ' ${p['rating']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  )
                ).toList()),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 12),
                
                // Price
                _buildSpecRow('Price', _selectedProducts.map((p) =>
                  Text(
                    '\$${p['price']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF007BF6),
                    ),
                    textAlign: TextAlign.center,
                  )
                ).toList()),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 12),
                
                // Processor
                _buildSpecRow('Processor', _selectedProducts.map((p) =>
                  Text(
                    _getSpec(p['name'], 'processor'),
                    style: const TextStyle(fontSize: 13),
                    textAlign: TextAlign.center,
                  )
                ).toList()),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 12),
                
                // RAM
                _buildSpecRow('RAM', _selectedProducts.map((p) =>
                  Text(
                    _getSpec(p['name'], 'ram'),
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  )
                ).toList()),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 12),
                
                // Storage
                _buildSpecRow('Storage', _selectedProducts.map((p) =>
                  Text(
                    _getSpec(p['name'], 'storage'),
                    style: const TextStyle(fontSize: 13),
                    textAlign: TextAlign.center,
                  )
                ).toList()),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 12),
                
                // Battery
                _buildSpecRow('Battery', _selectedProducts.map((p) =>
                  Text(
                    _getSpec(p['name'], 'battery'),
                    style: const TextStyle(fontSize: 13),
                    textAlign: TextAlign.center,
                  )
                ).toList()),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 12),
                
                // Camera
                _buildSpecRow('Camera', _selectedProducts.map((p) =>
                  Text(
                    _getSpec(p['name'], 'camera'),
                    style: const TextStyle(fontSize: 11),
                    textAlign: TextAlign.center,
                  )
                ).toList()),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 12),
                
                // Display
                _buildSpecRow('Display', _selectedProducts.map((p) =>
                  Text(
                    _getSpec(p['name'], 'display'),
                    style: const TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  )
                ).toList()),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 12),
                
                // OS
                _buildSpecRow('OS', _selectedProducts.map((p) =>
                  Text(
                    _getSpec(p['name'], 'os'),
                    style: const TextStyle(fontSize: 11),
                    textAlign: TextAlign.center,
                  )
                ).toList()),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 12),
                
                // Color - FIXED with center alignment
                _buildSpecRowWithColor('Color', _selectedProducts.map((p) =>
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: _getColor(_getSpec(p['name'], 'color')),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        _getSpec(p['name'], 'color'),
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ).toList()),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedPhoneCard(Map<String, dynamic> product) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
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
          Text(
            product['brand'],
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Color(0xFF007BF6),
            ),
          ),
          Text(
            product['name'],
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // Regular spec row - with start alignment for label and centered values
  Widget _buildSpecRow(String label, List<Widget> values) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        Expanded(
          child: Row(
            children: [
              ...values.map((value) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: value,
                ),
              )),
            ],
          ),
        ),
      ],
    );
  }

  // Special spec row for Color - with center alignment
  Widget _buildSpecRowWithColor(String label, List<Widget> values) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ...values.map((value) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: value,
                ),
              )),
            ],
          ),
        ),
      ],
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
      'color': 'Various',
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
      'color': 'Various',
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
      'color': 'Various',
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
      'color': 'Various',
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
      'color': 'Various',
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
      'color': 'Various',
    };
    return specs[key] ?? 'N/A';
  }

  Color _getColor(String colorName) {
    final colors = {
      'Black': Colors.black,
      'White': Colors.white,
      'Silver': Colors.grey.shade400,
      'Gray': Colors.grey.shade600,
      'Gold': const Color(0xFFD4AF37),
      'Rose Gold': const Color(0xFFE8B4B8),
      'Midnight': const Color(0xFF1A1A2E),
      'Starlight': const Color(0xFFF5F5DC),
      'Blue': Colors.blue,
      'Red': Colors.red,
      'Green': Colors.green,
      'Purple': Colors.purple,
      'Pink': Colors.pink,
      'Titanium': const Color(0xFF8C8C8C),
      'Natural Titanium': const Color(0xFF8C8C8C),
      'Black Titanium': const Color(0xFF2C2C2C),
      'Titanium Black': const Color(0xFF1A1A1A),
      'Mint': const Color(0xFF98FF98),
      'Lavender': const Color(0xFFB6A1D9),
      'Flowy Emerald': const Color(0xFF50C878),
      'Various': const Color(0xFF94A3B8),
    };
    return colors[colorName] ?? Colors.grey.shade400;
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