import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taht_bety_provider/auth/presentation/view/widgets/back_button_circle.dart';
import 'package:taht_bety_provider/constants.dart';
import 'package:taht_bety_provider/core/utils/app_router.dart';
import 'package:taht_bety_provider/features/payment/presentation/view%20model/cubit/confirm_pay_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class PersonDetailsScreen extends StatefulWidget {
  const PersonDetailsScreen({
    super.key,
  });

  @override
  State<PersonDetailsScreen> createState() => _PersonDetailsScreenState();
}

class _PersonDetailsScreenState extends State<PersonDetailsScreen> {
  bool _isSubmitting = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra as Map<String?, dynamic?>;
    final paymentToken = extra['paymentData'];
    final orderId = extra['amount'];
    if (paymentToken == null || orderId == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<ConfirmPayCubit, ConfirmPayState>(
        listener: (context, state) {
          if (state is ConfirmPayFailure) {
            setState(() {
              _isSubmitting = false;
              _errorMessage = state.error;
            });
          } else if (state is ConfirmPaySuccess) {
            setState(() {
              _isSubmitting = false;
              _errorMessage = null;
            });
            context.go(
              AppRouter.kHomePage,
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const BackButtonCircle(),
                  const SizedBox(height: 40),
                  const Text(
                    'Payment Link',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF15243F),
                    ),
                  ),
                  const SizedBox(height: 20),
                  IconButton(
                    onPressed: () async {
                      String paymentLink = kPaymentUrl + paymentToken;
                      final url = Uri.parse(paymentLink);
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url,
                            mode: LaunchMode.externalApplication);
                      } else {
                        debugPrint("Could not launch $paymentLink");
                      }
                      print(orderId);
                    },
                    icon: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Text(
                          'Press here to pay',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  if (_errorMessage != null)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  const Spacer(),
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
                      onPressed: _isSubmitting
                          ? null
                          : () async {
                              setState(() {
                                _isSubmitting = true;
                                _errorMessage = null;
                              });

                              try {
                                await context
                                    .read<ConfirmPayCubit>()
                                    .confirmPay(orderId);
                              } catch (e) {
                                setState(() {
                                  _errorMessage = e.toString();
                                });
                              } finally {
                                setState(() => _isSubmitting = false);
                              }
                            },
                      child: _isSubmitting
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'Confirm Payment',
                              style: TextStyle(
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
          );
        },
      ),
    );
  }
}
