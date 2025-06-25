import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety_provider/core/utils/styles.dart';
import 'package:taht_bety_provider/features/home/data/models/provider_model/provider_model.dart';
import 'package:taht_bety_provider/features/home/presentation/view/widgets/add_icon.dart';
import 'package:taht_bety_provider/features/home/presentation/view/widgets/product_list.dart';
import 'package:taht_bety_provider/features/home/presentation/view/widgets/review_section_widget.dart';
import 'package:taht_bety_provider/features/home/presentation/view/widgets/serv_upper_widget.dart';

import '../../../../../core/utils/app_router.dart';

class ServiceProfileBodyF extends StatelessWidget {
  const ServiceProfileBodyF({
    super.key,
    required this.provider,
  });
  final ProviderModel provider;

  static int nStars = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ServUpperWidget(
            provider: provider,
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Products",
                  style: Styles.subtitle18Bold,
                ),
                AddIcon(
                  title: "Add Items",
                  onTap: () {
                    context.push(AppRouter.kAddProductF);
                  },
                ),
              ],
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
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
