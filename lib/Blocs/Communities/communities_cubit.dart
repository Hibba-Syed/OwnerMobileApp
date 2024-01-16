import '../../Utils/utils.dart';

part 'communities_state.dart';

class CommunitiesCubit extends Cubit<CommunitiesState> {
  CommunitiesCubit() : super(const CommunitiesState());

  Future<void> getCommunities(BuildContext context) async {
    emit(state.copyWith(loadingState: LoadingState.loading, page: 1));
    await CommunitiesService.getCommunities(context, state.page).then((value) {
      if (value is Success) {
        return emit(state.copyWith(
          communitiesModel: communitiesModelFromJson(value.response as String),
          loadingState: LoadingState.success,
        ));
      }
      value as Failure;
      Fluttertoast.showToast(
          msg: value.errorResponse as String? ?? "Unable to get communities");
      emit(state.copyWith(loadingState: LoadingState.error));
    });
  }

  Future<void> getMoreCommunities(BuildContext context) async {
    emit(state.copyWith(
        loadMoreState: LoadingState.loading, page: state.page + 1));
    await CommunitiesService.getCommunities(context, state.page).then((value) {
      if (value is Success) {
        if (communitiesModelFromJson(value.response as String)
                .associations
                ?.isNotEmpty ??
            false) {
          state.communitiesModel?.associations?.addAll(
              communitiesModelFromJson(value.response as String).associations ??
                  []);
          return emit(state.copyWith(
            communitiesModel: state.communitiesModel,
            loadMoreState: LoadingState.success,
          ));
        }
        Fluttertoast.showToast(msg: "No further results found");
        return emit(state.copyWith(
          loadMoreState: LoadingState.success,
        ));
      }
      value as Failure;
      Fluttertoast.showToast(
          msg: value.errorResponse as String? ?? "Unable to get compliances");
      emit(state.copyWith(loadMoreState: LoadingState.error));
    });
  }
}
