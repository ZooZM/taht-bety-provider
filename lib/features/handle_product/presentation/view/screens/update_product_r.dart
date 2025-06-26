import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety_provider/constants.dart';
import 'package:taht_bety_provider/core/utils/app_fun.dart';
import 'package:taht_bety_provider/core/utils/app_router.dart';
import 'package:taht_bety_provider/core/widgets/custom_circular_progress.dart';
import 'package:taht_bety_provider/core/widgets/custom_cushed_image.dart';
import 'package:taht_bety_provider/core/widgets/show_custom_choose_image_source.dart';
import 'package:taht_bety_provider/features/handle_product/presentation/view_model/product_cubit/product_cubit.dart';

import 'package:taht_bety_provider/features/home/data/models/provider_model/post.dart';
import 'package:taht_bety_provider/features/home/presentation/view_model/cubit/fetch_provider_cubit.dart';

import '../widgets/back_button_circle.dart';
import '../widgets/labled_field.dart';

class UpdateProductR extends StatefulWidget {
  const UpdateProductR({
    super.key,
    this.post,
  });
  final Post? post;

  @override
  State<UpdateProductR> createState() => _UpdateProductRState();
}

class _UpdateProductRState extends State<UpdateProductR> {
  late TextEditingController nameController;
  late TextEditingController descController;
  late TextEditingController priceFromController;
  late TextEditingController priceToController;
  List<String> postImages = [];
  List<File> images = [];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.post?.title ?? '');
    descController = TextEditingController(text: widget.post?.content ?? '');
    priceFromController =
        TextEditingController(text: widget.post?.price?.toString() ?? '');
    priceToController =
        TextEditingController(text: widget.post?.price?.toString() ?? '');
    postImages = widget.post?.images ?? [];
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    priceFromController.dispose();
    priceToController.dispose();
    super.dispose();
  }

  void _addImage() async {
    try {
      final image = await showCustomChooseImageSource(context);

      if (image == null) return;
      setState(() {
        images.add(image);
      });
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  Future<List<String>> prepareImagesForUpload() async {
    List<String> base64Images = [];

    for (String imageUrl in postImages) {
      try {
        final base64 = await AppFun.networkImageToBase64(imageUrl);
        base64Images.add(base64);
      } catch (e) {
        print('Error converting old image: $e');
      }
    }

    for (File imageFile in images) {
      try {
        final base64 = await AppFun.imageToBase64(imageFile);

        base64Images.add(base64);
      } catch (e) {
        print('Error converting new image: $e');
      }
    }

    return base64Images;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const BackButtonCircle(),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: screenWidth * 0.25,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    if (index < postImages.length) {
                      // صور قديمة من الباك (روابط)
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _buildImageContainer(
                          screenWidth,
                          imageWidget: CustomCushedImage(
                            image: postImages[index],
                            height: 1,
                            width: 1,
                            isImage: true,
                          ),
                          isImage: true,
                          onPressed: () {
                            setState(() {
                              postImages.remove(postImages[index]);
                            });
                          },
                        ),
                      );
                    } else if (index < postImages.length + images.length) {
                      // صور جديدة مضافة (ملفات)
                      int newImageIndex = index - postImages.length;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _buildImageContainer(
                          screenWidth,
                          imageWidget: ClipOval(
                            child: Image.file(
                              images[newImageIndex],
                              fit: BoxFit.cover,
                            ),
                          ),
                          isImage: true,
                          onPressed: () {
                            setState(() {
                              images.remove(images[newImageIndex]);
                            });
                          },
                        ),
                      );
                    } else {
                      // زرار إضافة صورة
                      return GestureDetector(
                        onTap: () => _addImage(),
                        child: _buildImageContainer(screenWidth,
                            imageWidget: Image.asset(
                              'assets/icons/add_image.png',
                              fit: BoxFit.contain,
                            ),
                            onPressed: () {},
                            isImage: false),
                      );
                    }
                  },
                  itemCount: postImages.length + images.length + 1,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                ),
              ),

              const SizedBox(height: 30),

              // Name Field
              LabeledField(
                label: 'Name :',
                hint: 'Enter provider name',
                controller: nameController,
              ),

              const SizedBox(height: 30),

              // Description Field
              LabeledField(
                label: 'Description :',
                hint: 'Enter description',
                height: 116,
                maxLines: 6,
                controller: descController,
              ),

              const SizedBox(height: 20),

              // Ring Price Fields
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // const Text(
                  //   "Ring Price :",
                  //   style: TextStyle(
                  //     color: Color(0xFF3A4D6F),
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.w500,
                  //     fontFamily: 'Inter',
                  //   ),
                  // ),
                  const SizedBox(width: 20),

                  const _SubLabelBox(label: "Start:"),
                  const Spacer(
                    flex: 2,
                  ),
                  _InputBox(
                      width: screenWidth * 0.15,
                      height: 50,
                      controller: priceFromController),
                  const Spacer(
                    flex: 5,
                  ),
                  // _SubLabelBox(label: "From:"),
                  // _InputBox(
                  //     width: screenWidth * 0.15,
                  //     height: 50,
                  //     controller: priceToController),
                ],
              ),

              const SizedBox(height: 40),

              // Add Button
              BlocConsumer<ProductCubit, ProductState>(
                listener: (context, state) {
                  if (state is ProductFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.failureMssg),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  } else if (state is UpdateProduct) {
                    context.read<ProviderCubit>().fetchProvider();
                    context.go(AppRouter.kHomePage);
                  }
                },
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const CustomCircularprogress(
                      size: 50,
                      color: ksecondryColor,
                    );
                  } else {
                    return SizedBox(
                      width: screenWidth * 0.3,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (nameController.text == '' ||
                              priceFromController.text == '' ||
                              descController.text == '') {
                            return;
                          }

                          Post newPost = widget.post!;
                          newPost.images = await prepareImagesForUpload();
                          await context
                              .read<ProductCubit>()
                              .updateProduct(product: newPost);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3A4D6F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 5,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 21,
                            vertical: 16,
                          ),
                          shadowColor: const Color.fromRGBO(58, 77, 110, 0.22),
                        ),
                        child: const Text(
                          'Edit',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFCFD9E9),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),

              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageContainer(
    double screenWidth, {
    required Widget imageWidget,
    required void Function()? onPressed,
    required bool isImage,
  }) {
    return Stack(
      children: [
        Container(
          width: screenWidth * 0.25,
          height: screenWidth * 0.25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFFCFD9E9),
              width: 2,
            ),
          ),
          child: Center(
            child: Container(
              width: screenWidth * 0.12,
              height: screenWidth * 0.12,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: imageWidget,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: isImage
              ? IconButton(
                  onPressed: onPressed,
                  icon: const Icon(
                    Icons.delete,
                    color: ksecondryColor,
                  ),
                )
              : const SizedBox(),
        )
      ],
    );
  }
}

class _InputBox extends StatelessWidget {
  final double height;
  final double? width;
  final TextEditingController controller;

  const _InputBox({required this.height, this.width, required this.controller});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double responsiveWidth = width ?? screenWidth * 0.7;

    return Container(
      height: height,
      width: responsiveWidth,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE1E1E1), width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: TextField(
          maxLines: 1,
          controller: controller,
          decoration: const InputDecoration(
            border: InputBorder.none,
            isCollapsed: true,
          ),
          keyboardType: const TextInputType.numberWithOptions(),
        ),
      ),
    );
  }
}

class _SubLabelBox extends StatelessWidget {
  final String label;

  const _SubLabelBox({required this.label});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double responsiveFontSize = screenWidth * 0.040;

    return Text(
      label,
      style: TextStyle(
        color: const Color(0xFF3A4D6F),
        fontSize: responsiveFontSize,
        fontWeight: FontWeight.w500,
        fontFamily: 'Inter',
      ),
    );
  }
}
