import 'package:flutter/material.dart';
import 'package:taht_bety_provider/features/payment/presentation/view/transactions_screen.dart';

class TransactionModel {
  final int? amount;
  final String? type;
  final String? orderId;
  final double? discount;
  final double? net;
  final String? date;

  TransactionModel({
    this.amount,
    this.type,
    this.orderId,
    this.discount,
    this.net,
    this.date,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      amount: json['amount'] as int?,
      type: json['type'] as String?,
      orderId: json['orderId'] as String?,
      discount: (json['discount'] as num?)?.toDouble(),
      net: (json['net'] as num?)?.toDouble(),
      date: json['date'] as String?,
    );
  }

  Map<String, List<TransactionItem>> groupTransactionsByDate(
      List<TransactionModel> models) {
    Map<String, List<TransactionItem>> grouped = {};

    for (var model in models) {
      if (model.date == null) continue;
      final dateTime = DateTime.parse(model.date!);

      final dayKey = "${dateTime.day} ${_monthName(dateTime.month)}";
      final formattedTime =
          "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";

      final icon = model.type == 'Top up' ? Icons.add : Icons.receipt_long;
      final label = model.type == 'Top up'
          ? 'Top up'
          : (model.orderId != null ? 'order ${model.orderId}' : 'Order');

      final amount = model.type == 'Top up'
          ? "+EGP${model.amount}"
          : "-EGP${model.discount}";

      grouped.putIfAbsent(dayKey, () => []);
      grouped[dayKey]!.add(TransactionItem(
        icon: icon,
        label: label,
        amount: amount,
        time: formattedTime,
        // يمكنك إضافة discount و net في TransactionItem إذا أردت
      ));
    }

    return grouped;
  }

  String _monthName(int month) {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month];
  }
}
