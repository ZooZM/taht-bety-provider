import 'package:flutter/material.dart';
import 'package:taht_bety_provider/constants.dart';
import 'package:taht_bety_provider/core/utils/styles.dart';

class MapsAppBar extends StatelessWidget {
  const MapsAppBar({
    super.key,
    required this.onPress,
    required this.isLoading,
  });
  final void Function() onPress;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: onPress,
                    child: const Icon(
                      Icons.arrow_back_outlined,
                      size: 28,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "Delivery Address",
                    style: Styles.subtitle18Bold,
                  ),
                  const Spacer(),
                  const SizedBox(
                    width: 8,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
