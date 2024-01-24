part of 'primary_owner_activity_cubit.dart';

class PrimaryOwnerActivityState {
  final PrimaryOwnerActivityModel? primaryOwnerActivityModel;
  final LoadingState loadingState;
  const PrimaryOwnerActivityState({
    this.primaryOwnerActivityModel,
    this.loadingState = LoadingState.none,
  });
  PrimaryOwnerActivityState copyWith({
    final PrimaryOwnerActivityModel? primaryOwnerActivityModel,
    final LoadingState? loadingState,
  }) {
    return PrimaryOwnerActivityState(
        primaryOwnerActivityModel:
            primaryOwnerActivityModel ?? this.primaryOwnerActivityModel,
        loadingState: loadingState ?? this.loadingState);
  }
}
