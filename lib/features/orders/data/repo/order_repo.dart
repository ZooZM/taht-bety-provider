import 'package:dartz/dartz.dart';
import 'package:taht_bety_provider/core/errors/failures.dart';
import 'package:taht_bety_provider/features/orders/data/models/order_model/order_model.dart';

abstract class OrderRepo {
  Future<Either<Failure, List<OrderModel>>> fetchAllOrder();

  Future<void> updateOrder({
    required String orderId,
    required int quantity,
  });

  Future<void> deleteOrder(String orderId);

  Future<Either<Failure, void>> approveOrder(String orderId);
  Future<Either<Failure, void>> rejectOrder(String orderId);
  Future<Either<Failure, void>> completeOrder(String orderId);
}
