part of 'createprovider_cubit.dart';

sealed class CreateproviderState extends Equatable {
  const CreateproviderState();

  @override
  List<Object> get props => [];
}

final class CreateproviderInitial extends CreateproviderState {}

final class CreateproviderLoading extends CreateproviderState {}

final class CreateproviderSuccess extends CreateproviderState {
  final ProviderModel provider;
  const CreateproviderSuccess(this.provider);

  @override
  List<Object> get props => [provider];
}

final class CreateproviderFailure extends CreateproviderState {
  final String message;
  const CreateproviderFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class CheckIdSuccess extends CreateproviderState {
  final File idFrontSide;
  final File idBackSide;
  const CheckIdSuccess(this.idFrontSide, this.idBackSide);

  @override
  List<Object> get props => [idFrontSide, idBackSide];
}

final class CheckIdFailure extends CreateproviderState {
  final String message;
  const CheckIdFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class CheckIdLoading extends CreateproviderState {}

final class CheckIdInitial extends CreateproviderState {}

final class CreateFaceIdSuccess extends CreateproviderState {
  final File faceId;
  const CreateFaceIdSuccess(this.faceId);

  @override
  List<Object> get props => [faceId];
}

final class CreateFaceIdFailure extends CreateproviderState {
  final String message;
  const CreateFaceIdFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class CreateFaceIdLoading extends CreateproviderState {}

final class CreateFaceIdInitial extends CreateproviderState {}
