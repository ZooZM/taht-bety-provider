import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety_provider/features/orders/data/models/order_model/order_model.dart';

import '../../../../../core/utils/app_router.dart';

enum OrderCardMode {
  pending,
  accepted,
  completed,
  cancelled,
}

class OrderCard extends StatelessWidget {
  final OrderModel order;
  final OrderCardMode mode;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;

  const OrderCard({
    super.key,
    required this.mode,
    this.onAccept,
    this.onReject,
    required this.order,
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
            'order': order,
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
                      'Order #${order.id ?? ''}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Color(0xFF15243F),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Text(
                    'date',
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
                      'Address: ${order.userId?.locations?[0].address ?? ''}',
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

              Text(
                'Num of items: ${order.postId?.length ?? ''} items',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color(0xFF3A4D6F),
                ),
              ),

              Text(
                'Total: ${order.price} EGP',
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
