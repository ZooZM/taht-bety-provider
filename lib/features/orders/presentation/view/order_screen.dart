// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taht_bety_provider/features/orders/data/models/order_model/order_model.dart';
import 'package:taht_bety_provider/features/orders/presentation/view_model/cubit/order_cubit.dart';

import 'widgets/accepted_screen.dart';
import 'widgets/cancelled_screen.dart';
import 'widgets/completed_screen.dart';
import 'widgets/pending_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  String _currentTab = 'Pending';
  List<OrderModel> orders = [];
  void _switchTab(String tabName) {
    setState(() {
      _currentTab = tabName;
    });
  }

  Future<void> reloadPage(BuildContext context) async {
    await context.read<OrderCubit>().fetchAllOrders();
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  void initState() {
    super.initState();
    // Fetch initial orders when the screen is loaded
    reloadPage(context);
  }

  Widget _buildTabButton(String tabName, double screenWidth) {
    final isSelected = _currentTab == tabName;
    return GestureDetector(
      onTap: () => _switchTab(tabName),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            tabName,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.041,
              color: isSelected
                  ? const Color(0xFF15243F)
                  : const Color(0xFF99A8C2),
              height: 1.5419,
            ),
          ),
          if (isSelected)
            Container(
              width: screenWidth * 0.238,
              height: 5,
              color: const Color(0xFF15243F),
              margin: EdgeInsets.only(top: screenWidth * 0.02),
            ),
        ],
      ),
    );
  }

  Widget _buildCurrentScreen({required List<OrderModel> orders}) {
    switch (_currentTab) {
      case 'Pending':
        return PendingOrdersScreen(
          orders: orders.where((o) => o.status == 'pending').toList(),
        );
      case 'Accepted':
        return AcceptedOrdersScreen(
          orders: orders.where((o) => o.status == 'accepted').toList(),
        );
      case 'completed':
        return CompletedOrdersScreen(
          orders: orders.where((o) => o.status == 'completed').toList(),
        );
      case 'Cancelled':
        return CancelledOrdersScreen(
          orders: orders.where((o) => o.status == 'canceled').toList(),
        );
      default:
        return PendingOrdersScreen(
          orders: orders.where((o) => o.status == 'pending').toList(),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () => reloadPage(context),
        child: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.03,
                  left: screenWidth * 0.026,
                  right: screenWidth * 0.026,
                ), // Responsive padding (18, 10, 10 on 390)
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceAround, // Distribute space more evenly
                  children: [
                    Expanded(
                      child: _buildTabButton('Pending', screenWidth),
                    ),
                    Expanded(
                      child: _buildTabButton('Accepted', screenWidth),
                    ),
                    Expanded(
                      child: _buildTabButton('completed', screenWidth),
                    ),
                    Expanded(
                      child: _buildTabButton('Cancelled', screenWidth),
                    ),
                  ],
                ),
              ),
              Divider(
                color: const Color(0xFF99A8C2),
                thickness: 1,
                height: screenHeight * 0.035,
              ),
              Expanded(
                  child: BlocConsumer<OrderCubit, OrderState>(
                listener: (context, state) {
                  if (state is OrderError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  } else if (state is OrderSuccess) {
                    orders = state.orders;
                  }
                },
                builder: (context, state) {
                  if (state is OrderLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is OrderError) {
                    return Center(child: Text(state.message));
                  } else if (state is OrderSuccess) {
                    orders = state.orders;
                  }
                  return _buildCurrentScreen(orders: orders);
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
