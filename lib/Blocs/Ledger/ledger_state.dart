part of 'ledger_cubit.dart';

class LedgerState {
  final LedgerByStatementModel? ledgerByStatementModel;
  final LedgerByDateModel? ledgerByDateModel;
  final LedgerByAccountModel? ledgerByAccountModel;
  final LoadingState loadingState;
  final IndividualLedger? ledgerType;
  final DateTimeRange? customDateRange;
  const LedgerState({
    this.ledgerByStatementModel,
    this.ledgerByDateModel,
    this.ledgerByAccountModel,
    this.loadingState = LoadingState.none,
    this.ledgerType,
    this.customDateRange,
  });
  LedgerState copyWith({
    final LedgerByStatementModel? ledgerByStatementModel,
    final LedgerByDateModel? ledgerByDateModel,
    final LedgerByAccountModel? ledgerByAccountModel,
    final LoadingState? loadingState,
    final int? year,
    final IndividualLedger? ledgerType,
    final DateTimeRange? customDateRange,
  }) {
    return LedgerState(
      ledgerByStatementModel:
          ledgerByStatementModel ?? this.ledgerByStatementModel,
      ledgerByDateModel: ledgerByDateModel ?? this.ledgerByDateModel,
      ledgerByAccountModel: ledgerByAccountModel ?? this.ledgerByAccountModel,
      loadingState: loadingState ?? this.loadingState,
      ledgerType: ledgerType ?? this.ledgerType,
      customDateRange: customDateRange ?? this.customDateRange,
    );
  }
}
