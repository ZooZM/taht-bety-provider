import 'package:flutter/material.dart';
import 'package:taht_bety_provider/core/utils/styles.dart';
import 'package:taht_bety_provider/features/home/data/models/provider_model/post.dart';
import '../../../../auth/presentation/view/widgets/back_button_circle.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String orderNumber;
  final String name;
  final String phone;
  final String address;
  final List<Post> items;
  final String description;

  const OrderDetailsScreen({
    super.key,
    required this.orderNumber,
    required this.name,
    required this.phone,
    required this.address,
    required this.items,
    required this.description,
  });

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final List<Map<String, int>> preparedItems = [];

  void prepareItems() {
    final Map<String, int> quantityMap = {};
    for (var post in widget.items) {
      final id = post.id ?? '';
      if (quantityMap.containsKey(id)) {
        quantityMap[id] = quantityMap[id]! + 1;
      } else {
        quantityMap[id] = 1;
      }
    }
    preparedItems.clear();
    preparedItems.addAll(quantityMap.entries.map((e) => {e.key: e.value}));
  }

  @override
  void initState() {
    super.initState();
    prepareItems();
  }

  @override
  Widget build(BuildContext context) {
    final total =
        widget.items.fold(0.0, (sum, item) => sum + (item.price ?? 0));
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
                      'Order #${widget.orderNumber}',
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
                    _buildInfoRow('Name :', widget.name, width),
                    SizedBox(height: height * 0.01),
                    _buildInfoRow('Phone Number :', widget.phone, width),
                    SizedBox(height: height * 0.01),
                    _buildInfoRow('Address :', widget.address, width),
                    SizedBox(height: height * 0.02),
                    const Divider(color: Color(0xFFCFD9E9), height: 1),
                    SizedBox(height: height * 0.02),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: preparedItems.length,
                      separatorBuilder: (_, __) =>
                          SizedBox(height: height * 0.012),
                      itemBuilder: (_, idx) {
                        final item = preparedItems[idx];
                        final postId = item.keys.first;
                        final quantity = item.values.first;
                        final post = widget.items.firstWhere(
                          (e) => e.id == postId,
                          orElse: () => Post(title: '', price: 0),
                        );

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                '${post.title} x $quantity',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: width * 0.038,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF15243F),
                                ),
                              ),
                            ),
                            Text(
                              '${(post.price ?? 0) * quantity} EGP',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: width * 0.038,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF15243F),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: height * 0.1),
                    const Text(
                      "Description",
                      style: Styles.subtitle18Bold,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      '   ${widget.description}',
                      style: Styles.text14Medium,
                    )
                  ],
                ),
              ),
            ),
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
