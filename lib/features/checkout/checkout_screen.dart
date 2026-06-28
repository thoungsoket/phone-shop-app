import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'order_success_screen.dart';
import '../../state/app_provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedDelivery = 'Home Delivery';
  final promoController = TextEditingController();

  void applyPromo() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Promo code applied')));
  }

  Future<void> placeOrder() async {
    final cart = context.read<CartProvider>();

    //cart.addOrderFromCart();   // Save purchased items to order history
    await cart.saveUserData(); // Save this user's orders
    cart.clear();              // Empty the cart
  }

  @override
  void dispose() {
    promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0066E6)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'PhoneHub',
          style: TextStyle(
            color: Color(0xFF0066E6),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Checkout',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 24),

          const SectionTitle(
            icon: Icons.local_shipping_outlined,
            title: 'Delivery Method',
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: DeliveryOptionCard(
                  title: 'Home Delivery',
                  subtitle: '2-3 business days',
                  icon: Icons.home_outlined,
                  isSelected: selectedDelivery == 'Home Delivery',
                  onTap: () =>
                      setState(() => selectedDelivery = 'Home Delivery'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DeliveryOptionCard(
                  title: 'Store Pickup',
                  subtitle: 'Available today',
                  icon: Icons.storefront_outlined,
                  isSelected: selectedDelivery == 'Store Pickup',
                  onTap: () =>
                      setState(() => selectedDelivery = 'Store Pickup'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),
          const SectionTitle(
            icon: Icons.location_on_outlined,
            title: 'Shipping Address',
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFD8E3F0)),
            ),
            child: const Row(
              children: [
                Expanded(
                  child: Text(
                    'Alex Tech\n123 Innovation Drive, Suite 400\nSan Francisco, CA 94105\n+1 (555) 019-2837',
                    style: TextStyle(height: 1.5),
                  ),
                ),
                Text(
                  'EDIT',
                  style: TextStyle(
                    color: Color(0xFF0066E6),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: () {},
            child: const Text('+ Add New Address'),
          ),

          const SizedBox(height: 28),
          const SectionTitle(
            icon: Icons.receipt_long_outlined,
            title: 'Order Summary',
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                ...cart.items.expand(
                  (item) => [
                    CheckoutItem(
                      image: item.image,
                      name: item.name,
                      detail: item.detail,
                      qty: item.quantity,
                      price: item.lineTotal,
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: promoController,
                        decoration: const InputDecoration(
                          hintText: 'Promo Code',
                          prefixIcon: Icon(Icons.local_offer_outlined),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: applyPromo,
                      child: const Text('Apply'),
                    ),
                  ],
                ),
                const Divider(height: 28),
                SummaryRow(
                  label: 'Subtotal',
                  value: '\$${cart.subtotal.toStringAsFixed(2)}',
                ),
                SummaryRow(label: 'Shipping', value: 'Free'),
                SummaryRow(
                  label: 'Tax',
                  value: '\$${cart.tax.toStringAsFixed(2)}',
                ),
                SummaryRow(
                  label: 'Bundle Discount',
                  value: '-\$${cart.discount.toStringAsFixed(2)}',
                  valueColor: Colors.green,
                ),
                const Divider(height: 28),
                SummaryRow(
                  label: 'Total',
                  value: '\$${cart.checkoutTotal.toStringAsFixed(2)}',
                  isTotal: true,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          Row(
            children: [
              Text(
                '\$${cart.checkoutTotal.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: placeOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00AEEF),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 16,
                  ),
                ),
                child: const Text('Place Order  →'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CheckoutItem extends StatelessWidget {
  final String image;
  final String name;
  final String detail;
  final int qty;
  final double price;

  const CheckoutItem({
    super.key,
    required this.image,
    required this.name,
    required this.detail,
    required this.qty,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(image, width: 62, height: 62, fit: BoxFit.cover),
        const SizedBox(width: 12),
        Expanded(child: Text('$name\n$detail\nQty: $qty')),
        Text(
          '\$${price.toStringAsFixed(2)}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class DeliveryOptionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const DeliveryOptionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF0066E6)
                : const Color(0xFFD8E3F0),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFF0066E6)),
            const Spacer(),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.black54, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;

  const SectionTitle({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF0066E6)),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
        ),
      ],
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(label, style: TextStyle(fontSize: isTotal ? 18 : 14)),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              color: valueColor ?? Colors.black87,
              fontSize: isTotal ? 22 : 14,
              fontWeight: isTotal ? FontWeight.w900 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
