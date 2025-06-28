import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:taht_bety_provider/core/errors/failures.dart';
import 'package:taht_bety_provider/features/payment/data/model/dashboard_model/dashboard_model.dart';

abstract class DashboardRepo {
  Future<Either<Failure, DashboardModel>> fetchDashboardData(bool hasDashboard);
  Future<Either<Failure, Map<String, String>>> createPayment(
      String providerId, double amount);
  Future<Either<Failure, Map<String, dynamic>>> verifyPayment(String orderId);
}
