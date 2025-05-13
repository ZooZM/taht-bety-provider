import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taht_bety_provider/constants.dart';
import 'package:taht_bety_provider/core/utils/styles.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Icon(
          FontAwesomeIcons.bell,
          size: 44,
        ),
        Positioned(
          top: 0,
          right: 6,
          child: Container(
            height: 25,
            width: 25,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: kExtraLite,
            ),
            child: const Center(
              child: Text(
                "3",
                style: Styles.text14Medium,
              ),
            ),
          ),
        )
      ],
    );
  }
}
