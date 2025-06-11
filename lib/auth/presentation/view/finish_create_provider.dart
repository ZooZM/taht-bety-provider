import 'package:flutter/material.dart';

class FinishCreateProvider extends StatelessWidget {
  const FinishCreateProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Your account has been created successfully. Please wait for approval.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
