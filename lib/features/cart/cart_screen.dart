import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../checkout/checkout_screen.dart';
import '../home/home_screen.dart';
import '../../state/app_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  void _navigateToCheckout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CheckoutScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, _) {
        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: _buildAppBar(cart),
          body: _buildBody(cart),
        );
      },
    );
  }

  // ==================== APP BAR ====================
  PreferredSizeWidget _buildAppBar(CartProvider cart) {
    return AppBar(
      backgroundColor: Colors.white.withOpacity(0.95),
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Color(0xFF0F172A),
            size: 24,
          ),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              _navigateToHome();
            }
          },
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'PhoneHub',
            style: TextStyle(
              color: Color(0xFF007BF6),
              fontWeight: FontWeight.w900,
              fontSize: 20,
              letterSpacing: -0.8,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 1),
          Text(
            '📍 Phnom Penh Branch',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
              fontSize: 11,
              height: 1.0,
            ),
          ),
        ],
      ),
      actions: [
        // Search icon REMOVED
        Stack(
          children: [
            IconButton(
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: Color(0xFF0F172A),
                size: 24,
              ),
              onPressed: () {}, // Already on cart
            ),
            Positioned(
              right: 6,
              top: 6,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: Color(0xFFFF3B30),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${cart.itemCount}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 12),
      ],
    );
  }

  // ==================== BODY ====================
  Widget _buildBody(CartProvider cart) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Text(
                'Your Cart',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 20),
              ...cart.items.expand(
                (item) => [
                  CartItemCard(
                    image: item.image,
                    name: item.name,
                    detail: item.detail,
                    price: item.price,
                    quantity: item.quantity,
                    onAdd: () => cart.increment(item.id),
                    onRemove: () => cart.decrement(item.id),
                    onDelete: () {
                      cart.remove(item.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Item removed from cart'),
                          duration: Duration(seconds: 1),
                          backgroundColor: Colors.grey,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 14),
                ],
              ),
              const SizedBox(height: 2),
              // Don't forget charger card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 28,
                      backgroundColor: Color(0xFFDDF7FF),
                      child: Icon(Icons.headphones, color: Color(0xFF00AEEF)),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Don't forget a charger!",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Add a 30W Fast Charger for \$29',
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<CartProvider>().addProduct({
                          'id': 'charger-30w',
                          'name': '30W Fast Charger',
                          'price': 29,
                          'brand': 'PhoneHub',
                          'image': 'assets/images/placeholder.png',
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Charger added to cart! 🔌'),
                            backgroundColor: Color(0xFF10B981),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE5E7EB),
                        foregroundColor: Colors.black87,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Bottom summary
        Container(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
          ),
          child: Column(
            children: [
              SummaryRow(
                label: 'Subtotal',
                value: '\$${cart.subtotal.toStringAsFixed(2)}',
              ),
              const SizedBox(height: 8),
              SummaryRow(
                label: 'Bundle Discount',
                value: '-\$${cart.discount.toStringAsFixed(2)}',
                valueColor: const Color(0xFF10B981),
              ),
              const Divider(height: 24, color: Color(0xFFE5E7EB)),
              SummaryRow(
                label: 'Total',
                value: '\$${cart.cartTotal.toStringAsFixed(2)}',
                isTotal: true,
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _navigateToCheckout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF007BF6),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Proceed to Checkout  →',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ==================== CART ITEM CARD ====================
class CartItemCard extends StatelessWidget {
  final String image;
  final String name;
  final String detail;
  final double price;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final VoidCallback onDelete;

  const CartItemCard({
    super.key,
    required this.image,
    required this.name,
    required this.detail,
    required this.price,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              image,
              width: 88,
              height: 88,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 88,
                  height: 88,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.image, color: Colors.grey),
                );
              },
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: onDelete,
                      child: const Icon(
                        Icons.delete_outline,
                        size: 19,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(detail, style: const TextStyle(color: Colors.black54)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      '\$${price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Color(0xFF007BF6),
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 34,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5E7EB),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: onRemove,
                            icon: const Icon(Icons.remove, size: 16),
                            padding: EdgeInsets.zero,
                            color: Colors.black87,
                          ),
                          Text(
                            '$quantity',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          IconButton(
                            onPressed: onAdd,
                            icon: const Icon(Icons.add, size: 16),
                            padding: EdgeInsets.zero,
                            color: Colors.black87,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== SUMMARY ROW ====================
class SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool isTotal;

  const SummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 20 : 14,
            fontWeight: isTotal ? FontWeight.w800 : FontWeight.normal,
            color: isTotal ? Color(0xFF0F172A) : Colors.grey.shade600,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 24 : 14,
            fontWeight: isTotal ? FontWeight.w900 : FontWeight.w500,
            color: valueColor ?? const Color(0xFF007BF6),
          ),
        ),
      ],
    );
  }
}
