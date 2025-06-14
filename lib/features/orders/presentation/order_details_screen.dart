import 'package:flutter/material.dart';
import '../../../auth/presentation/view/widgets/back_button_circle.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String orderNumber;
  final String name;
  final String phone;
  final String address;
  final List<OrderItem> items;

  const OrderDetailsScreen({
    super.key,
    required this.orderNumber,
    required this.name,
    required this.phone,
    required this.address,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final total = items.fold(0.0, (sum, i) => sum + i.price * i.quantity);
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Row(
                children: [
                  const BackButtonCircle(),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Order #$orderNumber',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF15243F),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: height * 0.02),

            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: ListView(
                  children: [
                    _buildInfoRow('Name :', name, width),
                    SizedBox(height: height * 0.01),
                    _buildInfoRow('Phone Number :', phone, width),
                    SizedBox(height: height * 0.01),
                    _buildInfoRow('Address :', address, width),
                    SizedBox(height: height * 0.02),
                    const Divider(color: Color(0xFFCFD9E9), height: 1),
                    SizedBox(height: height * 0.02),

                    // Items list
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      separatorBuilder: (_, __) =>
                          SizedBox(height: height * 0.012),
                      itemBuilder: (_, idx) {
                        final item = items[idx];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                item.name,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: width * 0.038,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF15243F),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'x${item.quantity}',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: width * 0.038,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF15243F),
                                  ),
                                ),
                                SizedBox(width: width * 0.04),
                                Text(
                                  item.price.toStringAsFixed(2),
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: width * 0.038,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF15243F),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: height * 0.1), // Space for total bar
                  ],
                ),
              ),
            ),

            // Total Bar
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05, vertical: height * 0.08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '${total.toStringAsFixed(2)} EGP',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, double width) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: width * 0.038,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF3A4D6F),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: width * 0.038,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF99A8C2),
            ),
          ),
        ),
      ],
    );
  }
}

class OrderItem {
  final String name;
  final int quantity;
  final double price;

  OrderItem({
    required this.name,
    required this.quantity,
    required this.price,
  });
}
