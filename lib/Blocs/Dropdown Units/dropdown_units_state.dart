part of 'dropdown_units_cubit.dart';

class DropdownUnitsState {
    final UnitsModel? unitsModel;
  final LoadingState loadingState;
  const DropdownUnitsState({
    this.unitsModel,
    this.loadingState = LoadingState.none,
  });
  DropdownUnitsState copyWith(
      {final UnitsModel? unitsModel, final LoadingState? loadingState}) {
    return DropdownUnitsState(
        unitsModel: unitsModel ?? this.unitsModel,
        loadingState: loadingState ?? this.loadingState);
  }
}
