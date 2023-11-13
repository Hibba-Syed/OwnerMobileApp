import '../../Utils/utils.dart';

part 'comunities_state.dart';

class CommunitiesCubit extends Cubit<CommunitiesState> {
  CommunitiesCubit() : super(const CommunitiesState());

  Future<void> getCommunities(BuildContext context) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    await CommunitiesService.getCommunities(context).then((value) {
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
