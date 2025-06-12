import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety_provider/auth/presentation/view/widgets/main_button.dart';

class FinishCreateProvider extends StatelessWidget {
  const FinishCreateProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                padding: const EdgeInsets.all(8),
                style: IconButton.styleFrom(
                  shape: const CircleBorder(
                    side: BorderSide(color: Colors.black26),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Center(
                child: Text(
                  "Set your Location here !",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              TextField(
                decoration: InputDecoration(
                  hintText: 'Add your address',
                  prefixIcon: const Icon(Icons.location_on_outlined),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),

              const Spacer(),

              MainButton(
                label: "Next",
                onPressed: () {
                  // Handle next action
                },
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
