import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety_provider/core/utils/app_router.dart';
import 'package:taht_bety_provider/core/widgets/show_custom_choose_image_source.dart';
import 'package:taht_bety_provider/features/handle_product/presentation/view_model/product_cubit/product_cubit.dart';

import '../../../../../auth/presentation/view/widgets/back_button_circle.dart';
import '../widgets/labled_field.dart';

class AddProductR extends StatefulWidget {
  const AddProductR({super.key});

  @override
  State<AddProductR> createState() => _AddProductRState();
}

class _AddProductRState extends State<AddProductR> {
  List<File> images = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  bool loadingIndicator = false;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocListener<ProductCubit, ProductState>(
          listener: (context, state) {
            if (state is ProductSuccess) {
              setState(() {
                loadingIndicator = false;
              });
              context.push(AppRouter.kHomePage);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Product added successfully')),
              );
            } else if (state is ProductLoading) {
              setState(() {
                loadingIndicator = true;
              });
            } else if (state is ProductFailure) {
              setState(() {
                loadingIndicator = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.failureMssg)),
              );
            }
          },
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
                      if (index < images.length) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: screenWidth * 0.25,
                              height: screenWidth * 0.25,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color:
                                      const Color(0xFFCFD9E9), // border color
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Container(
                                    width: screenWidth * 0.12,
                                    height: screenWidth * 0.12,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle),
                                    child: Image.file(
                                      images[index],
                                      fit: BoxFit.cover,
                                    )),
                              )),
                        );
                      } else {
                        return GestureDetector(
                            onTap: () {
                              _addImage();
                            },
                            child: Container(
                                width: screenWidth * 0.25,
                                height: screenWidth * 0.25,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color:
                                        const Color(0xFFCFD9E9), // border color
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: Container(
                                      width: screenWidth * 0.12,
                                      height: screenWidth * 0.12,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle),
                                      child: Image.asset(
                                        'assets/icons/add_image.png',
                                        fit: BoxFit.contain,
                                      )),
                                )));
                      }
                    },
                    itemCount: images.length + 1,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                  ),
                ),

                const SizedBox(height: 30),

                // Name Field
                LabeledField(
                  controller: nameController,
                  label: 'Name :',
                  hint: 'Enter provider name',
                ),
                const SizedBox(height: 30),

                // Description Field
                LabeledField(
                  controller: descriptionController,
                  label: 'Description :',
                  hint: 'Enter description',
                  height: 116,
                  maxLines: 4,
                ),

                const SizedBox(height: 20),

                // Price Field
                LabeledField(
                  controller: priceController,
                  label: 'Price :',
                  hint: 'Enter price',
                  isNum: true,
                ),

                // Add Button
                SizedBox(
                  width: screenWidth * 0.3,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: loadingIndicator
                        ? () {}
                        : () {
                            if (nameController.text.isEmpty ||
                                descriptionController.text.isEmpty ||
                                priceController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Please fill all fields')),
                              );
                              return;
                            }

                            context.read<ProductCubit>().addProduct(
                                  title: nameController.text,
                                  content: descriptionController.text,
                                  price:
                                      double.tryParse(priceController.text) ??
                                          0.0,
                                  images: images,
                                );
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
                    child: loadingIndicator
                        ? const CircularProgressIndicator(
                            color: Color(0xFFCFD9E9),
                          )
                        : const Text(
                            'Add',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFCFD9E9),
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addImage() async {
    try {
      final image = await showCustomChooseImageSource(context);

      if (image == null) return; // User canceled the image picking
      setState(() {
        images.add(image);
      });
    } catch (e) {
      // Handle any errors that occur during image picking
      print("Error picking image: $e");
    }
  }
}
