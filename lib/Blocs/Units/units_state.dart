part of 'units_cubit.dart';

class UnitsState {
  final UnitsModel? unitsModel;
  final LoadingState loadingState;
  final LoadingState loadMoreState;
  final int page;
  const UnitsState({
    this.unitsModel,
    this.loadingState = LoadingState.none,
    this.loadMoreState = LoadingState.none,
    this.page = 1,
  });
  UnitsState copyWith(
      {final UnitsModel? unitsModel,
      final LoadingState? loadingState,
      final LoadingState? loadMoreState,
      final int? page}) {
    return UnitsState(
      unitsModel: unitsModel ?? this.unitsModel,
      loadingState: loadingState ?? this.loadingState,
      loadMoreState: loadMoreState ?? this.loadMoreState,
      page: page ?? this.page,
    );
  }
}
