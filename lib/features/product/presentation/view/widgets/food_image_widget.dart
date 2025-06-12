import 'package:flutter/material.dart';
import 'package:taht_bety_provider/core/widgets/custom_cushed_image.dart';

class FoodImageWidget extends StatelessWidget {
  const FoodImageWidget({super.key, required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomCushedImage(
        image: image,
        height: 200,
        width: 200,
        isImage: true,
      ),
    );
  }
}
