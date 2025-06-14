import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taht_bety_provider/features/orders/data/repo/order_repo.dart';
import 'package:taht_bety_provider/features/orders/presentation/view/widgets/order_card.dart';

part 'update_order_state.dart';

class UpdateOrderCubit extends Cubit<UpdateOrderState> {
  UpdateOrderCubit(this.orderRepo) : super(UpdateOrderInitial());
  final OrderRepo orderRepo;

  Future<void> updateOrder(
      {required OrderCardMode orderState, required String orderId}) async {
    emit(UpdateOrderLoading());
    if (orderState == OrderCardMode.accepted) {
      var result = await orderRepo.approveOrder(orderId);
      result.fold((failure) => emit(UpdateOrderError(failure.failurMsg)),
          (result) => emit(UpdateOrderSuccess()));
    } else if (orderState == OrderCardMode.completed) {
      var result = await orderRepo.completeOrder(orderId);
      result.fold((failure) => emit(UpdateOrderError(failure.failurMsg)),
          (result) => emit(UpdateOrderSuccess()));
    } else if (orderState == OrderCardMode.cancelled) {
      var result = await orderRepo.rejectOrder(orderId);
      result.fold((failure) => emit(UpdateOrderError(failure.failurMsg)),
          (result) => emit(UpdateOrderSuccess()));
    }
  }
}
