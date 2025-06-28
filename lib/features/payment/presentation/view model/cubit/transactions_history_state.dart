part of 'transactions_history_cubit.dart';

sealed class TransactionsHistoryState extends Equatable {
  const TransactionsHistoryState();

  @override
  List<Object> get props => [];
}

final class TransactionsHistoryInitial extends TransactionsHistoryState {}
