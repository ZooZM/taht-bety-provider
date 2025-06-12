import 'package:flutter/material.dart';
import 'package:taht_bety_provider/constants.dart';
import 'package:taht_bety_provider/core/utils/styles.dart';
import 'package:taht_bety_provider/features/maps/presentation/view/widgets/location_arrow.dart';

class LowerWidgetOfMaps extends StatelessWidget {
  const LowerWidgetOfMaps(
      {super.key,
      required this.isLoading,
      required this.onArrowPress,
      required this.onButtonPress});
  final bool isLoading;
  final void Function() onArrowPress;
  final void Function() onButtonPress;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LocationArrow(
          onPressed: onArrowPress,
        ),
        Container(
          color: kWhite,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: GestureDetector(
              onTap: onButtonPress,
              child: Card(
                color: isLoading ? Colors.white54 : ksecondryColor,
                child: SizedBox(
                  height: 50,
                  child: Center(
                    child: Text(
                      isLoading
                          ? "Detecting location..."
                          : "Confirm pin location",
                      style: Styles.subtitle16Bold.copyWith(color: kWhite),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
