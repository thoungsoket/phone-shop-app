import 'package:flutter/material.dart';

import '../common/phonehub_ui.dart';
import '../common/phonehub_store.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  int selectedFilter = 0;
  final filters = const ['All', '5 Stars', 'Phones', 'Repairs'];

  double _averageRating(List<ReviewModel> reviews) {
    if (reviews.isEmpty) return 0;
    final total = reviews.fold<int>(0, (sum, item) => sum + item.rating);
    return total / reviews.length;
  }

  void _showAddReviewSheet() {
    int rating = 5;
    final productController = TextEditingController(text: 'PhoneHub Service');
    final reviewController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: PhoneHubCard(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 42,
                      height: 5,
                      decoration: BoxDecoration(
                        color: PhoneHubColors.border,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Write a Review',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: PhoneHubColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        final active = index < rating;
                        return IconButton(
                          onPressed: () {
                            setSheetState(() => rating = index + 1);
                          },
                          icon: Icon(
                            active
                                ? Icons.star_rounded
                                : Icons.star_border_rounded,
                            color: const Color(0xFFF59E0B),
                            size: 34,
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: productController,
                      decoration: InputDecoration(
                        labelText: 'Product or Service',
                        filled: true,
                        fillColor: PhoneHubColors.softCard,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: reviewController,
                      minLines: 3,
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: 'Your Review',
                        filled: true,
                        fillColor: PhoneHubColors.softCard,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    PhoneHubGradientButton(
                      text: 'Submit Review',
                      onTap: () {
                        PhoneHubStore.instance.addReview(
                          product: productController.text,
                          rating: rating,
                          text: reviewController.text,
                        );
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Review submitted')),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: PhoneHubStore.instance,
      builder: (context, _) {
        final allReviews = PhoneHubStore.instance.reviews;
        final reviews = allReviews.where((item) {
          if (selectedFilter == 1) return item.rating == 5;
          if (selectedFilter == 2) {
            return item.product.toLowerCase().contains('phone') ||
                item.product.toLowerCase().contains('iphone') ||
                item.product.toLowerCase().contains('samsung');
          }
          if (selectedFilter == 3) {
            return item.product.toLowerCase().contains('repair') ||
                item.product.toLowerCase().contains('screen') ||
                item.product.toLowerCase().contains('battery');
          }
          return true;
        }).toList();

        final average = _averageRating(allReviews);

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
                      'Reviews',
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
                child: Column(
                  children: [
                    Text(
                      average.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 46,
                        fontWeight: FontWeight.w900,
                        color: PhoneHubColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    _Stars(rating: average.round(), size: 24),
                    const SizedBox(height: 8),
                    Text(
                      'Based on ${allReviews.length} customer reviews',
                      style: const TextStyle(
                        color: PhoneHubColors.textGray,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 18),
                    _RatingBar(label: '5', value: _ratingPercent(allReviews, 5)),
                    _RatingBar(label: '4', value: _ratingPercent(allReviews, 4)),
                    _RatingBar(label: '3', value: _ratingPercent(allReviews, 3)),
                    _RatingBar(label: '2', value: _ratingPercent(allReviews, 2)),
                    _RatingBar(label: '1', value: _ratingPercent(allReviews, 1)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 42,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final active = selectedFilter == index;

                    return InkWell(
                      borderRadius: BorderRadius.circular(999),
                      onTap: () => setState(() => selectedFilter = index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        alignment: Alignment.center,
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
                          filters[index],
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
              if (reviews.isEmpty)
                const PhoneHubCard(
                  child: Center(
                    child: Text(
                      'No reviews in this filter yet.',
                      style: TextStyle(color: PhoneHubColors.textGray),
                    ),
                  ),
                )
              else
                ...reviews.map(
                  (review) => Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: _ReviewCard(review: review),
                  ),
                ),
              const SizedBox(height: 4),
              PhoneHubGradientButton(
                text: 'Write a Review',
                onTap: _showAddReviewSheet,
              ),
            ],
          ),
        );
      },
    );
  }

  double _ratingPercent(List<ReviewModel> reviews, int rating) {
    if (reviews.isEmpty) return 0;
    final count = reviews.where((item) => item.rating == rating).length;
    return count / reviews.length;
  }
}

class _ReviewCard extends StatelessWidget {
  final ReviewModel review;

  const _ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return PhoneHubCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: PhoneHubColors.softCard,
                child: Text(
                  review.name.characters.first,
                  style: const TextStyle(
                    color: PhoneHubColors.blue,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        color: PhoneHubColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      review.product,
                      style: const TextStyle(
                        color: PhoneHubColors.textGray,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                review.date,
                style: const TextStyle(
                  color: PhoneHubColors.textGray,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _Stars(rating: review.rating, size: 18),
          const SizedBox(height: 10),
          Text(
            review.text,
            style: const TextStyle(
              color: PhoneHubColors.textDark,
              height: 1.45,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _Stars extends StatelessWidget {
  final int rating;
  final double size;

  const _Stars({
    required this.rating,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star_rounded : Icons.star_border_rounded,
          color: const Color(0xFFF59E0B),
          size: size,
        );
      }),
    );
  }
}

class _RatingBar extends StatelessWidget {
  final String label;
  final double value;

  const _RatingBar({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        children: [
          SizedBox(
            width: 18,
            child: Text(
              label,
              style: const TextStyle(
                color: PhoneHubColors.textGray,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Icon(
            Icons.star_rounded,
            color: Color(0xFFF59E0B),
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: value,
                minHeight: 8,
                backgroundColor: PhoneHubColors.softCard,
                valueColor: const AlwaysStoppedAnimation(
                  PhoneHubColors.blue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}