import 'package:flutter/material.dart';
import 'package:taht_bety_provider/constants.dart';
import 'package:taht_bety_provider/core/utils/styles.dart';
import 'package:taht_bety_provider/core/widgets/custom_circular_progress.dart';

class AddToBasketWidget extends StatelessWidget {
  const AddToBasketWidget(
      {super.key,
      required this.price,
      required this.onTap,
      required this.isLoading,
      required this.addedToBasket});
  final String price;
  final VoidCallback onTap;
  final bool isLoading;
  final bool addedToBasket;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? () {} : onTap,
      child: Container(
        decoration: BoxDecoration(
          color: ksecondryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: isLoading
              ? const Center(
                  child: CustomCircularprogress(size: 20, color: kWhite),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    addedToBasket
                        ? const Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 20,
                          )
                        : Text(
                            "Add to basket",
                            style: Styles.text14Light
                                .copyWith(color: Colors.white),
                          ),
                    Text(
                      "$price.00EGP",
                      style: Styles.text14Light.copyWith(color: Colors.white),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
