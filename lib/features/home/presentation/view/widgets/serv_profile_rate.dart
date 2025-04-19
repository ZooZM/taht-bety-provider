import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taht_bety_provider/core/utils/styles.dart';

class ServProfileRate extends StatelessWidget {
  const ServProfileRate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(
          FontAwesomeIcons.solidStar,
          color: Color(0xFFFF9633),
          size: 20,
        ),
        SizedBox(
          width: 6,
        ),
        Text(
          "4.9 ",
          style: Styles.text14Medium,
        ),
      ],
    );
  }
}
