import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taht_bety_provider/core/utils/styles.dart';

class ServProfileRate extends StatelessWidget {
  const ServProfileRate({
    super.key,
    required this.rate,
  });
  final double rate;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          FontAwesomeIcons.solidStar,
          color: Color(0xFFFF9633),
          size: 20,
        ),
        const SizedBox(
          width: 6,
        ),
        Text(
          "$rate ",
          style: Styles.text14Medium,
        ),
      ],
    );
  }
}
