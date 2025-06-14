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

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.06, vertical: height * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.03),

              // Wallet
              Container(
                padding: EdgeInsets.all(width * 0.05),
                decoration: BoxDecoration(
                  color: const Color(0xFF3A4D6F),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.account_balance_wallet_outlined,
                            color: Colors.white, size: width * 0.05),
                        SizedBox(width: width * 0.02),
                        Text(
                          "wallet",
                          style: TextStyle(
                            fontSize: width * 0.035,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    Text(
                      "-EGP 125.78",
                      style: TextStyle(
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
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

              SizedBox(height: height * 0.03),

              // Transactions
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(width * 0.045),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFCFD9E9)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Transactions",
                          style: TextStyle(
                            fontSize: width * 0.042,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF15243F),
                          ),
                        ),
                      ),
                      ...groupedTransactions.entries.expand((entry) {
                        return [
                          Flexible(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                entry.key,
                                style: TextStyle(
                                  fontSize: width * 0.038,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF15243F),
                                ),
                              ),
                            ),
                          ),
                          ...entry.value.map((item) => TransactionRow(
                                item,
                                fontSize: width * 0.036,
                                spacing: width * 0.04,
                              )),
                        ];
                      }),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const TransactionsScreen(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "See All",
                              style: TextStyle(
                                fontSize: width * 0.035,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF3A4D6F),
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios,
                                size: width * 0.035,
                                color: const Color(0xFF3A4D6F)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TransactionItem {
  final IconData icon;
  final String label;
  final String amount;
  final String time;

  TransactionItem({
    required this.icon,
    required this.label,
    required this.amount,
    required this.time,
  });
}

class TransactionRow extends StatelessWidget {
  final TransactionItem item;
  final double fontSize;
  final double spacing;

  const TransactionRow(
    this.item, {
    super.key,
    required this.fontSize,
    required this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: spacing * 0.5,
              backgroundColor: const Color(0xFFE5EAF2),
              child: Icon(item.icon,
                  size: fontSize, color: const Color(0xFF3A4D6F)),
            ),
            Text(
              item.label,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF15243F),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              item.amount,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF15243F),
              ),
            ),
            Text(
              item.time,
              style: TextStyle(
                fontSize: fontSize * 0.95,
                color: const Color(0xFF99A8C2),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
