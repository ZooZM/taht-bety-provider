import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taht_bety_provider/features/home/data/models/provider_model/provider_model.dart';
import 'package:taht_bety_provider/features/home/data/repos/provider_profile_repo.dart';

part 'update_provider_state_state.dart';

class UpdateProviderStateCubit extends Cubit<UpdateProviderStateState> {
  UpdateProviderStateCubit(this.providerProfileRepo)
      : super(UpdateProviderStateInitial());
  ProviderProfileRepo providerProfileRepo;

  Future<void> updateProviderState(bool isOnline, String providerId) async {
    emit(UpdateProviderStateLoading());
    var result =
        await providerProfileRepo.updateProviderState(isOnline, providerId);
    result.fold((failure) {
      emit(UpdateProviderStateFailure(failure.failurMsg));
    }, (data) {
      emit(UpdateProviderStateSuccess(data));
    });
  }
}
