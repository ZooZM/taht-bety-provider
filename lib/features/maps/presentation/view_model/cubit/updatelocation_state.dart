part of 'updatelocation_cubit.dart';

sealed class UpdatelocationState extends Equatable {
  const UpdatelocationState();

  @override
  List<Object> get props => [];
}

final class UpdatelocationInitial extends UpdatelocationState {}

final class UpdatelocationLoading extends UpdatelocationState {}

final class UpdatelocationSuccess extends UpdatelocationState {}

final class UpdatelocationError extends UpdatelocationState {
  final String message;

  const UpdatelocationError(this.message);

  @override
  List<Object> get props => [message];
}
