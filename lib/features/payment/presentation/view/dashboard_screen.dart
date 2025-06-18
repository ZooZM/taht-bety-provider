import 'package:flutter/material.dart';
import 'package:taht_bety_provider/features/payment/presentation/view/transactions_screen.dart';

import 'payment_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final groupedTransactions = {
      '28 May': [
        TransactionItem(
            icon: Icons.add, label: 'Top up', amount: '+EGP50', time: '23:45'),
        TransactionItem(
            icon: Icons.receipt_long,
            label: 'order #5647805',
            amount: '-EGP22',
            time: '19:45'),
      ],
      '14 May': [
        TransactionItem(
            icon: Icons.receipt_long,
            label: 'order #5647805',
            amount: '-EGP22',
            time: '19:45'),
      ],
    };

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              /// Wallet Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF3A4D6F),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.account_balance_wallet_outlined,
                            color: Colors.white, size: 20),
                        SizedBox(width: 8),
                        Text(
                          "wallet",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "-EGP 125.78",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const PaymentScreen()),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "Top Up",
                          style: TextStyle(
                            color: Color(0xFF15243F),
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// Transactions List
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFCFD9E9)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Transactions",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF15243F),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...groupedTransactions.entries.expand((entry) {
                      return [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              entry.key,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF15243F),
                              ),
                            ),
                          ),
                        ),
                        ...entry.value.map((item) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6),
                              child: TransactionRow(
                                item,
                                fontSize: 14,
                                spacing: 16,
                              ),
                            )),
                      ];
                    }),
                    const Divider(height: 20),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const TransactionsScreen(),
                          ),
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "See All",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF3A4D6F),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios,
                              size: 14, color: Color(0xFF3A4D6F)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
