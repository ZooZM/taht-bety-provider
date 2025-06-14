import 'package:flutter/material.dart';
import 'package:taht_bety_provider/features/orders/data/models/order_model/order_model.dart';
import 'order_card.dart';

class CompletedOrdersScreen extends StatelessWidget {
  const CompletedOrdersScreen({super.key, required this.orders});
  final List<OrderModel> orders;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(top: height * 0.019),
      child: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.0059),
            child: OrderCard(
              order: orders[index],

              mode: OrderCardMode.completed, // ✅ Completed mode (no buttons)
            ),
          );
        },
      ),
    );
  }
}
