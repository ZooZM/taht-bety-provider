import 'package:flutter/material.dart';

class BackButtonCircle extends StatelessWidget {
  const BackButtonCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Align(
          alignment: Alignment.centerLeft,
          child:Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFCFD9E9)),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Icon(Icons.arrow_back, color: Color(0xFF3A4D6F)),
              ),
        ),
      ),
    );
  }
}
