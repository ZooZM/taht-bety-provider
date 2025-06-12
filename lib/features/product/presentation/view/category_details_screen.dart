import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety_provider/features/home/data/models/provider_model/post.dart';
import 'package:taht_bety_provider/features/product/presentation/view/widgets/category_details_body.dart';

class CategoryDetailsScreen extends StatelessWidget {
  const CategoryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra as Map<String, Object?>;
    final String category = extra['category'] as String; // استخراج اسم الفئة
    final List<Post> posts =
        extra['posts'] as List<Post>; // استخراج قائمة المنشورات

    return Scaffold(
      body: CategoryDetailsBody(
        products: posts,
        category: category,
      ),
    );
  }
}
