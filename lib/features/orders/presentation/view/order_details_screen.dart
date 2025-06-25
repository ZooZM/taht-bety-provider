import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taht_bety_provider/constants.dart';
import 'package:taht_bety_provider/core/utils/styles.dart';
import 'package:taht_bety_provider/features/home/data/models/provider_model/post.dart';
import 'package:taht_bety_provider/features/orders/data/models/order_model/order_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../auth/presentation/view/widgets/back_button_circle.dart';

class OrderDetailsScreen extends StatefulWidget {
  final OrderModel order;

  const OrderDetailsScreen({
    super.key,
    required this.order,
  });

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final List<Map<String, int>> preparedItems = [];

  void prepareItems() {
    final Map<String, int> quantityMap = {};
    for (var post in widget.order.postId ?? []) {
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

  Future<void> _launchPhone(String phoneNumber) async {
    final Uri telUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(telUri)) {
      await launchUrl(telUri);
    } else {
      debugPrint('Could not launch phone dialer');
    }
  }

  Future<void> _launchGoogleMaps(double latitude, double longitude) async {
    final Uri googleMapsUri = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');

    if (await canLaunchUrl(googleMapsUri)) {
      await launchUrl(googleMapsUri);
    } else {
      debugPrint('Could not launch Google Maps');
    }
  }

  Future<void> _launchWhatsApp(String phoneNumber) async {
    final Uri whatsappUri =
        Uri.parse("https://wa.me/${phoneNumber.replaceAll('+', '')}");
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch WhatsApp');
    }
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.order.postId
            ?.fold(0.0, (sum, item) => sum + (item.price ?? 0)) ??
        0;
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
                      'Order #${widget.order.id}',
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
                    _buildInfoRow(
                        'Name :', widget.order.userId?.name ?? 'user', width),
                    Row(
                      children: [
                        _buildInfoRow(
                          'Phone Number :',
                          widget.order.userId?.phoneNumber ?? 'phone',
                          width,
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            _launchWhatsApp(
                                widget.order.userId?.phoneNumber ?? '');
                          },
                          icon: const Icon(
                            FontAwesomeIcons.whatsapp,
                            color: kPrimaryColor,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 12),
                        IconButton(
                          onPressed: () {
                            _launchPhone(
                                widget.order.userId?.phoneNumber ?? '');
                          },
                          icon: const Icon(
                            FontAwesomeIcons.phone,
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildInfoRow(
                            'Address :',
                            widget.order.userId?.locations?[0].address ??
                                'address',
                            width),
                        IconButton(
                          onPressed: () {
                            _launchGoogleMaps(
                                widget.order.userId?.locations?[0].coordinates
                                        .coordinates[0] ??
                                    0,
                                widget.order.userId?.locations?[0].coordinates
                                        .coordinates[1] ??
                                    0);
                          },
                          icon: const Icon(
                            FontAwesomeIcons.locationArrow,
                            color: kPrimaryColor,
                          ),
                        )
                      ],
                    ),
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
                        final post = widget.order.postId?.firstWhere(
                          (e) => e.id == postId,
                          orElse: () => Post(title: '', price: 0),
                        );

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                '${post?.title ?? ''} x $quantity',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: width * 0.038,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF15243F),
                                ),
                              ),
                            ),
                            Text(
                              '${(post?.price ?? 0) * quantity} EGP',
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
                      '   ${widget.order.description ?? 'No description provided.'}',
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
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: Styles.subtitle18Bold.copyWith(
            color: const Color(0xFF15243F),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          value,
          style: Styles.subtitle18Bold.copyWith(
            color: const Color(0xFF15243F),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
