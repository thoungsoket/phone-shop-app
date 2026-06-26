import 'package:flutter/material.dart';
import '../checkout/checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int phoneQty = 1;
  int budsQty = 1;

  final double phonePrice = 1099;
  final double budsPrice = 199;
  final double discount = 50;

  double get subtotal => (phonePrice * phoneQty) + (budsPrice * budsQty);
  double get total => subtotal - discount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
  backgroundColor: Colors.white,
  elevation: 0,
  centerTitle: true,

  leading: IconButton(
    icon: const Icon(
      Icons.arrow_back,
      color: Color(0xFF0066E6),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  ),

  title: const Text(
    'PhoneHub',
    style: TextStyle(
      color: Color(0xFF0066E6),
      fontWeight: FontWeight.bold,
    ),
  ),
  actions: [
    Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Stack(
        children: [
          const Icon(
            Icons.shopping_cart_outlined,
            color: Color(0xFF0066E6),
            size: 28,
          ),
          Positioned(
            right: 0,
            child: Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                color: Colors.cyan,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  '4',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  ],
),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const Text('Your Cart', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800)),
                const SizedBox(height: 20),
                CartItemCard(
                  image: 'assets/images/iphone_15_pro.png',
                  name: 'Nova Pro Max',
                  detail: '256GB • Phantom Black',
                  price: phonePrice,
                  quantity: phoneQty,
                  onAdd: () => setState(() => phoneQty++),
                  onRemove: () {
                    if (phoneQty > 1) setState(() => phoneQty--);
                  },
                ),
                const SizedBox(height: 14),
                CartItemCard(
                  image: 'assets/images/aero_fold_4.png',
                  name: 'AeroBuds Pro',
                  detail: 'Noise Cancelling',
                  price: budsPrice,
                  quantity: budsQty,
                  onAdd: () => setState(() => budsQty++),
                  onRemove: () {
                    if (budsQty > 1) setState(() => budsQty--);
                  },
                ),
                const SizedBox(height: 16),
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
                            Text("Don't forget a charger!",
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
                            SizedBox(height: 4),
                            Text('Add a 30W Fast Charger for \$29',
                                style: TextStyle(color: Colors.black54)),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE5E7EB),
                          foregroundColor: Colors.black87,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                        ),
                        child: const Text('Add'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
            ),
            child: Column(
              children: [
                SummaryRow(label: 'Subtotal', value: '\$${subtotal.toStringAsFixed(2)}'),
                const SizedBox(height: 8),
                SummaryRow(
                  label: 'Bundle Discount',
                  value: '-\$${discount.toStringAsFixed(2)}',
                  valueColor: const Color(0xFF0066E6),
                ),
                const Divider(height: 24),
                SummaryRow(label: 'Total', value: '\$${total.toStringAsFixed(2)}', isTotal: true),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CheckoutScreen(
                            phoneQty: phoneQty,
                            budsQty: budsQty,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF009DFD),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 17),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text('Proceed to Checkout  →',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CartItemCard extends StatelessWidget {
  final String image;
  final String name;
  final String detail;
  final double price;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const CartItemCard({
    super.key,
    required this.image,
    required this.name,
    required this.detail,
    required this.price,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 18, offset: const Offset(0, 8)),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(image, width: 88, height: 88, fit: BoxFit.cover),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(name,
                          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
                    ),
                    const Icon(Icons.delete_outline, size: 19, color: Colors.black45),
                  ],
                ),
                const SizedBox(height: 4),
                Text(detail, style: const TextStyle(color: Colors.black54)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text('\$${price.toStringAsFixed(2)}',
                        style: const TextStyle(color: Color(0xFF0066E6), fontSize: 18, fontWeight: FontWeight.w800)),
                    const Spacer(),
                    Container(
                      height: 34,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5E7EB),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          IconButton(onPressed: onRemove, icon: const Icon(Icons.remove, size: 16), padding: EdgeInsets.zero),
                          Text('$quantity', style: const TextStyle(fontWeight: FontWeight.bold)),
                          IconButton(onPressed: onAdd, icon: const Icon(Icons.add, size: 16), padding: EdgeInsets.zero),
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
        Text(label,
            style: TextStyle(
              fontSize: isTotal ? 20 : 14,
              fontWeight: isTotal ? FontWeight.w800 : FontWeight.normal,
            )),
        const Spacer(),
        Text(value,
            style: TextStyle(
              fontSize: isTotal ? 24 : 14,
              fontWeight: isTotal ? FontWeight.w900 : FontWeight.w500,
              color: valueColor ?? const Color(0xFF0066E6),
            )),
      ],
    );
  }
}