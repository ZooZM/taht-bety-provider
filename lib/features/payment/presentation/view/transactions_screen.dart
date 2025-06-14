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
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.06,
            vertical: height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  const BackButtonCircle(),
                  SizedBox(width: width * 0.04),
                  Text(
                    "Transactions",
                    style: TextStyle(
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF15243F),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),

              // Transactions
              Expanded(
                child: ListView(
                  children: fullTransactions.entries.expand((entry) {
                    return [
                      Padding(
                        padding: EdgeInsets.only(bottom: height * 0.005),
                        child: Text(
                          entry.key,
                          style: TextStyle(
                            fontSize: width * 0.037,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF15243F),
                          ),
                        ),
                      ),
                      ...entry.value.map((item) => TransactionRow(item,
                          fontSize: width * 0.037, spacing: width * 0.04)),
                      SizedBox(height: height * 0.01),
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

// Transaction Data Class
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

// Responsive Transaction Row
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
    return Padding(
      padding: EdgeInsets.only(bottom: spacing * 0.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: spacing * 0.5,
                backgroundColor: const Color(0xFFE5EAF2),
                child:
                    Icon(item.icon, size: fontSize, color: Color(0xFF3A4D6F)),
              ),
              SizedBox(width: spacing * 0.6),
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
      ),
    );
  }
}
