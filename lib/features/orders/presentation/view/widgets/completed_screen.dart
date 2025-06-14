import 'package:flutter/material.dart';
import 'order_card.dart';

class CompletedOrdersScreen extends StatelessWidget {
  const CompletedOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(top: height * 0.019),
      child: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.0059),
            child: OrderCard(
              orderNumber: '922529',
              date: 'April, 06',
              address: 'New Cairo, Cairo',
              mode: OrderCardMode.completed, // ✅ Completed mode (no buttons)
            ),
          );
        },
      ),
    );
  }
}
