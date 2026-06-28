import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../features/auth/auth_service.dart';

class CartItem {
  final String id;
  final String name;
  final String image;
  final String detail;
  final double price;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.image,
    required this.detail,
    required this.price,
    this.quantity = 1,
  });

  double get lineTotal => price * quantity;
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];
  final List<Map<String, dynamic>> _favorites = [];

  final List<Map<String, dynamic>> _orderHistory = [];

  List<Map<String, dynamic>> get orderHistory => List.unmodifiable(_orderHistory);

  List<CartItem> get items => List.unmodifiable(_items);

  List<Map<String, dynamic>> get favorites => List.unmodifiable(
    _favorites.map((product) => Map<String, dynamic>.from(product)),
  );

  String get _userKey =>
    AuthService.instance.currentUser?.email ?? 'guest';

  String _key(String name) => '${name}_$_userKey';

  Future<void> loadUserData() async {
    // TODO
  }

  Future<void> saveUserData() async {
    // TODO
  }

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => _items.fold(0, (sum, item) => sum + item.lineTotal);

  double get discount => _items.length > 1 ? 50 : 0;

  double get tax => subtotal * 0.08;

  double get cartTotal => subtotal - discount;

  double get checkoutTotal => subtotal + tax - discount;

  int get favoriteCount => _favorites.length;

  bool isFavorite(Map<String, dynamic> product) {
    final id = _favoriteId(product);
    return _favorites.any((favorite) => _favoriteId(favorite) == id);
  }

  bool toggleFavorite(
    Map<String, dynamic> product, {
    String? color,
    String? storage,
    String? image,
    double? price,
  }) {
    if (isFavorite(product)) {
      removeFavorite(product);
      return false;
    }

    addFavorite(
      product,
      color: color,
      storage: storage,
      image: image,
      price: price,
    );
    return true;
  }

  void addFavorite(
    Map<String, dynamic> product, {
    String? color,
    String? storage,
    String? image,
    double? price,
  }) {
    if (isFavorite(product)) return;

    _favorites.add(
      _normalizeProduct(
        product,
        color: color,
        storage: storage,
        image: image,
        price: price,
      ),
    );
    notifyListeners();
  }

  void removeFavorite(Map<String, dynamic> product) {
    final id = _favoriteId(product);
    _favorites.removeWhere((favorite) => _favoriteId(favorite) == id);
    notifyListeners();
  }

  bool containsProduct(
    Map<String, dynamic> product, {
    String? color,
    String? storage,
    double? price,
  }) {
    return _items.any(
      (item) =>
          item.id ==
          _buildId(product, color: color, storage: storage, price: price),
    );
  }

  void addProduct(
    Map<String, dynamic> product, {
    String? color,
    String? storage,
    String? image,
    double? price,
  }) {
    final name = product['name']?.toString() ?? 'Product';
    final itemPrice = price ?? _readPrice(product['price']);
    final itemImage =
        image ??
        product['image']?.toString() ??
        product['img']?.toString() ??
        'assets/images/placeholder.png';
    final itemDetail = [
      if (storage != null && storage.isNotEmpty) storage,
      if (color != null && color.isNotEmpty) color,
    ].join(' - ');
    final id = _buildId(
      product,
      color: color,
      storage: storage,
      price: itemPrice,
    );

    final existingIndex = _items.indexWhere((item) => item.id == id);
    if (existingIndex == -1) {
      _items.add(
        CartItem(
          id: id,
          name: name,
          image: itemImage,
          detail: itemDetail.isEmpty
              ? (product['brand']?.toString() ??
                    product['tag']?.toString() ??
                    '')
              : itemDetail,
          price: itemPrice,
        ),
      );
    } else {
      _items[existingIndex].quantity++;
    }

    notifyListeners();
  }

  void increment(String id) {
    final item = _findById(id);
    if (item == null) return;
    item.quantity++;
    notifyListeners();
  }

  void decrement(String id) {
    final item = _findById(id);
    if (item == null) return;
    if (item.quantity > 1) {
      item.quantity--;
      notifyListeners();
    }
  }

  void remove(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void checkoutCart() {
    if (_items.isEmpty) return;

    for (final item in _items) {
      _orderHistory.insert(0, {
        'id': item.id,
        'name': item.name,
        'image': item.image,
        'detail': item.detail,
        'price': item.price,
        'quantity': item.quantity,
        'orderedAt': DateTime.now().toIso8601String(),
      });
    }

    _items.clear();
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  CartItem? _findById(String id) {
    for (final item in _items) {
      if (item.id == id) return item;
    }
    return null;
  }

  double _readPrice(dynamic price) {
    if (price is num) return price.toDouble();
    if (price is String) {
      return double.tryParse(price.replaceAll('\$', '')) ?? 0;
    }
    return 0;
  }

  String _buildId(
    Map<String, dynamic> product, {
    String? color,
    String? storage,
    double? price,
  }) {
    final name = product['name']?.toString() ?? 'Product';
    final productId = product['id']?.toString() ?? name;
    final itemPrice = price ?? _readPrice(product['price']);
    return '$productId|${storage ?? ''}|${color ?? ''}|$itemPrice';
  }

  // ✅ IMPROVED: _normalizeProduct with better brand detection
  Map<String, dynamic> _normalizeProduct(
    Map<String, dynamic> product, {
    String? color,
    String? storage,
    String? image,
    double? price,
  }) {
    final normalized = Map<String, dynamic>.from(product);
    normalized['id'] =
        product['id'] ?? product['name']?.toString() ?? 'Product';
    normalized['name'] = product['name']?.toString() ?? 'Product';
    
    // ✅ IMPROVED: Better brand detection
    String brandValue = product['brand']?.toString() ?? '';
    if (brandValue.isEmpty) {
      brandValue = product['tag']?.toString() ?? '';
    }
    if (brandValue.isEmpty) {
      // Fallback: detect from product name
      final name = product['name']?.toString() ?? '';
      if (name.contains('iPhone') || name.contains('iPad') || name.contains('Apple Watch')) {
        brandValue = 'Apple';
      } else if (name.contains('Galaxy') || name.contains('Samsung')) {
        brandValue = 'Samsung';
      } else if (name.contains('Xiaomi')) {
        brandValue = 'Xiaomi';
      } else if (name.contains('OnePlus')) {
        brandValue = 'OnePlus';
      } else if (name.contains('Vivo')) {
        brandValue = 'Vivo';
      } else if (name.contains('Oppo')) {
        brandValue = 'Oppo';
      } else {
        brandValue = 'Brand';
      }
    }
    normalized['brand'] = brandValue;
    
    normalized['price'] = price ?? _readPrice(product['price']);
    normalized['image'] =
        image ??
        product['image']?.toString() ??
        product['img']?.toString() ??
        'assets/images/placeholder.png';
    normalized['storage'] =
        storage ?? product['storage']?.toString() ?? '256GB';
    normalized['color'] = color ?? product['color']?.toString() ?? 'Default';
    normalized['rating'] = _readRating(product['rating']);
    normalized['category'] = product['category']?.toString() ?? 'Smartphones';
    
    return normalized;
  }

  String _favoriteId(Map<String, dynamic> product) {
    return product['id']?.toString() ??
        product['name']?.toString() ??
        'Product';
  }

  double _readRating(dynamic rating) {
    if (rating is num) return rating.toDouble();
    if (rating is String) return double.tryParse(rating) ?? 4.5;
    return 4.5;
  }
}