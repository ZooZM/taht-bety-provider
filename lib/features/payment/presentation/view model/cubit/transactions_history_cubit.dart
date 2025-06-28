import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taht_bety_provider/features/payment/data/repo/dashboard_repo.dart';

part 'transactions_history_state.dart';

class TransactionsHistoryCubit extends Cubit<TransactionsHistoryState> {
  TransactionsHistoryCubit(this.dashboardRepo)
      : super(TransactionsHistoryInitial());
  final DashboardRepo dashboardRepo;
}
