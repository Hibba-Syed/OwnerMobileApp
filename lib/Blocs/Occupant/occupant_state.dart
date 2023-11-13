part of 'occupant_cubit.dart';

class OccupantState {
  final OccupantModel? occupantModel;
  final LoadingState loadingState;
  const OccupantState({
    this.occupantModel,
    this.loadingState = LoadingState.none,
  });
  OccupantState copyWith({
    final OccupantModel? occupantModel,
    final LoadingState? loadingState,
  }) {
    return OccupantState(
        occupantModel: occupantModel ?? this.occupantModel,
        loadingState: loadingState ?? this.loadingState);
  }
}
