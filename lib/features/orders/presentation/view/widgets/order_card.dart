import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_router.dart';
import '../../order_details_screen.dart';

enum OrderCardMode {
  pending,
  accepted,
  completed,
  cancelled,
}

class OrderCard extends StatelessWidget {
  final String orderNumber;
  final String date;
  final String address;
  final int? itemCount;
  final double? totalAmount;
  final OrderCardMode mode;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;

  const OrderCard({
    super.key,
    required this.orderNumber,
    required this.date,
    required this.address,
    this.itemCount,
    this.totalAmount,
    required this.mode,
    this.onAccept,
    this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final bool showActions =
        mode == OrderCardMode.pending || mode == OrderCardMode.accepted;
    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = screenWidth * 0.9;

    return GestureDetector(
      onTap: () {
        context.push(
          AppRouter.kOrderDetails,
          extra: {
            'orderNumber': '922529',
            'name': 'Alaa Khalid',
            'phone': '+201118941774',
            'address': 'New Cairo, Cairo',
            'items': [
              OrderItem(
                  name: 'Almarai plain milk 1L', quantity: 1, price: 76.50),
              OrderItem(
                  name: 'Almarai plain milk 1L', quantity: 2, price: 76.50),
              OrderItem(
                  name: 'Almarai plain milk 1L', quantity: 1, price: 76.50),
              OrderItem(
                  name: 'Almarai plain milk 1L', quantity: 1, price: 76.50),
              OrderItem(
                  name: 'Almarai plain milk 1L', quantity: 1, price: 76.50),
              OrderItem(
                  name: 'Almarai plain milk 1L', quantity: 1, price: 76.50),
            ],
          },
        );
      },
      child: Center(
        child: Container(
          width: containerWidth,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Color(0xFFCFD9E9))),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Order #$orderNumber',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Color(0xFF15243F),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    date,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color(0xFF15243F),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Icon(Icons.location_on,
                      size: 16, color: Color(0xFF3A4D6F)),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      'Address: $address',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xFF3A4D6F),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              if (itemCount != null)
                Text(
                  'Num of items: $itemCount items',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(0xFF3A4D6F),
                  ),
                ),
              if (totalAmount != null)
                Text(
                  'Total: ${totalAmount!.toStringAsFixed(0)} EGP',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(0xFF3A4D6F),
                  ),
                ),
              if (showActions)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: onAccept,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFCFD9E9),
                        ),
                        child: Text(
                            style: const TextStyle(
                                color: Color(0xFF15243F),
                                fontWeight: FontWeight.bold),
                            mode == OrderCardMode.pending
                                ? 'Accept'
                                : 'Completed'),
                      ),
                      ElevatedButton(
                        onPressed: onReject,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFCFD9E9),
                        ),
                        child: Text(
                          style: const TextStyle(
                              color: Color(0xFF15243F),
                              fontWeight: FontWeight.bold),
                          mode == OrderCardMode.pending
                              ? 'Reject'
                              : 'Cancelled',
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
