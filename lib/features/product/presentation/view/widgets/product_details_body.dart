import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety_provider/constants.dart';
import 'package:taht_bety_provider/core/utils/app_router.dart';
import 'package:taht_bety_provider/features/home/data/models/provider_model/post.dart';
import 'package:taht_bety_provider/features/product/presentation/view/widgets/food_image_widget.dart';
import 'package:taht_bety_provider/features/product/presentation/view/widgets/food_info_widget.dart';

class ProductDetailsBody extends StatefulWidget {
  const ProductDetailsBody({
    super.key,
    required this.post,
  });
  final Post post;

  @override
  State<ProductDetailsBody> createState() => _ProductDetailsBodyState();
}

class _ProductDetailsBodyState extends State<ProductDetailsBody> {
  @override
  void initState() {
    super.initState();
  }

  int count = 1;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FoodImageWidget(
                  image: widget.post.images![0],
                ),
                const SizedBox(height: 12),
                FoodInfoWidget(
                  price: widget.post.price.toString(),
                  description: widget.post.content!,
                  title: widget.post.title!,
                  plusCallback: () {
                    setState(() {
                      count++;
                    });
                  },
                  minusCallback: () {
                    setState(() {
                      if (count > 1) {
                        count--;
                      }
                    });
                  },
                  itemCount: count,
                ),
                const SizedBox(height: 50),
                //  Reviews(reviews: widget.post,)
              ],
            ),
          ),
        ),
        Positioned(
          top: 5,
          left: 16,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: kWhite,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 1,
                )
              ],
            ),
            child: GestureDetector(
                onTap: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.go(AppRouter.kHomePage);
                  }
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 30,
                )),
          ),
        ),
      ],
    );
  }
}
