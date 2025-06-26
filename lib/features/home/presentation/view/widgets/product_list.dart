import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety_provider/constants.dart';
import 'package:taht_bety_provider/features/handle_product/presentation/view_model/product_cubit/product_cubit.dart';
import 'package:taht_bety_provider/features/home/data/models/provider_model/provider_model.dart';
import 'package:taht_bety_provider/features/home/presentation/view/widgets/product_card.dart';

import '../../../../../core/utils/app_router.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    super.key,
    required this.provider,
  });

  final ProviderModel provider;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductCubit, ProductState>(
      listener: (context, state) {
        if (state is ProductFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.failureMssg)),
          );
        } else if (state is ProductLoading) {
          const CircularProgressIndicator(
            color: kPrimaryColor,
          );
        } else if (state is DeleteProduct) {}
      },
      child: Column(
        children: List.generate(
          provider.posts!.length,
          (index) => Card(
            child: Dismissible(
              key: Key(provider.posts![index].id!),
              background: Container(
                color: kPrimaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.delete_outline, color: kWhite, size: 32),
                    SizedBox(height: 8),
                    Text("Delete",
                        style: TextStyle(color: kWhite, fontSize: 18)),
                  ],
                ),
              ),
              secondaryBackground: Container(
                color: kPrimaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerRight,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.edit, color: kWhite, size: 32),
                    SizedBox(height: 8),
                    Text("Edit", style: TextStyle(color: kWhite, fontSize: 18)),
                  ],
                ),
              ),
              onDismissed: (direction) {
                if (direction == DismissDirection.startToEnd) {
                  context.read<ProductCubit>().deleteProduct(
                        postId: provider.posts![index].id!,
                      );
                }
                // else if (direction == DismissDirection.endToStart) {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(content: Text("Edit")),
                //   );
                //   context.push(
                //     AppRouter.kUpdateProduct,
                //     extra: {provider.providerType: provider.posts![index]},
                //   );
                // }
              },
              confirmDismiss: (direction) async {
                if (direction == DismissDirection.endToStart) {
                  context.push(
                    AppRouter.kUpdateProduct,
                    extra: {provider.providerType: provider.posts![index]},
                  );
                  return false;
                }
                return true;
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                child: ProductCard(post: provider.posts![index]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
