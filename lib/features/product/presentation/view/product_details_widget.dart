import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety_provider/features/home/data/models/provider_model/post.dart';
import 'package:taht_bety_provider/features/product/presentation/view/widgets/product_details_body.dart';

class ProductDetailsWidget extends StatelessWidget {
  const ProductDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final post = GoRouterState.of(context).extra as Post;

    return Scaffold(
      body: SafeArea(
        child: ProductDetailsBody(post: post),
      ),
    );
  }
}
