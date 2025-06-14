import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety_provider/core/utils/app_router.dart';
import 'package:taht_bety_provider/features/handle_product/presentation/view/widgets/back_button_circle.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedMethod = '';
  double _amount = 100;

  void _editAmountDialog() async {
    final controller = TextEditingController(text: _amount.toString());
    final result = await showDialog<double>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Enter amount"),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(prefixText: "EGP "),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          TextButton(
              onPressed: () {
                final val = double.tryParse(controller.text);
                if (val != null) Navigator.pop(context, val);
              },
              child: const Text("OK")),
        ],
      ),
    );

    if (result != null) {
      setState(() => _amount = result);
    }
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
        height: 226,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close, size: 20),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            RadioListTile(
              value: "Fawry Pay",
              groupValue: _selectedMethod,
              onChanged: (val) {
                setState(() => _selectedMethod = val!);
                Navigator.pop(context);
              },
              secondary: const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/fawry.jpg'),
              ),
              title: const Text("Fawry Pay"),
              subtitle: const Text("EGP 60 -1600"),
            ),
            RadioListTile(
              value: "Credit or debit card",
              groupValue: _selectedMethod,
              onChanged: (val) {
                setState(() => _selectedMethod = val!);
                Navigator.pop(context);
              },
              secondary: const CircleAvatar(
                backgroundColor: Color(0x57CFD9E9),
                child:
                    Icon(Icons.credit_card, size: 18, color: Color(0xFF15243F)),
              ),
              title: const Text("Credit or debit card"),
              subtitle: const Text("EGP 60 -1600"),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const BackButtonCircle(),
              const SizedBox(height: 30),

              // Select Payment Method
              GestureDetector(
                onTap: _showBottomSheet,
                child: Container(
                  width: double.infinity,
                  height: 59,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFCFD9E9)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: const Color(0xFFCFD9E9),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Icon(Icons.attach_money,
                                color: Color(0xFF15243F), size: 20),
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Payment method",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF15243F))),
                              Text(
                                _selectedMethod.isEmpty
                                    ? "Tap to select"
                                    : _selectedMethod,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF99A8C2)),
                              )
                            ],
                          )
                        ],
                      ),
                      const Icon(Icons.keyboard_arrow_right,
                          color: Color(0xFF3A4D6F))
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Enter Amount Section
              Container(
                width: double.infinity,
                height: 94,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFCFD9E9)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Enter amount",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF15243F),
                        )),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("EGP ${_amount.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            )),
                        GestureDetector(
                          onTap: _editAmountDialog,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: const Color(0x5ECFD9E9),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: const Icon(Icons.edit, size: 18),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const Spacer(),

              // Top Up Button
              GestureDetector(
                onTap: () {
                  context.push(AppRouter.kPersonDetails);
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3A4D6F),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Top up securely",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
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
