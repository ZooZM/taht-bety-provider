import 'package:flutter/material.dart';
import 'package:taht_bety_provider/auth/presentation/view/widgets/back_button_circle.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    final fullTransactions = {
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
      '30 March': [
        TransactionItem(
            icon: Icons.add, label: 'Top up', amount: '+EGP50', time: '23:45'),
        TransactionItem(
            icon: Icons.receipt_long,
            label: 'order #5647805',
            amount: '-EGP22',
            time: '19:45'),
      ],
      '13 September ,2024': [
        TransactionItem(
            icon: Icons.add, label: 'Top up', amount: '+EGP50', time: '23:45'),
        TransactionItem(
            icon: Icons.receipt_long,
            label: 'order #5647805',
            amount: '-EGP22',
            time: '19:45'),
      ],
      '29 August ,2024': [
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              // Header
              Row(
                children: const [
                  BackButtonCircle(),
                  SizedBox(width: 16),
                  Text(
                    "Transactions",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF15243F),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Transactions List
              Expanded(
                child: ListView(
                  children: fullTransactions.entries.expand((entry) {
                    return [
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 6),
                        child: Text(
                          entry.key,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF15243F),
                          ),
                        ),
                      ),
                      ...entry.value
                          .map((item) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: const SizedBox(),
                              ))
                          .toList()
                        ..setAll(
                            0,
                            entry.value.map((item) => Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: TransactionRow(
                                    item,
                                    fontSize: 15,
                                    spacing: 20,
                                  ),
                                ))),
                      const SizedBox(height: 10),
                    ];
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Transaction Data
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

// Fixed-Size Transaction Row
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
                  size: fontSize + 2, color: const Color(0xFF3A4D6F)),
            ),
            SizedBox(width: spacing * 0.7),
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
                fontSize: fontSize - 1,
                color: const Color(0xFF99A8C2),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
