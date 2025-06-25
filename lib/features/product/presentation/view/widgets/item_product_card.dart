import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety_provider/constants.dart';
import 'package:taht_bety_provider/core/widgets/custom_circular_progress.dart';
import 'package:taht_bety_provider/core/widgets/custom_cushed_image.dart';
import 'package:taht_bety_provider/features/handle_product/presentation/view_model/product_cubit/product_cubit.dart';
import 'package:taht_bety_provider/features/home/data/models/provider_model/post.dart';

import '../../../../../core/utils/app_router.dart';

class ItemProductCard extends StatelessWidget {
  final Post post;

  const ItemProductCard({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 16),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image container with add button overlay
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CustomCushedImage(
                  image: post.images != null && post.images!.isNotEmpty
                      ? post.images![0]
                      : 'assets/images/placeholder.png', // صورة افتراضية إذا لم تكن هناك صور
                  height: 120,
                  width: double.infinity,
                  isImage: true,
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                       context.push(
                    AppRouter.kUpdateProduct,
                    extra: {'M': post},
                  );
                  
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: ksecondryColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: GestureDetector(
                    onTap: () async {
                      await context.read<ProductCubit>().deleteProduct(
                            postId: post.id!,
                          );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: ksecondryColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: BlocBuilder<ProductCubit, ProductState>(
                        builder: (context, state) {
                          if (state is ProductLoading) {
                            return const CustomCircularprogress(
                              size: 20,
                              color: kWhite,
                            );
                          }
                          return const Icon(
                            Icons.delete,
                            color: Colors.white,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Product information
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title ?? 'Unknown Product',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${post.price ?? 0} EGP',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
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
}
