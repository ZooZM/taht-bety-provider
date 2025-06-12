import 'package:flutter/material.dart';
import 'package:taht_bety_provider/constants.dart';
import 'package:taht_bety_provider/core/utils/styles.dart';

class FoodInfoWidget extends StatelessWidget {
  const FoodInfoWidget(
      {super.key,
      required this.title,
      required this.description,
      required this.price,
      required this.plusCallback,
      required this.minusCallback,
      required this.itemCount});
  final String title;
  final String description;
  final String price;
  final VoidCallback plusCallback;
  final VoidCallback minusCallback;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Styles.subtitle16Bold,
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$price EGP",
              style: Styles.text16SemiBold,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: kWhite,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 1,
                  )
                ],
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: minusCallback,
                      child: const Icon(Icons.remove),
                    ),
                  ),
                  Text("$itemCount"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: plusCallback,
                      child: const Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
