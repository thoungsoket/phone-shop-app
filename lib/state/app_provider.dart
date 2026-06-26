import 'package:flutter/foundation.dart';

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

  List<CartItem> get items => List.unmodifiable(_items);

  List<Map<String, dynamic>> get favorites => List.unmodifiable(
    _favorites.map((product) => Map<String, dynamic>.from(product)),
  );

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
    normalized['brand'] =
        product['brand']?.toString() ?? product['tag']?.toString() ?? 'Brand';
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
