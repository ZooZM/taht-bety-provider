import 'package:flutter/material.dart';
import 'package:taht_bety_provider/auth/presentation/view/widgets/back_button_circle.dart';

class PersonDetailsScreen extends StatefulWidget {
  const PersonDetailsScreen({super.key});

  @override
  State<PersonDetailsScreen> createState() => _PersonDetailsScreenState();
}

class _PersonDetailsScreenState extends State<PersonDetailsScreen> {
  final TextEditingController _idController = TextEditingController(
    text: '2154825125541125584414', // initial value
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              const BackButtonCircle(),
              const SizedBox(height: 40),

              // Title
              const Text(
                'Personal details',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF15243F),
                ),
              ),
              const SizedBox(height: 20),

              // Label
              const Text(
                'ID',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF99A8C2),
                ),
              ),
              const SizedBox(height: 5),

              // Editable ID Field
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFCFD9E9)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _idController,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF3A4D6F),
                  ),
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                    border: InputBorder.none,
                    hintText: 'Enter your ID',
                  ),
                ),
              ),

              const Spacer(),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3A4D6F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    final id = _idController.text;
                    // TODO: Handle the submitted ID
                    debugPrint("Submitted ID: $id");
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
