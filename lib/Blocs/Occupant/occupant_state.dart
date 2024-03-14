part of 'occupant_cubit.dart';

class OccupantState {
  final OccupantModel? occupantModel;
  final ShortStayOccupantModel? shortStayOccupantModel;
  final LoadingState loadingState;
  const OccupantState({
    this.occupantModel,
    this.shortStayOccupantModel,
    this.loadingState = LoadingState.none,
  });
  OccupantState copyWith({
    final OccupantModel? occupantModel,
    final ShortStayOccupantModel? shortStayOccupantModel,
    final LoadingState? loadingState,
  }) {
    return OccupantState(
        occupantModel: occupantModel ?? this.occupantModel,
        shortStayOccupantModel:
            shortStayOccupantModel ?? this.shortStayOccupantModel,
        loadingState: loadingState ?? this.loadingState);
  }
}
