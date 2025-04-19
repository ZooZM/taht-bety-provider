import 'package:flutter/material.dart';
import 'package:taht_bety_provider/core/utils/styles.dart';
import 'package:taht_bety_provider/features/home/data/models/provider_model/provider_model.dart';
import 'package:taht_bety_provider/features/home/presentation/view/widgets/product_card.dart';
import 'package:taht_bety_provider/features/home/presentation/view/widgets/review_section_widget.dart';
import 'package:taht_bety_provider/features/home/presentation/view/widgets/serv_upper_widget.dart';

class ServiceProfileBodyF extends StatefulWidget {
  const ServiceProfileBodyF({
    super.key,
    required this.provider,
  });
  final ProviderModel provider;

  static int nStars = 0;
  @override
  State<ServiceProfileBodyF> createState() => _ServiceProfileBodyFState();
}

class _ServiceProfileBodyFState extends State<ServiceProfileBodyF> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ServUpperWidget(
                image: widget.provider.photo?.isNotEmpty == true
                    ? widget.provider.photo!
                    : '',
                address: widget.provider.locations![0].address!,
                name: widget.provider.name!,
              ),
              const SizedBox(
                height: 12,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  "Products",
                  style: Styles.subtitle18Bold,
                ),
              ),
              Column(
                children: List.generate(
                  widget.provider.posts!.length,
                  (index) => Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 18),
                          child:
                              ProductCard(post: widget.provider.posts![index]),
                        ),
                      ),
                      Container(height: 1, color: Colors.black26),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ReviewSectionWidget(
                  providerId: widget.provider.providerId!,
                  reviews: widget.provider.reviews!,
                ),
              ),
              const SizedBox(height: 300),
            ],
          ),
        ),
      ],
    );
  }
}
