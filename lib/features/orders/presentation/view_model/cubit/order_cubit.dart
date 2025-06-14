import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taht_bety_provider/core/errors/failures.dart';
import 'package:taht_bety_provider/features/orders/data/models/order_model/order_model.dart';
import 'package:taht_bety_provider/features/orders/data/repo/order_repo.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(this.orderRepo) : super(OrderInitial());
  final OrderRepo orderRepo;

  Future<void> fetchAllOrders() async {
    emit(OrderLoading());
    final Either<Failure, List<OrderModel>> result =
        await orderRepo.fetchAllOrder();

    result.fold(
      (failure) => emit(OrderError(failure.failurMsg)),
      (orders) => emit(OrderSuccess(orders)),
    );
  }
}
