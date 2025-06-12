import 'package:flutter/material.dart';
import 'package:taht_bety_provider/constants.dart';
import 'package:taht_bety_provider/core/utils/styles.dart';
import 'package:taht_bety_provider/core/widgets/custom_cushed_image.dart';
import 'package:taht_bety_provider/features/home/data/models/provider_model/review.dart';

class Reviews extends StatelessWidget {
  const Reviews({
    super.key,
    required this.reviews,
  });
  final Review reviews;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          children: [
            Row(
              children: [
                const CustomCushedImage(
                  image: '',
                  height: 50,
                  width: 50,
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  'Ahmed Ali',
                  style: Styles.text14Light.copyWith(
                    color: ksecondryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Row(
                  children: List.generate(
                    5,
                    (index) => const Icon(
                      Icons.star_border_outlined,
                      color: ksecondryColor,
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  '23/2/2025',
                  style: Styles.text12Light.copyWith(
                    color: ksecondryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magnaconsectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magnaconsectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna',
              style: Styles.text12Light.copyWith(
                color: ksecondryColor,
              ),
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
