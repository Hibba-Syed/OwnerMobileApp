part of 'dropdown_units_cubit.dart';

class DropdownUnitsState {
    final DropdownUnitModel? unitsModel;
  final LoadingState loadingState;
  const DropdownUnitsState({
    this.unitsModel,
    this.loadingState = LoadingState.none,
  });
  DropdownUnitsState copyWith(
      {final DropdownUnitModel? unitsModel, final LoadingState? loadingState}) {
    return DropdownUnitsState(
        unitsModel: unitsModel ?? this.unitsModel,
        loadingState: loadingState ?? this.loadingState);
  }
}
