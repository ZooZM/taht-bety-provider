// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../../auth/presentation/view/widgets/back_button_circle.dart';
import '../../../../home/data/models/provider_model/post.dart';
import '../widgets/labled_field.dart';
import 'add_product_hc.dart';

class UpdateProductM extends StatelessWidget {
  UpdateProductM({
    Key? key,
   this.post,
  }) : super(key: key);
  final Post? post;

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

              GestureDetector(
                onTap: () {
                  // Handle image tap
                  print("Add icon tapped");
                },
                child: Container(
                  width: screenWidth * 0.25,
                  height: screenWidth * 0.25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFCFD9E9), // border color
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: screenWidth * 0.12,
                      height: screenWidth * 0.12,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Image.asset(
                        'assets/icons/add_image.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Name Field
              LabeledField(label: 'Name :', hint: 'Enter provider name'),
              const SizedBox(height: 30),

              // Price Field
              LabeledField(label: 'Price :', hint: 'Enter price'),
              SizedBox(height: screenSize.height * 0.3),
              // Add Button
              SizedBox(
                width: screenWidth * 0.3,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AddProductHC()),
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
              ),

              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
