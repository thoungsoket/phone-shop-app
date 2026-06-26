import 'package:flutter/material.dart';
import '../cart/cart_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String selectedFilter = 'Open Now';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF4FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0066E6)),
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
          IconButton(
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Color(0xFF0066E6),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: FakeMapPainter())),

          const Positioned(
            top: 105,
            left: 75,
            child: Icon(Icons.location_on, color: Color(0xFF0066E6), size: 42),
          ),
          const Positioned(
            top: 180,
            right: 70,
            child: Icon(Icons.location_on, color: Color(0xFF00AEEF), size: 38),
          ),
          const Positioned(
            top: 250,
            left: 145,
            child: Icon(Icons.location_on, color: Colors.redAccent, size: 36),
          ),

          ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const SizedBox(height: 45),

              TextField(
                decoration: InputDecoration(
                  hintText: 'Search branches or zip code',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon:
                      const Icon(Icons.my_location, color: Color(0xFF0066E6)),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 14),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ['Open Now', 'Repair Services', 'Trade-In Center']
                      .map(
                        (filter) => Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: ChoiceChip(
                            label: Text(filter),
                            selected: selectedFilter == filter,
                            selectedColor: const Color(0xFF0066E6),
                            backgroundColor: Colors.white,
                            labelStyle: TextStyle(
                              color: selectedFilter == filter
                                  ? Colors.white
                                  : Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                            onSelected: (_) {
                              setState(() => selectedFilter = filter);
                            },
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),

              const SizedBox(height: 210),

              const StoreMapCard(),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF0066E6),
        unselectedItemColor: Colors.black54,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.compare_arrows), label: 'Compare'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.storefront), label: 'Nearby'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

class StoreMapCard extends StatelessWidget {
  const StoreMapCard({super.key});

  @override
  Widget build(BuildContext context) {
    void showMessage(String text) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 48,
            height: 5,
            decoration: BoxDecoration(
              color: const Color(0xFFD1D5DB),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          const SizedBox(height: 14),

          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/store.png',
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                left: 10,
                bottom: 10,
                child: _SmallBadge(text: '1.2 mi', icon: Icons.map_outlined),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white.withValues(alpha: 0.9),
                  child: const Icon(Icons.close, size: 18),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              const Expanded(
                child: Text(
                  'Downtown Flagship',
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFDFFBEA),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '• OPEN',
                  style: TextStyle(
                    color: Color(0xFF16A34A),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          const Row(
            children: [
              Icon(Icons.location_on_outlined, size: 18, color: Colors.black54),
              SizedBox(width: 4),
              Expanded(
                child: Text(
                  '1200 Tech Boulevard, Suite 100\nMetropolis, NY 10001',
                  style: TextStyle(color: Color(0xFF64748B)),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _InfoBox(
                  icon: Icons.access_time,
                  title: 'Hours Today',
                  value: '9:00 AM - 8:00 PM',
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: _InfoBox(
                  icon: Icons.inventory_2_outlined,
                  title: 'Pro 15 Stock',
                  value: 'In Stock',
                  valueColor: Color(0xFF00AEEF),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => showMessage('Opening Google Maps...'),
                  icon: const Icon(Icons.directions),
                  label: const Text('Get Directions'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00AEEF),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton(
                onPressed: () => showMessage('Calling Downtown Flagship...'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                  foregroundColor: const Color(0xFF0066E6),
                  side: const BorderSide(color: Color(0xFFD8E3F0)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Icon(Icons.phone),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SmallBadge extends StatelessWidget {
  final String text;
  final IconData icon;

  const _SmallBadge({required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 13),
          const SizedBox(width: 4),
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color? valueColor;

  const _InfoBox({
    required this.icon,
    required this.title,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F7FB),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.black45),
          const SizedBox(width: 7),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: valueColor ?? Colors.black87,
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

class FakeMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.85)
      ..strokeWidth = 16
      ..strokeCap = StrokeCap.round;

    final roadPaint2 = Paint()
      ..color = const Color(0xFFDDE7F2)
      ..strokeWidth = 2;

    canvas.drawLine(
      Offset(size.width * 0.25, 0),
      Offset(size.width * 0.45, size.height),
      roadPaint,
    );

    canvas.drawLine(
      Offset(0, size.height * 0.22),
      Offset(size.width, size.height * 0.12),
      roadPaint,
    );

    canvas.drawLine(
      Offset(size.width * 0.7, 0),
      Offset(size.width * 0.1, size.height),
      roadPaint,
    );

    canvas.drawCircle(
      Offset(size.width * 0.35, size.height * 0.26),
      55,
      Paint()..color = const Color(0xFFE2F6EC).withValues(alpha: 0.7),
    );

    canvas.drawLine(
      Offset(0, size.height * 0.6),
      Offset(size.width, size.height * 0.55),
      roadPaint2,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}