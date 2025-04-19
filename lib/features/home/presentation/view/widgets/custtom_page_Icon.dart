import 'package:flutter/material.dart';
import 'package:taht_bety_provider/constants.dart';

class CusttomPageIcon extends StatelessWidget {
  const CusttomPageIcon({
    super.key,
    required this.icon,
    required this.isPressed,
  });
  final IconData icon;
  final bool isPressed;
  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: 38,
      color: isPressed ? kWhite : kBlack,
    );
  }
}
