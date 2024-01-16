part of 'communities_cubit.dart';

class CommunitiesState {
  final CommunitiesModel? communitiesModel;
  final LoadingState loadingState;
  final LoadingState loadMoreState;
  final int page;
  const CommunitiesState({
    this.communitiesModel,
    this.loadingState = LoadingState.none,
    this.loadMoreState = LoadingState.none,
    this.page = 1,
  });
  CommunitiesState copyWith(
      {final CommunitiesModel? communitiesModel,
      final LoadingState? loadingState,
      final LoadingState? loadMoreState,
      final int? page}) {
    return CommunitiesState(
      communitiesModel: communitiesModel ?? this.communitiesModel,
      loadingState: loadingState ?? this.loadingState,
      loadMoreState: loadMoreState ?? this.loadMoreState,
      page: page ?? this.page,
    );
  }
}
