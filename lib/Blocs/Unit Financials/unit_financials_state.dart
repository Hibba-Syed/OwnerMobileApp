part of 'unit_financials_cubit.dart';

class UnitFinancialsState {
  final List selectedUnits;
  final UnitFinancialsModel? unitFinancialsModel;
  final LoadingState loadingState;
  final LoadingState loadMoreState;
  final int page;
  const UnitFinancialsState(
      {this.unitFinancialsModel,
      this.loadingState = LoadingState.none,
      this.loadMoreState = LoadingState.none,
      this.page = 1,
      required this.selectedUnits});
  UnitFinancialsState copyWith(
      {final UnitFinancialsModel? unitFinancialsModel,
      final LoadingState? loadingState,
      final List? selectedUnits,
      final LoadingState? loadMoreState,
      final int? page}) {
    return UnitFinancialsState(
      loadingState: loadingState ?? this.loadingState,
      unitFinancialsModel: unitFinancialsModel ?? this.unitFinancialsModel,
      selectedUnits: selectedUnits ?? this.selectedUnits,
      loadMoreState: loadMoreState ?? this.loadMoreState,
      page: page ?? this.page,
    );
  }
}
