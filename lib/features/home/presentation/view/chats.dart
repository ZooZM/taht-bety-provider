import 'package:flutter/material.dart';

class Chats extends StatelessWidget {
  const Chats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      body: const Center(
        child: Text(
          'Welcome to the Chats page!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
