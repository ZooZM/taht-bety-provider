import 'package:flutter/material.dart';
import 'package:taht_bety_provider/core/utils/styles.dart';
import 'package:taht_bety_provider/features/home/data/models/provider_model/review.dart';
import 'package:taht_bety_provider/features/home/presentation/view/widgets/review_widget.dart';

class ReviewSectionWidget extends StatelessWidget {
  final String providerId;
  final List<Review> reviews;

  const ReviewSectionWidget({
    super.key,
    required this.providerId,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Rating & Reviews",
          style: Styles.subtitle18Bold,
        ),
        const SizedBox(height: 8),
        ListView.builder(
          itemCount: reviews.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 6),
              child: ReviewWidget(
                review: reviews[index],
              ),
            );
          },
        ),
      ],
    );
  }
}
