part of 'update_provider_state_cubit.dart';

sealed class UpdateProviderStateState extends Equatable {
  const UpdateProviderStateState();

  @override
  List<Object> get props => [];
}

final class UpdateProviderStateInitial extends UpdateProviderStateState {}

final class UpdateProviderStateLoading extends UpdateProviderStateState {}

final class UpdateProviderStateFailure extends UpdateProviderStateState {
  final String failMes;

  const UpdateProviderStateFailure(this.failMes);
}

final class UpdateProviderStateSuccess extends UpdateProviderStateState {
  final ProviderModel provider;

  const UpdateProviderStateSuccess(this.provider);
}
