import 'package:flutter/material.dart';
import 'package:taht_bety_provider/core/utils/styles.dart';
import 'package:taht_bety_provider/features/home/data/models/provider_model/provider_model.dart';
import 'package:taht_bety_provider/features/home/presentation/view/widgets/product_list.dart';
import 'package:taht_bety_provider/features/home/presentation/view/widgets/review_section_widget.dart';
import 'package:taht_bety_provider/features/home/presentation/view/widgets/serv_upper_widget.dart';

class ServiceProfileBodyF extends StatelessWidget {
  const ServiceProfileBodyF({
    super.key,
    required this.provider,
  });
  final ProviderModel provider;

  static int nStars = 0;
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
                image:
                    provider.photo?.isNotEmpty == true ? provider.photo! : '',
                address: provider.locations![0].address!,
                name: provider.name!,
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
              ProductList(provider: provider),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ReviewSectionWidget(
                  providerId: provider.providerId!,
                  reviews: provider.reviews!,
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
