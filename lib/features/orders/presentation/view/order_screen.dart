// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

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

  void _switchTab(String tabName) {
    setState(() {
      _currentTab = tabName;
    });
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

  Widget _buildCurrentScreen() {
    switch (_currentTab) {
      case 'Pending':
        return const PendingOrdersScreen();
      case 'Accepted':
        return const AcceptedOrdersScreen();
      case 'completed':
        return const CompletedOrdersScreen();
      case 'Cancelled':
        return const CancelledOrdersScreen();
      default:
        return const PendingOrdersScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
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
                  Expanded(child: _buildCurrentScreen()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
