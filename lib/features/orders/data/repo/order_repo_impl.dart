import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:taht_bety_provider/auth/data/models/provider_curuser.dart';
import 'package:taht_bety_provider/auth/data/models/user_strorge.dart';
import 'package:taht_bety_provider/core/errors/failures.dart';
import 'package:taht_bety_provider/core/utils/api_service.dart';
import 'package:taht_bety_provider/features/home/data/models/provider_model/post.dart';
import 'package:taht_bety_provider/features/orders/data/models/order_model/order_model.dart';
import 'package:taht_bety_provider/features/orders/data/repo/order_repo.dart';

class OrderRepoImpl implements OrderRepo {
  final ApiService apiService;
  OrderRepoImpl(this.apiService);
  @override
  Future<void> deleteOrder(String orderId) {
    // TODO: implement deleteOrder
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<OrderModel>>> fetchAllOrder() async {
    try {
      ProviderCurUser user = UserStorage.getUserData();

      final response = await apiService.get(
        token: user.token,
        endPoint: 'orders/my-orders',
      );

      final orderData = response['data']['orders'] as List<dynamic>?;

      if (orderData == null || orderData.isEmpty) {
        return left(Serverfailure("No orders found"));
      }

      List<OrderModel> orders =
          orderData.map((json) => OrderModel.fromJson(json)).toList();

      for (var order in orders) {
        if (order.postId != null && order.postId!.isNotEmpty) {
          List<Post> fullPosts = [];

          for (var partialPost in order.postId!) {
            final postResponse = await apiService.get(
              token: user.token,
              endPoint: 'posts/${partialPost.id}',
            );

            final postData = postResponse['data']['doc'];
            fullPosts.add(Post.fromJson(postData));
          }

          order.postId = fullPosts;
        }
      }

      return right(orders);
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
  Future<void> updateOrder({required String orderId, required int quantity}) {
    // TODO: implement updateOrder
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> approveOrder(String orderId) async {
    try {
      ProviderCurUser user = UserStorage.getUserData();

      final response = await apiService.put(
        token: user.token,
        endPoint: 'orders/approve-order/$orderId',
        data: {},
      );
      if (response['success']) {
        return const Right(null);
      } else {
        return left(Serverfailure("Failed to approve order"));
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
  Future<Either<Failure, void>> completeOrder(String orderId) async {
    try {
      ProviderCurUser user = UserStorage.getUserData();

      final response = await apiService.put(
        token: user.token,
        endPoint: 'orders/complete-order/$orderId',
        data: {},
      );
      if (response['success']) {
        return const Right(null);
      } else {
        return left(Serverfailure("Failed to complete order"));
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
  Future<Either<Failure, void>> rejectOrder(String orderId) async {
    try {
      ProviderCurUser user = UserStorage.getUserData();

      final response = await apiService.put(
        token: user.token,
        endPoint: 'orders/reject-order/$orderId',
        data: {},
      );
      if (response['success']) {
        return const Right(null);
      } else {
        return left(Serverfailure("Failed to reject order"));
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
}
