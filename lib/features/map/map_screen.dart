import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../state/app_provider.dart';
import '../cart/cart_screen.dart';

class MapScreen extends StatelessWidget {
  final Map<String, dynamic>? store;

  const MapScreen({super.key, this.store});

  static final Map<String, dynamic> _defaultStore = {
    'id': 1,
    'name': 'Downtown Hub',
    'distance': '0.8 mi',
    'address': '1200 Tech Boulevard, Suite 100, Phnom Penh',
    'status': 'In Stock',
    'image': 'assets/images/store_1.png',
    'isOpen': true,
    'lat': 11.5564,
    'lng': 104.9282,
    'phone': '+85512345678',
    'hours': '9:00 AM - 8:00 PM',
    'rating': 4.8,
  };

  Map<String, dynamic> get selectedStore => store ?? _defaultStore;

  double get _lat => (selectedStore['lat'] as num?)?.toDouble() ?? 11.5564;
  double get _lng => (selectedStore['lng'] as num?)?.toDouble() ?? 104.9282;

  void _navigateToCart(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CartScreen()),
    );
  }

  Future<void> _openDirections(BuildContext context) async {
    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$_lat,$_lng',
    );

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (!context.mounted) return;
      _showMessage(context, 'Unable to open Google Maps');
    }
  }

  Future<void> _callStore(BuildContext context) async {
    final phone = selectedStore['phone']?.toString();
    if (phone == null || phone.isEmpty) {
      _showMessage(context, 'Phone number unavailable');
      return;
    }

    final uri = Uri(scheme: 'tel', path: phone);
    if (!await launchUrl(uri)) {
      if (!context.mounted) return;
      _showMessage(context, 'Unable to start phone call');
    }
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: const Color(0xFF007BF6),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final point = LatLng(_lat, _lng);

    return Scaffold(
      backgroundColor: const Color(0xFFEFF4FA),
      body: Stack(
        children: [
          Positioned.fill(
            child: FlutterMap(
              key: ValueKey(selectedStore['id']),
              options: MapOptions(initialCenter: point, initialZoom: 15.2),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.phone_shop_app',
                ),
                CircleLayer(
                  circles: [
                    CircleMarker(
                      point: point,
                      radius: 120,
                      useRadiusInMeter: true,
                      color: const Color(0xFF007BF6).withValues(alpha: 0.12),
                      borderColor: const Color(
                        0xFF007BF6,
                      ).withValues(alpha: 0.35),
                      borderStrokeWidth: 2,
                    ),
                  ],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: point,
                      width: 190,
                      height: 96,
                      alignment: Alignment.topCenter,
                      child: _SelectedStoreMarker(store: selectedStore),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withValues(alpha: 0.68),
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.06),
                    ],
                    stops: const [0.0, 0.42, 1.0],
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: Row(
                children: [
                  _FloatingIconButton(
                    icon: Icons.arrow_back_rounded,
                    onTap: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _FloatingSearchBar(
                      storeName: selectedStore['name']?.toString() ?? '',
                    ),
                  ),
                  const SizedBox(width: 12),
                  _CartButton(onTap: () => _navigateToCart(context)),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 78,
            left: 16,
            right: 16,
            child: _SelectedStoreBanner(store: selectedStore),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.38,
            minChildSize: 0.28,
            maxChildSize: 0.72,
            builder: (context, scrollController) {
              return _StoreSheet(
                store: selectedStore,
                controller: scrollController,
                onDirections: () => _openDirections(context),
                onCall: () => _callStore(context),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _FloatingIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _FloatingIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 8,
      shadowColor: Colors.black.withValues(alpha: 0.18),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 46,
          height: 46,
          child: Icon(icon, color: const Color(0xFF0F172A)),
        ),
      ),
    );
  }
}

class _CartButton extends StatelessWidget {
  final VoidCallback onTap;

  const _CartButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _FloatingIconButton(icon: Icons.shopping_cart_outlined, onTap: onTap),
        Positioned(
          right: -2,
          top: -2,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Color(0xFFFF3B30),
              shape: BoxShape.circle,
            ),
            child: Text(
              '${context.watch<CartProvider>().itemCount}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FloatingSearchBar extends StatelessWidget {
  final String storeName;

  const _FloatingSearchBar({required this.storeName});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(23),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search_rounded, color: Color(0xFF64748B), size: 21),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              storeName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF0F172A),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Icon(Icons.my_location_rounded, color: Color(0xFF007BF6)),
        ],
      ),
    );
  }
}

class _SelectedStoreBanner extends StatelessWidget {
  final Map<String, dynamic> store;

  const _SelectedStoreBanner({required this.store});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A).withValues(alpha: 0.88),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.16),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.storefront_rounded, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Text(
              'Viewing ${store['name']}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectedStoreMarker extends StatelessWidget {
  final Map<String, dynamic> store;

  const _SelectedStoreMarker({required this.store});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Text(
            store['name']?.toString() ?? 'PhoneHub Store',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 12,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xFF007BF6),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF007BF6).withValues(alpha: 0.38),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(
            Icons.storefront_rounded,
            color: Colors.white,
            size: 22,
          ),
        ),
      ],
    );
  }
}

class _StoreSheet extends StatelessWidget {
  final Map<String, dynamic> store;
  final ScrollController controller;
  final VoidCallback onDirections;
  final VoidCallback onCall;

  const _StoreSheet({
    required this.store,
    required this.controller,
    required this.onDirections,
    required this.onCall,
  });

  @override
  Widget build(BuildContext context) {
    final isOpen = store['isOpen'] == true;
    final isLimited = store['status'] == 'Limited Stock';
    final rating = (store['rating'] as num?)?.toDouble() ?? 4.5;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 30,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: ListView(
        controller: controller,
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 24),
        children: [
          Center(
            child: Container(
              width: 46,
              height: 5,
              decoration: BoxDecoration(
                color: const Color(0xFFD1D5DB),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  store['image'] as String? ?? 'assets/images/store_1.png',
                  width: 104,
                  height: 104,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 104,
                      height: 104,
                      color: const Color(0xFFF1F5F9),
                      child: const Icon(
                        Icons.storefront_rounded,
                        color: Color(0xFF94A3B8),
                        size: 42,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      store['name']?.toString() ?? 'PhoneHub Store',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF0F172A),
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                          size: 17,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          rating.toStringAsFixed(1),
                          style: const TextStyle(
                            color: Color(0xFF0F172A),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${store['distance']} away',
                          style: const TextStyle(color: Color(0xFF64748B)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _StatusPill(
                          text: isOpen ? 'Open now' : 'Closed',
                          color: isOpen
                              ? const Color(0xFF059669)
                              : const Color(0xFFEF4444),
                          background: isOpen
                              ? const Color(0xFFD1FAE5)
                              : const Color(0xFFFEE2E2),
                        ),
                        _StatusPill(
                          text: store['status']?.toString() ?? '',
                          color: isLimited
                              ? const Color(0xFFD97706)
                              : const Color(0xFF007BF6),
                          background: isLimited
                              ? const Color(0xFFFEF3C7)
                              : const Color(0xFFE0F2FE),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _DetailRow(
            icon: Icons.location_on_outlined,
            label: 'Address',
            value: store['address']?.toString() ?? '',
          ),
          _DetailRow(
            icon: Icons.schedule_rounded,
            label: 'Hours',
            value: store['hours']?.toString() ?? '',
          ),
          _DetailRow(
            icon: Icons.call_outlined,
            label: 'Phone',
            value: store['phone']?.toString() ?? 'Unavailable',
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onDirections,
                  icon: const Icon(Icons.directions_rounded),
                  label: const Text('Get Directions'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF007BF6),
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
              OutlinedButton.icon(
                onPressed: onCall,
                icon: const Icon(Icons.call_rounded),
                label: const Text('Call'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 15,
                  ),
                  foregroundColor: const Color(0xFF007BF6),
                  side: const BorderSide(color: Color(0xFFD8E3F0)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF007BF6), size: 21),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
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

class _StatusPill extends StatelessWidget {
  final String text;
  final Color color;
  final Color background;

  const _StatusPill({
    required this.text,
    required this.color,
    required this.background,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
