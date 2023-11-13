part of 'dropdown_communities_cubit.dart';

class DropdownCommunitiesState {
  final CommunitiesModel? communitiesModel;
  final LoadingState loadingState;
  const DropdownCommunitiesState({
    this.communitiesModel,
    this.loadingState = LoadingState.none,
  });
  DropdownCommunitiesState copyWith(
      {final CommunitiesModel? communitiesModel,
      final LoadingState? loadingState}) {
    return DropdownCommunitiesState(
        communitiesModel: communitiesModel ?? this.communitiesModel,
        loadingState: loadingState ?? this.loadingState);
  }
}
