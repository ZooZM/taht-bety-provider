part of 'fetch_provider_cubit.dart';

@immutable
sealed class ProviderState {}

final class ProviderInitial extends ProviderState {}

final class FetchProviderLoading extends ProviderState {}

final class FetchProviderFailure extends ProviderState {
  final String failureMssg;

  FetchProviderFailure(this.failureMssg);
}

final class FetchProviderSuccess extends ProviderState {
  final ProviderModel provider;

  FetchProviderSuccess(this.provider);
}
