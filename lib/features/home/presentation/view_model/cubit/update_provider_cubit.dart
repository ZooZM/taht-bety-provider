import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taht_bety_provider/features/home/data/repos/provider_profile_repo.dart';

part 'update_provider_state.dart';

class UpdateProviderCubit extends Cubit<UpdateProviderState> {
  UpdateProviderCubit(this.providerProfileRepo)
      : super(UpdateProviderInitial());
  ProviderProfileRepo providerProfileRepo;

  Future<void> updateProvider(String image) async {
    emit(UpdateProviderLoading());
    var result = await providerProfileRepo.updateProviderImage(image);
    result.fold((failure) {
      emit(UpdateProviderFailure(failure.failurMsg));
    }, (data) {
      emit(const UpdateProviderSuccess());
    });
  }

  Future<void> updateProviderName(String name) async {
    emit(UpdateProviderLoading());
    var result = await providerProfileRepo.updateProviderName(name);
    result.fold((failure) {
      emit(UpdateProviderFailure(failure.failurMsg));
    }, (data) {
      emit(const UpdateProviderSuccess());
    });
  }

  Future<void> updateProviderLastPhoto(String date) async {
    emit(UpdateProviderLoading());
    var result = await providerProfileRepo.updateProviderLastPhoto(date);
    result.fold((failure) {
      emit(UpdateProviderFailure(failure.failurMsg));
    }, (data) {
      emit(const UpdateProviderSuccess());
    });
  }
}
