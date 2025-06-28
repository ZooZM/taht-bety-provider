import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety_provider/auth/data/models/user_strorge.dart';
import 'package:taht_bety_provider/core/utils/app_router.dart';
import 'package:taht_bety_provider/features/handle_product/presentation/view/widgets/back_button_circle.dart';
import 'package:taht_bety_provider/features/payment/presentation/view%20model/cubit/confirm_pay_cubit.dart';
import 'package:taht_bety_provider/features/payment/presentation/view%20model/cubit/dashboard_cubit.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedMethod = '';
  final TextEditingController _amountController = TextEditingController();
  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.3,
        padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RadioListTile(
              value: "fawry",
              groupValue: _selectedMethod,
              onChanged: (val) {
                setState(() => _selectedMethod = val!);
                Navigator.pop(context);
              },
              secondary: Image.asset(
                "assets/images/fawry.jpg",
                width: 30,
                height: 30,
              ),
              title: const Text("Fawry"),
              subtitle: const Text("EGP 60 -1600"),
            ),
            RadioListTile(
              value: "paymob",
              groupValue: _selectedMethod,
              onChanged: (val) {
                setState(() => _selectedMethod = val!);
                Navigator.pop(context);
              },
              secondary: Image.asset(
                "assets/images/paymob.jpg",
                width: 30,
                height: 30,
              ),
              title: const Text("Paymob"),
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
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _amountController.text = '100';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConfirmPayCubit, ConfirmPayState>(
      listener: (context, state) {
        if (state is ConfirmPaySuccess) {
          context.go(AppRouter.kPersonDetails, extra: {
            "paymentData": state.message["paymentKey"],
            "amount": state.message["orderId"].toString(),
          });
        } else if (state is ConfirmPayFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFCFD9E9)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Enter amount",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF15243F),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFCFD9E9)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const Text("EGP ",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                  )),
                              Expanded(
                                child: TextFormField(
                                  controller: _amountController,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700),
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                  ),
                                  onFieldSubmitted: (val) {
                                    final parsed = double.tryParse(val);
                                    if (parsed != null) {
                                      _amountController.text =
                                          parsed.toString();
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [50, 100, 200, 500].map((amount) {
                            return ElevatedButton(
                              onPressed: () {
                                _amountController.text = amount.toString();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFECECEC),
                                foregroundColor: Colors.black87,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text("EGP ${amount.toString()}"),
                            );
                          }).toList(),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),

                  // Top Up Button
                  GestureDetector(
                    onTap: () {
                      if (_selectedMethod.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please select a payment method"),
                          ),
                        );
                        return;
                      } else if (_amountController.text.isEmpty ||
                          double.tryParse(_amountController.text) == null ||
                          double.parse(_amountController.text) <= 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "Please enter a valid amount exceeding 60 EGP"),
                          ),
                        );
                        return;
                      } else if (_selectedMethod != "paymob") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "Sorry, this method is not available yet."),
                          ),
                        );
                        return;
                      } else {
                        context.read<ConfirmPayCubit>().initiatePayment(
                              UserStorage.getUserData().providerId!,
                              double.parse(_amountController.text) * 100,
                            );
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3A4D6F),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: state is DashboardLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
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
      },
    );
  }
}
