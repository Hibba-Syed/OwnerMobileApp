import '../../Utils/utils.dart';

part 'dropdown_communities_state.dart';

class DropdownCommunitiesCubit extends Cubit<DropdownCommunitiesState> {
  DropdownCommunitiesCubit() : super(const DropdownCommunitiesState());

  Future<void> getCommunities(BuildContext context) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    await CommunitiesService.getCommunities(context, 1, limit: 5000)
        .then((value) {
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
}
