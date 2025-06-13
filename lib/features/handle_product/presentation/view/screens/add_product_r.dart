import 'package:flutter/material.dart';

import '../../../../../auth/presentation/view/widgets/back_button_circle.dart';
import '../widgets/labled_field.dart';


class AddProductR extends StatelessWidget {
  const AddProductR({super.key});

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

              // Description Field
              LabeledField(
                label: 'Description :',
                hint: 'Enter description',
                height: 116,
                maxLines: 4,
              ),

              const SizedBox(height: 20),

              // Ring Price Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Ring Price :",
                    style: const TextStyle(
                      color: Color(0xFF3A4D6F),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                  ),
                  _SubLabelBox(label: "To:"),
                  _InputBox(width: screenWidth * 0.15, height: 50),
                  _SubLabelBox(label: "From:"),
                  _InputBox(width: screenWidth * 0.15, height: 50),
                ],
              ),

              const SizedBox(height: 40),

              // Add Button
              SizedBox(
                width: screenWidth * 0.3,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle add button press
                    print("Add button pressed");
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
    );
  }
}

class _InputBox extends StatelessWidget {
  final double height;
  final double? width;

  const _InputBox({required this.height, this.width});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double responsiveWidth = width ?? screenWidth * 0.7;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Container(
        height: height,
        width: responsiveWidth,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE1E1E1), width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const TextField(
          maxLines: null,
          decoration: InputDecoration(
            border: InputBorder.none,
            isCollapsed: true,
          ),
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
