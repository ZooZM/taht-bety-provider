import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taht_bety_provider/constants.dart';
import 'package:taht_bety_provider/core/widgets/custom_widget_loading.dart';
import 'package:taht_bety_provider/features/orders/data/models/order_model/order_model.dart';
import 'package:taht_bety_provider/features/orders/presentation/view_model/cubit/order_cubit.dart';
import 'package:taht_bety_provider/features/orders/presentation/view_model/cubit/update_order_cubit.dart';
import 'order_card.dart';

class AcceptedOrdersScreen extends StatelessWidget {
  const AcceptedOrdersScreen({super.key, required this.orders});
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
            child: BlocConsumer<UpdateOrderCubit, UpdateOrderState>(
              listener: (context, state) async {
                if (state is UpdateOrderError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      duration: const Duration(seconds: 3),
                    ),
                  );
                } else if (state is UpdateOrderSuccess) {
                  await context.read<OrderCubit>().fetchAllOrders();
                }
              },
              builder: (context, state) {
                if (state is UpdateOrderLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  );
                }
                return OrderCard(
                  order: orders[index],
                  mode: OrderCardMode.accepted,
                  onAccept: () async => await context
                      .read<UpdateOrderCubit>()
                      .updateOrder(
                          orderId: orders[index].id!,
                          orderState: OrderCardMode.completed),
                  onReject: () async => await context
                      .read<UpdateOrderCubit>()
                      .updateOrder(
                          orderId: orders[index].id!,
                          orderState: OrderCardMode.cancelled),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
