part of 'units_cubit.dart';

class UnitsState {
  final UnitsModel? unitsModel;
  final LoadingState loadingState;
  const UnitsState({
    this.unitsModel,
    this.loadingState = LoadingState.none,
  });
  UnitsState copyWith(
      {final UnitsModel? unitsModel, final LoadingState? loadingState}) {
    return UnitsState(
        unitsModel: unitsModel ?? this.unitsModel,
        loadingState: loadingState ?? this.loadingState);
  }
}
