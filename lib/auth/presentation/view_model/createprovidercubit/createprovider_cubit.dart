import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taht_bety_provider/auth/data/repo/auth_repo.dart';
import 'package:taht_bety_provider/features/home/data/models/provider_model/provider_model.dart';

part 'createprovider_state.dart';

class CreateproviderCubit extends Cubit<CreateproviderState> {
  CreateproviderCubit(this.authRepo) : super(CreateproviderInitial());
  final AuthRepo authRepo;
  Future<void> checkID(File frontImage, File backImage) async {
    emit(CheckIdLoading());
    try {
      final response = await authRepo.checkId(frontImage, backImage);
      response.fold(
        (failure) => emit(CheckIdFailure(failure.failurMsg)),
        (listFiles) => emit(CheckIdSuccess(listFiles[0], listFiles[1])),
      );
    } catch (e) {
      emit(CheckIdFailure('Failed to check ID: ${e.toString()}'));
    }
  }

  Future<void> createFaceID(
      {required File photo, required bool isSignUp}) async {
    emit(CreateFaceIdLoading());
    try {
      final response =
          await authRepo.createFaceID(photo: photo, isSignUp: isSignUp);
      response.fold(
        (failure) => emit(CreateFaceIdFailure(failure.failurMsg)),
        (file) => emit(CreateFaceIdSuccess(file)),
      );
    } catch (e) {
      emit(CreateFaceIdFailure('Failed to create face ID: ${e.toString()}'));
    }
  }

  Future<void> createProvider(bool isActive) async {
    emit(CreateproviderLoading());
    try {
      final response = await authRepo.createProvider(isActive: isActive);
      response.fold(
        (failure) => emit(CreateproviderFailure(failure.failurMsg)),
        (provider) => emit(CreateproviderSuccess(provider)),
      );
    } catch (e) {
      emit(CreateproviderFailure('Failed to create provider: ${e.toString()}'));
    }
  }
}
