import 'package:flutter/material.dart';

import '../common/phonehub_ui.dart';
import '../common/phonehub_store.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  int selectedCategory = 0;

  final categories = const ['All', 'Phones', 'Repairs', 'Accessories'];

  final galleryItems = const [
    _GalleryItem(
      title: 'iPhone 16 Pro Display',
      subtitle: 'Latest flagship showcase',
      category: 'Phones',
      icon: Icons.phone_iphone_rounded,
      gradient: [Color(0xFF2563EB), Color(0xFF00C2FF)],
    ),
    _GalleryItem(
      title: 'Repair Workshop',
      subtitle: 'Professional repair station',
      category: 'Repairs',
      icon: Icons.build_rounded,
      gradient: [Color(0xFF0EA5E9), Color(0xFF22C55E)],
    ),
    _GalleryItem(
      title: 'Smart Accessories',
      subtitle: 'Cases, chargers, and watches',
      category: 'Accessories',
      icon: Icons.watch_rounded,
      gradient: [Color(0xFF7C3AED), Color(0xFFEC4899)],
    ),
    _GalleryItem(
      title: 'Customer Pickup',
      subtitle: 'Ready devices after service',
      category: 'Repairs',
      icon: Icons.shopping_bag_rounded,
      gradient: [Color(0xFFF97316), Color(0xFFFACC15)],
    ),
    _GalleryItem(
      title: 'Premium Headphones',
      subtitle: 'Audio accessories collection',
      category: 'Accessories',
      icon: Icons.headphones_rounded,
      gradient: [Color(0xFF111827), Color(0xFF64748B)],
    ),
    _GalleryItem(
      title: 'Quality Testing',
      subtitle: 'Final check before delivery',
      category: 'Repairs',
      icon: Icons.verified_rounded,
      gradient: [Color(0xFF16A34A), Color(0xFF86EFAC)],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: PhoneHubStore.instance,
      builder: (context, _) {
        final selected = categories[selectedCategory];
        final items = selected == 'All'
            ? galleryItems
            : galleryItems.where((item) => item.category == selected).toList();

        return PhoneHubPageShell(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.maybePop(context),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  const SizedBox(width: 4),
                  const Expanded(
                    child: Text(
                      'Gallery',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: PhoneHubColors.textDark,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              PhoneHubCard(
                padding: EdgeInsets.zero,
                child: Container(
                  height: 170,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [PhoneHubColors.blue, PhoneHubColors.cyan],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.photo_library_rounded,
                        color: Colors.white,
                        size: 38,
                      ),
                      const Spacer(),
                      const Text(
                        'PhoneHub Moments',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${PhoneHubStore.instance.favoriteGallery.length} favorites saved',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 42,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final active = selectedCategory == index;

                    return InkWell(
                      borderRadius: BorderRadius.circular(999),
                      onTap: () => setState(() => selectedCategory = index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        decoration: BoxDecoration(
                          color: active ? PhoneHubColors.blue : Colors.white,
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: active
                                ? PhoneHubColors.blue
                                : PhoneHubColors.border,
                          ),
                        ),
                        child: Text(
                          categories[index],
                          style: TextStyle(
                            color: active
                                ? Colors.white
                                : PhoneHubColors.textDark,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                itemCount: items.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: .78,
                ),
                itemBuilder: (context, index) {
                  return _GalleryCard(
                    item: items[index],
                    onOpen: () => _openViewer(items[index]),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _openViewer(_GalleryItem item) {
    showDialog(
      context: context,
      builder: (context) {
        return AnimatedBuilder(
          animation: PhoneHubStore.instance,
          builder: (context, _) {
            final favorite =
                PhoneHubStore.instance.favoriteGallery.contains(item.title);

            return Dialog(
              insetPadding: const EdgeInsets.all(18),
              backgroundColor: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 260,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: item.gradient,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Icon(item.icon, size: 90, color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          children: [
                            Text(
                              item.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: PhoneHubColors.textDark,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item.subtitle,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: PhoneHubColors.textGray,
                              ),
                            ),
                            const SizedBox(height: 18),
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () {
                                      PhoneHubStore.instance
                                          .toggleGalleryFavorite(item.title);
                                    },
                                    icon: Icon(
                                      favorite
                                          ? Icons.favorite_rounded
                                          : Icons.favorite_border_rounded,
                                      color: favorite
                                          ? const Color(0xFFDC2626)
                                          : PhoneHubColors.blue,
                                    ),
                                    label: Text(
                                      favorite ? 'Saved' : 'Favorite',
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () => Navigator.pop(context),
                                    icon: const Icon(Icons.close_rounded),
                                    label: const Text('Close'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _GalleryItem {
  final String title;
  final String subtitle;
  final String category;
  final IconData icon;
  final List<Color> gradient;

  const _GalleryItem({
    required this.title,
    required this.subtitle,
    required this.category,
    required this.icon,
    required this.gradient,
  });
}

class _GalleryCard extends StatelessWidget {
  final _GalleryItem item;
  final VoidCallback onOpen;

  const _GalleryCard({
    required this.item,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    final favorite = PhoneHubStore.instance.favoriteGallery.contains(item.title);

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onOpen,
      child: PhoneHubCard(
        padding: EdgeInsets.zero,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: item.gradient,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Icon(
                        item.icon,
                        color: Colors.white,
                        size: 54,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.white,
                        child: Icon(
                          favorite
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          color: favorite
                              ? const Color(0xFFDC2626)
                              : PhoneHubColors.blue,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Text(
                      item.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: PhoneHubColors.textDark,
                        fontWeight: FontWeight.w900,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      item.subtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: PhoneHubColors.textGray,
                        fontSize: 11,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}