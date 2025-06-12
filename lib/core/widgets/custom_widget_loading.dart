import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomWidgetLoading extends StatelessWidget {
  const CustomWidgetLoading({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[500]!,
      highlightColor: Colors.grey[100]!,
      child: child,
    );
  }
}
