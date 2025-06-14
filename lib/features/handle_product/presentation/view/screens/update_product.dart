import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety_provider/features/handle_product/presentation/view/screens/update_product_f.dart';
import 'package:taht_bety_provider/features/handle_product/presentation/view/screens/update_product_m.dart';
import 'package:taht_bety_provider/features/home/data/models/provider_model/post.dart';

import 'update_product_r.dart';

class UpdateProduct extends StatelessWidget {
   UpdateProduct({super.key});

  @override
  Widget build(BuildContext context) {
      final extra = GoRouterState.of(context).extra as Map<String, Object?>;
      print("extra: $extra");
      final String providerType = extra.keys.first;
      final Post posts = extra.values.first as Post;
      return Scaffold(
        body: providerType.split("-")[0] == "F"
            ? UpdateProductF(post: posts)
            : providerType.split("-")[0] == "R"
                ? UpdateProductR(post: posts)
                : UpdateProductM(post: posts,)
      );
  }
}