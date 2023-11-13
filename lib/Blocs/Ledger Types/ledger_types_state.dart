part of 'ledger_types_cubit.dart';

class LedgerTypesState {
  final LedgerTypesModel? ledgerTypesModel;
  final LoadingState loadingState;
  const LedgerTypesState({
    this.ledgerTypesModel,
    this.loadingState = LoadingState.none,
  });
  LedgerTypesState copyWith({
    final LedgerTypesModel? ledgerTypesModel,
    final LoadingState? loadingState,
  }) {
    return LedgerTypesState(
      ledgerTypesModel: ledgerTypesModel ?? ledgerTypesModel,
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
