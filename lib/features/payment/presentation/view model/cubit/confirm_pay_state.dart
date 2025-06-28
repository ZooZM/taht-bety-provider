part of 'confirm_pay_cubit.dart';

sealed class ConfirmPayState extends Equatable {
  const ConfirmPayState();

  @override
  List<Object> get props => [];
}

final class ConfirmPayInitial extends ConfirmPayState {}

final class ConfirmPayInProgress extends ConfirmPayState {}

final class ConfirmPaySuccess extends ConfirmPayState {
  final Map<String, dynamic> message;
  const ConfirmPaySuccess(this.message);
  @override
  List<Object> get props => [message];
}

final class ConfirmPayFailure extends ConfirmPayState {
  final String error;
  const ConfirmPayFailure(this.error);
  @override
  List<Object> get props => [error];
}
