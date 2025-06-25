import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety_provider/constants.dart';
import 'package:taht_bety_provider/core/utils/app_router.dart';
import 'package:taht_bety_provider/core/utils/styles.dart';
import 'package:taht_bety_provider/features/home/data/models/provider_model/post.dart';
import 'package:taht_bety_provider/features/home/data/models/provider_model/provider_model.dart';
import 'package:taht_bety_provider/features/home/presentation/view/widgets/review_section_widget.dart';
import 'package:taht_bety_provider/features/home/presentation/view/widgets/serv_upper_widget.dart';

class ServiceProfileBodyM extends StatelessWidget {
  ServiceProfileBodyM({
    super.key,
    required this.provider,
  });
  final ProviderModel provider;
  static int nStars = 0;
  // Sample categories data - you can replace with your actual data
  final List<Map<String, String>> categories = [
    {'name': 'Bakery', 'image': '${kBaseCategoryAssets}bakery.png'},
    {'name': 'Beverages', 'image': '${kBaseCategoryAssets}beverages.png'},
    {'name': 'Canned Food', 'image': '${kBaseCategoryAssets}cannedfood.png'},
    {'name': 'Cheese', 'image': '${kBaseCategoryAssets}cheese.png'},
    {
      'name': 'Cleaning Supplies',
      'image': '${kBaseCategoryAssets}cleaningsupplies.png'
    },
    {'name': 'Cold Cuts', 'image': '${kBaseCategoryAssets}coldcuts.png'},
    {'name': 'Dairy & Eggs', 'image': '${kBaseCategoryAssets}dairy&eggs.png'},
    {'name': 'Fish', 'image': '${kBaseCategoryAssets}fish.png'},
    {'name': 'Frozen Food', 'image': '${kBaseCategoryAssets}frozenfood.png'},
    {
      'name': 'Fruits & Vegetables',
      'image': '${kBaseCategoryAssets}fruits&vegetables.png'
    },
    {'name': 'Groceries', 'image': '${kBaseCategoryAssets}groceries.png'},
    {
      'name': 'Herbs & Spices',
      'image': '${kBaseCategoryAssets}herbs&spices.png'
    },
    {
      'name': 'Meat & Poultry',
      'image': '${kBaseCategoryAssets}meat&poultry.png'
    },
    {'name': 'Nuts & Seeds', 'image': '${kBaseCategoryAssets}nuts&seeds.png'},
    {
      'name': 'Personal Care & Cosmetics',
      'image': '${kBaseCategoryAssets}personalcare&cosmetics.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ServUpperWidget(
              provider: provider,
            ),
            const SizedBox(height: 12),

            // Add the Categories section here
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 8),
              child: Text(
                "Shop by categories",
                style: Styles.subtitle18Bold,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.28,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        final String selectedCategory =
                            categories[index]['name']!;
                        final List<Post> filteredPosts =
                            (provider.posts ?? []).where((post) {
                          final String content =
                              post.content?.toLowerCase() ?? '';
                          final String expectedPrefix =
                              '${selectedCategory.toLowerCase()}-';
                          return content.startsWith(expectedPrefix);
                        }).toList();

                        context.push(
                          AppRouter.kCategoryDetail,
                          extra: {
                            'category': selectedCategory,
                            'posts': filteredPosts,
                          },
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 100,
                            height: MediaQuery.of(context).size.height *
                                0.28 *
                                0.25,
                            decoration: BoxDecoration(
                              color: const Color(0xffcfd9e9),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                categories[index]['image']!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                categories[index]['name']!,
                                style: Styles.text14Medium.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReviewSectionWidget(
                      providerId: provider.providerId!,
                      reviews: provider.reviews!,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 300),
          ],
        ),
      ),
    );
  }
}
