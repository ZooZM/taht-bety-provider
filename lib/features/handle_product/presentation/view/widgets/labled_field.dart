// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class LabeledField extends StatelessWidget {
  final String label;
  final String hint;
  final double? height;
  final int? maxLines;
  final bool isNum;
  double? width;
  TextEditingController? controller;
  LabeledField({
    super.key,
    required this.label,
    required this.hint,
    this.height = 50,
    this.maxLines = 1,
    this.width,
    this.controller,
    this.isNum = false,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double labelWidth = screenWidth * 0.30;
    double fieldWidth = width ?? screenWidth * 0.60;
    double verticalMargin = screenHeight * 0.01;

    return Container(
      margin: EdgeInsets.symmetric(vertical: verticalMargin),
      width: screenWidth * 0.9,
      child: Row(
        crossAxisAlignment: maxLines! > 1
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: labelWidth,
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF3A4D6F),
              ),
            ),
          ),
          Container(
            width: fieldWidth,
            height: height,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE1E1E1), width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextFormField(
              controller: controller,
              maxLines: maxLines,
              keyboardType:
                  isNum ? const TextInputType.numberWithOptions() : null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: TextStyle(
                  fontSize: screenWidth * 0.035,
                  color: Colors.grey,
                ), // Adjust hint font size
              ),
            ),
          ),
        ],
      ),
    );
  }
}
