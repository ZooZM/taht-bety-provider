import 'package:flutter/material.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: const Center(
        child: Text(
          'Welcome to the Orders page!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
