import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taht_bety_provider/features/payment/data/model/dashboard_model/dashboard_model.dart';
import 'package:taht_bety_provider/features/payment/data/repo/dashboard_repo.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit(this.dashboardRepo) : super(DashboardInitial());
  final DashboardRepo dashboardRepo;

  Future<void> fetchDashboardData(bool hasDashboard) async {
    emit(DashboardLoading());
    try {
      final result = await dashboardRepo.fetchDashboardData(hasDashboard);
      result.fold(
        (failure) => emit(DashboardFailure(failure.failurMsg)),
        (data) => emit(DashboardSuccess(data)),
      );
    } catch (e) {
      emit(DashboardFailure(e.toString()));
    }
  }
}
