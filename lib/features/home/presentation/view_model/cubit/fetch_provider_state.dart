part of 'fetch_provider_cubit.dart';

@immutable
sealed class FetchProviderState {}

final class FetchProviderInitial extends FetchProviderState {}

final class FetchProviderLoading extends FetchProviderState {}

final class FetchProviderFailure extends FetchProviderState {
  final String failureMssg;

  FetchProviderFailure(this.failureMssg);
}

final class FetchProviderSuccess extends FetchProviderState {
  final ProviderModel provider;

  FetchProviderSuccess(this.provider);
}
