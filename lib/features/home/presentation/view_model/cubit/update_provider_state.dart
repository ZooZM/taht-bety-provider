part of 'update_provider_cubit.dart';

sealed class UpdateProviderState extends Equatable {
  const UpdateProviderState();

  @override
  List<Object> get props => [];
}

final class UpdateProviderInitial extends UpdateProviderState {}

final class UpdateProviderLoading extends UpdateProviderState {}

final class UpdateProviderFailure extends UpdateProviderState {
  final String failureMssg;

  const UpdateProviderFailure(this.failureMssg);
}

final class UpdateProviderSuccess extends UpdateProviderState {
  const UpdateProviderSuccess();
}
