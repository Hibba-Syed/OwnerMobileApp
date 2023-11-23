part of 'unit_financials_cubit.dart';

class UnitFinancialsState {
  final UnitFinancialsModel? unitFinancialsModel;
  final LoadingState loadingState;
  const UnitFinancialsState(
      {this.unitFinancialsModel, this.loadingState = LoadingState.none});
  UnitFinancialsState copyWith(
      {final UnitFinancialsModel? unitFinancialsModel,
      final LoadingState? loadingState}) {
    return UnitFinancialsState(
      loadingState: loadingState ?? this.loadingState,
      unitFinancialsModel: unitFinancialsModel ?? this.unitFinancialsModel,
    );
  }
}
