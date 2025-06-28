import 'package:flutter/material.dart';
import 'package:taht_bety_provider/constants.dart';
import 'package:taht_bety_provider/core/utils/styles.dart';

class AddIcon extends StatelessWidget {
  AddIcon({
    super.key,
    required this.title,
    required this.onTap,
  });
  final String title;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: ksecondryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const Icon(Icons.add, color: kWhite),
            const SizedBox(width: 6),
            Text(
              title,
              style: Styles.text14Light.copyWith(
                color: kWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
