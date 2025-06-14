import 'package:flutter/material.dart';
import 'order_card.dart';

class AcceptedOrdersScreen extends StatelessWidget {
  const AcceptedOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(top: height * 0.019),
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.0059),
            child: OrderCard(
              orderNumber: '922529',
              date: 'April, 06',
              address: 'New Cairo, Cairo',
              mode: OrderCardMode.accepted,
              onReject: () => print('Cancelled'),
              onAccept: () => print('Completed'),
            ),
          );
        },
      ),
    );
  }
}
