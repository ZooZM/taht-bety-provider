import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taht_bety_provider/features/payment/data/repo/dashboard_repo.dart';

part 'confirm_pay_state.dart';

class ConfirmPayCubit extends Cubit<ConfirmPayState> {
  ConfirmPayCubit(this.dashboardRepo) : super(ConfirmPayInitial());
  final DashboardRepo dashboardRepo;
  Future<void> confirmPay(String orderId) async {
    emit(ConfirmPayInProgress());
    try {
      final result = await dashboardRepo.verifyPayment(orderId);
      result.fold(
        (failure) => emit(ConfirmPayFailure(failure.failurMsg)),
        (paymentData) => emit(ConfirmPaySuccess(paymentData)),
      );
    } catch (e) {
      emit(ConfirmPayFailure(e.toString()));
    }
  }

  Future<void> initiatePayment(String providerId, double amount) async {
    emit(ConfirmPayInProgress());
    try {
      final result = await dashboardRepo.createPayment(providerId, amount);
      result.fold(
        (failure) => emit(ConfirmPayFailure(failure.failurMsg)),
        (paymentData) => emit(ConfirmPaySuccess(paymentData)),
      );
    } catch (e) {
      emit(ConfirmPayFailure(e.toString()));
    }
  }
}
