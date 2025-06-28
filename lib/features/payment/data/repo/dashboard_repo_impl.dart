import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:taht_bety_provider/auth/data/models/user_strorge.dart';
import 'package:taht_bety_provider/core/errors/failures.dart';
import 'package:taht_bety_provider/core/utils/api_service.dart';
import 'package:taht_bety_provider/features/payment/data/model/dashboard_model/dashboard_model.dart';
import 'package:taht_bety_provider/features/payment/data/model/dashboard_model/transaction_model.dart';
import 'package:taht_bety_provider/features/payment/data/repo/dashboard_repo.dart';

class DashboardRepoImpl implements DashboardRepo {
  final ApiService apiService;

  DashboardRepoImpl(this.apiService);
  @override
  Future<Either<Failure, DashboardModel>> fetchDashboardData(
      bool hasDashboard) async {
    final user = UserStorage.getUserData();
    try {
      final postResponse = await apiService.post(
        endPoint: 'dashboards',
        data: {},
        token: user.token,
      );

      if (postResponse['success']) {
        if (postResponse['data'] == null || postResponse['data'].isEmpty) {
          return Left(Serverfailure('No data available'));
        } else {
          List<TransactionModel> transactions = [];
          if (postResponse['data']['transactions'] != null) {
            for (var transaction in postResponse['data']['transactions']) {
              transactions.add(TransactionModel.fromJson(transaction));
            }
          }
          DashboardModel dashboard =
              DashboardModel.fromJson(postResponse['data']['dashboard']);
          dashboard.transactions = transactions;
          if (dashboard.transactions != null) {
            for (var transaction in dashboard.transactions!) {
              if (transaction.discount != null) {
                dashboard.balance =
                    ((dashboard.balance ?? 0) - (transaction.discount ?? 0));
              }
            }
          }
          return Right(dashboard);
        }
      } else {
        return Left(Serverfailure(postResponse['message'] ?? 'Unknown error'));
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        try {
          final getResponse = await apiService.get(
            endPoint: 'dashboards',
            token: user.token,
          );
          if (getResponse['success']) {
            if (getResponse['data'] == null || getResponse['data'].isEmpty) {
              return Left(Serverfailure('No data available'));
            } else {
              List<TransactionModel> transactions = [];
              if (getResponse['data']['transactions'] != null) {
                for (var transaction in getResponse['data']['transactions']) {
                  transactions.add(TransactionModel.fromJson(transaction));
                }
              }
              DashboardModel dashboard =
                  DashboardModel.fromJson(getResponse['data']['dashboard']);
              dashboard.transactions = transactions;
              if (dashboard.transactions != null) {
                for (var transaction in dashboard.transactions!) {
                  if (transaction.discount != null) {
                    dashboard.balance = ((dashboard.balance ?? 0) -
                        (transaction.discount ?? 0));
                  }
                }
              }
              return Right(dashboard);
            }
          } else {
            return Left(
                Serverfailure(getResponse['message'] ?? 'Unknown error'));
          }
        } catch (e2) {
          return left(Serverfailure(e2.toString()));
        }
      }
      // أي خطأ آخر
      if (e.response != null) {
        return left(e.response!.data['message'] != null
            ? Serverfailure(e.response!.data['message'])
            : Serverfailure.fromDioException(e));
      }
      return left(Serverfailure.fromDioException(e));
    } catch (e) {
      return left(Serverfailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, String>>> createPayment(
      String providerId, double amount) async {
    try {
      final user = UserStorage.getUserData();
      final response = await apiService.post(
        endPoint: 'paymob/payment/provider',
        token: user.token,
        data: {'providerId': user.userId, 'amount_cents': amount.ceil()},
      );

      if (response['success']) {
        print('Payment created successfully: ${response['data']}');
        return Right({
          'paymentKey': response['data']['paymentKey'],
          'orderId': response['data']['orderId'].toString(),
        });
      } else {
        return Left(Serverfailure(response['message'] ?? 'Unknown error'));
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          return left(e.response!.data['message'] != null
              ? Serverfailure(e.response!.data['message'])
              : Serverfailure.fromDioException(e));
        }
        return left(Serverfailure.fromDioException(e));
      }

      return left(Serverfailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> verifyPayment(
      String orderId) async {
    try {
      final user = UserStorage.getUserData();
      final response = await apiService.post(
        endPoint: 'paymob/verifyPayment',
        data: {'orderId': orderId},
        token: user.token,
      );

      if (response['amount'] != null) {
        return Right({
          'amount': response['amount'],
        });
      } else {
        return Left(Serverfailure(response['message'] ?? 'Unknown error'));
      }
    } catch (e) {
      return left(Serverfailure(
          'Failed to verify payment: Please try again or contact support.'));
    }
  }
}
