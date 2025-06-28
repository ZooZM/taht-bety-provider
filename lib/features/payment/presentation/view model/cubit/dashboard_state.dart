part of 'dashboard_cubit.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

final class DashboardInitial extends DashboardState {}

final class DashboardLoading extends DashboardState {}

final class DashboardSuccess extends DashboardState {
  final DashboardModel dashboardModel;

  const DashboardSuccess(this.dashboardModel);

  @override
  List<Object> get props => [dashboardModel];
}

final class DashboardFailure extends DashboardState {
  final String error;

  const DashboardFailure(this.error);

  @override
  List<Object> get props => [error];
}
