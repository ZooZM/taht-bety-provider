import 'package:flutter/material.dart';

class ExtrasWidget extends StatelessWidget {
  const ExtrasWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Extras:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text("Chili Oil"),
      ],
    );
  }
}
