import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({
    super.key,
    required this.backGroundColor,
    required this.iconColor,
    required this.icon,
    required this.iconSize,
    required this.containerSize,
  });
  final Color backGroundColor;
  final Color iconColor;
  final IconData icon;
  final double iconSize;
  final double containerSize;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: containerSize,
          width: containerSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backGroundColor,
          ),
          child: Center(
            child: Icon(
              icon,
              size: iconSize,
            ),
          ),
        ),
      ],
    );
  }
}
