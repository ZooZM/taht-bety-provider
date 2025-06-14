import 'package:flutter/material.dart';
import 'order_card.dart';

class CancelledOrdersScreen extends StatelessWidget {
  const CancelledOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(top: height * 0.019),
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.0059),
            child: OrderCard(
              orderNumber: '922529',
              date: 'April, 06',
              address: 'New Cairo, Cairo',
              mode: OrderCardMode.cancelled, // ✅ No buttons, just address/date/order
            ),
          );
        },
      ),
    );
  }
}
