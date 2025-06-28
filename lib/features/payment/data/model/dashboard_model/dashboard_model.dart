import 'package:taht_bety_provider/features/payment/data/model/dashboard_model/transaction_model.dart';

import 'last_paymob_topup.dart';

class DashboardModel {
  LastPaymobTopup? lastPaymobTopup;
  String? id;
  String? providerId;
  List<String>? orders;
  int? completedOrders;
  double? balance;
  int? subscriptionFees;
  int? v;
  List<TransactionModel>? transactions;

  DashboardModel({
    this.lastPaymobTopup,
    this.id,
    this.providerId,
    this.orders,
    this.completedOrders,
    this.balance,
    this.subscriptionFees,
    this.v,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        lastPaymobTopup: json['lastPaymobTopup'] == null
            ? null
            : LastPaymobTopup.fromJson(
                json['lastPaymobTopup'] as Map<String, dynamic>),
        id: json['_id'] as String?,
        providerId: json['providerID'] as String?,
        orders: (json['orders'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList(),
        completedOrders: json['completedOrders'] as int?,
        balance: (json['balance'] as num?)?.toDouble(),
        subscriptionFees: json['subscriptionFees'] as int?,
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'lastPaymobTopup': lastPaymobTopup?.toJson(),
        '_id': id,
        'providerID': providerId,
        'orders': orders,
        'completedOrders': completedOrders,
        'balance': balance,
        'subscriptionFees': subscriptionFees,
        '__v': v,
      };
}
