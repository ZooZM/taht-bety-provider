import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety_provider/core/utils/app_router.dart';
import 'package:taht_bety_provider/core/utils/styles.dart';
import 'package:taht_bety_provider/features/home/data/models/provider_model/post.dart';
import 'package:taht_bety_provider/features/home/presentation/view/widgets/add_icon.dart';
import 'package:taht_bety_provider/features/product/presentation/view/widgets/item_product_card.dart';

class CategoryDetailsBody extends StatefulWidget {
  final List<Post> products;
  final String category;

  const CategoryDetailsBody({
    super.key,
    required this.products,
    required this.category,
  });

  @override
  State<CategoryDetailsBody> createState() => _CategoryDetailsBodyState();
}

class _CategoryDetailsBodyState extends State<CategoryDetailsBody> {
  late List<Post> filteredProducts;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredProducts = widget.products; // في البداية، عرض جميع المنتجات
  }

  void _filterProducts(String query) {
    setState(() {
      searchQuery = query;
      filteredProducts = widget.products
          .where((product) =>
              product.title != null &&
              product.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 8,
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go(AppRouter.kHomePage);
                    }
                  },
                ),
                const SizedBox(width: 12),
                Text(
                  widget.category,
                  style: Styles.subtitle18Bold,
                ),
                const Spacer(),
                AddIcon(title: 'Add Items', onTap: () {
                  context.push(AppRouter.kAddProductM);
                }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for a product...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onChanged: (query) {
                _filterProducts(query);
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(
                  filteredProducts.length,
                  (index) => ItemProductCard(
                    post: filteredProducts[index],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
