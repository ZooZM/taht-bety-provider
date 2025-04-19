import 'package:flutter/material.dart';
import 'package:taht_bety_provider/constants.dart';
import 'package:taht_bety_provider/core/utils/styles.dart';
import 'package:taht_bety_provider/features/home/presentation/view/widgets/service_profile_body_f.dart';

List stars = List.generate(5, (index) => false);

class FeedbackRatingWidget extends StatefulWidget {
  const FeedbackRatingWidget({
    super.key,
  });
  @override
  State<FeedbackRatingWidget> createState() => _FeedbackRatingWidgetState();
}

class _FeedbackRatingWidgetState extends State<FeedbackRatingWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Text(
            "Rate This Provider",
            style: Styles.subtitle18Bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              stars.length,
              (index) => IconButton(
                onPressed: () {
                  setState(() {
                    for (int i = 0; i < stars.length; i++) {
                      if (i <= index) {
                        stars[i] = true;
                      } else {
                        stars[i] = false;
                      }
                      for (int i = 0; i < stars.length; i++) {
                        if (stars[i] == true) {
                          ServiceProfileBodyF.nStars = i + 1;
                        }
                      }
                    }
                  });
                },
                icon: Icon(
                  stars[index] ? Icons.star : Icons.star_border_outlined,
                  color: stars[index] ? kPrimaryColor : ksecondryColor,
                  size: 35,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
