import 'package:flutter/material.dart';
import 'order_success_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final int phoneQty;
  final int budsQty;

  const CheckoutScreen({
    super.key,
    this.phoneQty = 1,
    this.budsQty = 1,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedDelivery = 'Home Delivery';
  final promoController = TextEditingController();

  final double phonePrice = 1099;
  final double budsPrice = 199;
  final double discount = 50;
  final double tax = 101.92;

  double get subtotal => (phonePrice * widget.phoneQty) + (budsPrice * widget.budsQty);
  double get total => subtotal + tax - discount;

  void applyPromo() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Promo code applied')),
    );
  }

  void placeOrder() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const OrderSuccessScreen()),
    );
  }

  @override
  void dispose() {
    promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        title: const Text('PhoneHub',
            style: TextStyle(color: Color(0xFF0066E6), fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Checkout', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800)),
          const SizedBox(height: 24),

          const SectionTitle(icon: Icons.local_shipping_outlined, title: 'Delivery Method'),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: DeliveryOptionCard(
                  title: 'Home Delivery',
                  subtitle: '2-3 business days',
                  icon: Icons.home_outlined,
                  isSelected: selectedDelivery == 'Home Delivery',
                  onTap: () => setState(() => selectedDelivery = 'Home Delivery'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DeliveryOptionCard(
                  title: 'Store Pickup',
                  subtitle: 'Available today',
                  icon: Icons.storefront_outlined,
                  isSelected: selectedDelivery == 'Store Pickup',
                  onTap: () => setState(() => selectedDelivery = 'Store Pickup'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),
          const SectionTitle(icon: Icons.location_on_outlined, title: 'Shipping Address'),
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
                Text('EDIT', style: TextStyle(color: Color(0xFF0066E6), fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: () {},
            child: const Text('+ Add New Address'),
          ),

          const SizedBox(height: 28),
          const SectionTitle(icon: Icons.receipt_long_outlined, title: 'Order Summary'),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                CheckoutItem(
                  image: 'assets/images/iphone_15_pro.png',
                  name: 'Nova Pro Max',
                  detail: '256GB • Phantom Black',
                  qty: widget.phoneQty,
                  price: phonePrice * widget.phoneQty,
                ),
                const SizedBox(height: 12),
                CheckoutItem(
                  image: 'assets/images/aero_fold_4.png',
                  name: 'AeroBuds Pro',
                  detail: 'Noise Cancelling',
                  qty: widget.budsQty,
                  price: budsPrice * widget.budsQty,
                ),
                const SizedBox(height: 18),
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
                    ElevatedButton(onPressed: applyPromo, child: const Text('Apply')),
                  ],
                ),
                const Divider(height: 28),
                SummaryRow(label: 'Subtotal', value: '\$${subtotal.toStringAsFixed(2)}'),
                SummaryRow(label: 'Shipping', value: 'Free'),
                SummaryRow(label: 'Tax', value: '\$${tax.toStringAsFixed(2)}'),
                SummaryRow(label: 'Bundle Discount', value: '-\$${discount.toStringAsFixed(2)}', valueColor: Colors.green),
                const Divider(height: 28),
                SummaryRow(label: 'Total', value: '\$${total.toStringAsFixed(2)}', isTotal: true),
              ],
            ),
          ),

          const SizedBox(height: 24),
          Row(
            children: [
              Text('\$${total.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900)),
              const Spacer(),
              ElevatedButton(
                onPressed: placeOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00AEEF),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
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
        Expanded(
          child: Text('$name\n$detail\nQty: $qty'),
        ),
        Text('\$${price.toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.bold)),
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
          border: Border.all(color: isSelected ? const Color(0xFF0066E6) : const Color(0xFFD8E3F0), width: isSelected ? 2 : 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFF0066E6)),
            const Spacer(),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
            Text(subtitle, style: const TextStyle(color: Colors.black54, fontSize: 12)),
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
        Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
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