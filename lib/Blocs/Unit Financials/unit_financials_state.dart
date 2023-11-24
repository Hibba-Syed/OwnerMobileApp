part of 'unit_financials_cubit.dart';

class UnitFinancialsState {
  final List selectedUnits;
  final UnitFinancialsModel? unitFinancialsModel;
  final LoadingState loadingState;
  const UnitFinancialsState(
      {this.unitFinancialsModel,
      this.loadingState = LoadingState.none,
      required this.selectedUnits});
  UnitFinancialsState copyWith(
      {final UnitFinancialsModel? unitFinancialsModel,
      final LoadingState? loadingState,
      final List? selectedUnits}) {
    return UnitFinancialsState(
      loadingState: loadingState ?? this.loadingState,
      unitFinancialsModel: unitFinancialsModel ?? this.unitFinancialsModel,
      selectedUnits: selectedUnits ?? this.selectedUnits,
    );
  }
}
