part of 'comunities_cubit.dart';

class CommunitiesState {
  final CommunitiesModel? communitiesModel;
  final LoadingState loadingState;
  const CommunitiesState({
    this.communitiesModel,
    this.loadingState = LoadingState.none,
  });
  CommunitiesState copyWith(
      {final CommunitiesModel? communitiesModel,
      final LoadingState? loadingState}) {
    return CommunitiesState(
        communitiesModel: communitiesModel ?? this.communitiesModel,
        loadingState: loadingState ?? this.loadingState);
  }
}
