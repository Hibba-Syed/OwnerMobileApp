part of 'owners_cubit.dart';

class OwnersState {
  final OwnersModel? ownersModel;
  final LoadingState loadingState;
  const OwnersState({
    this.ownersModel,
    this.loadingState = LoadingState.none,
  });
  OwnersState copyWith({
    final OwnersModel? ownersModel,
    final LoadingState? loadingState,
  }) {
    return OwnersState(
        ownersModel: ownersModel ?? this.ownersModel,
        loadingState: loadingState ?? this.loadingState);
  }
}
