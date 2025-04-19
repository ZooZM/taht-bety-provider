import 'package:flutter/material.dart';

class CusttomButtom extends StatelessWidget {
  const CusttomButtom({
    super.key,
    required this.title,
    required this.color,
    this.borderRadius,
  });
  final Text title;
  final Color color;
  final BorderRadius? borderRadius;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(12),
        ),
        backgroundColor: color,
      ),
      onPressed: () {},
      child: title,
    );
  }
}
