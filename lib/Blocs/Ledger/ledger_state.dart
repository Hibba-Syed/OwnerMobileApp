part of 'ledger_cubit.dart';

class LedgerState {
  final LedgerByStatementModel? ledgerByStatementModel;
  final LedgerByDateModel? ledgerByDateModel;
  final LedgerByAccountModel? ledgerByAccountModel;
  final LoadingState ledgerByStatementLoadingState;
  final LoadingState ledgerByDateLoadingState;
  final LoadingState ledgerByAccountLoadingState;
  final LoadingState loadMoreLedgerByStatementState;
  final LoadingState loadMoreLedgerByDateState;
  final LoadingState loadMoreLedgerByAccountState;
  final IndividualLedger? ledgerType;
  final DateTimeRange? customDateRange;
  final String ledgerName;
  final int pageLedgerByStatement;
  final int pageLedgerByDate;
  final int pageLedgerByAccount;
  const LedgerState({
    this.ledgerByStatementModel,
    this.ledgerByDateModel,
    this.ledgerByAccountModel,
    this.ledgerByStatementLoadingState = LoadingState.none,
    this.ledgerByDateLoadingState = LoadingState.none,
    this.ledgerByAccountLoadingState = LoadingState.none,
    this.loadMoreLedgerByDateState = LoadingState.none,
    this.loadMoreLedgerByStatementState = LoadingState.none,
    this.loadMoreLedgerByAccountState = LoadingState.none,
    this.ledgerType,
    this.ledgerName = "statement",
    this.customDateRange,
    this.pageLedgerByStatement = 1,
    this.pageLedgerByDate = 1,
    this.pageLedgerByAccount = 1,
  });
  LedgerState copyWith({
    final LedgerByStatementModel? ledgerByStatementModel,
    final LedgerByDateModel? ledgerByDateModel,
    final LedgerByAccountModel? ledgerByAccountModel,
    final LoadingState? ledgerByStatementLoadingState,
    final LoadingState? ledgerByDateLoadingState,
    final LoadingState? ledgerByAccountLoadingState,
    final LoadingState? loadMoreLedgerByStatementState,
    final LoadingState? loadMoreLedgerByDateState,
    final LoadingState? loadMoreLedgerByAccountState,
    final int? year,
    final IndividualLedger? ledgerType,
    final DateTimeRange? customDateRange,
    final String? ledgerName,
    final int? pageLedgerByStatement,
    final int? pageLedgerByDate,
    final int? pageLedgerByAccount,
  }) {
    return LedgerState(
      ledgerByStatementModel:
          ledgerByStatementModel ?? this.ledgerByStatementModel,
      ledgerByDateModel: ledgerByDateModel ?? this.ledgerByDateModel,
      ledgerByAccountModel: ledgerByAccountModel ?? this.ledgerByAccountModel,
      ledgerByStatementLoadingState:
          ledgerByStatementLoadingState ?? this.ledgerByStatementLoadingState,
      ledgerByDateLoadingState:
          ledgerByDateLoadingState ?? this.ledgerByDateLoadingState,
      ledgerByAccountLoadingState:
          ledgerByAccountLoadingState ?? this.ledgerByAccountLoadingState,
      loadMoreLedgerByStatementState:
          loadMoreLedgerByStatementState ?? this.loadMoreLedgerByStatementState,
      loadMoreLedgerByDateState:
          loadMoreLedgerByDateState ?? this.loadMoreLedgerByDateState,
      loadMoreLedgerByAccountState:
          loadMoreLedgerByAccountState ?? this.loadMoreLedgerByAccountState,
      ledgerType: ledgerType ?? this.ledgerType,
      customDateRange: customDateRange ?? this.customDateRange,
      ledgerName: ledgerName ?? this.ledgerName,
      pageLedgerByStatement:
          pageLedgerByStatement ?? this.pageLedgerByStatement,
      pageLedgerByDate: pageLedgerByDate ?? this.pageLedgerByDate,
      pageLedgerByAccount: pageLedgerByAccount ?? this.pageLedgerByAccount,
    );
  }
}
