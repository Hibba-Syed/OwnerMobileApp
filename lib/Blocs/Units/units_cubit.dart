import '../../Utils/utils.dart';

part 'units_state.dart';

class UnitsCubit extends Cubit<UnitsState> {
  UnitsCubit() : super(const UnitsState());

  Future<void> getUnits(BuildContext context, int? id) async {
    emit(state.copyWith(loadingState: LoadingState.loading, page: 1));
    await UnitsService.getUnits(context, id, state.page).then((value) {
      if (value is Success) {
        return emit(state.copyWith(
          unitsModel: unitsModelFromJson(value.response as String),
          loadingState: LoadingState.success,
        ));
      }
      value as Failure;
      Fluttertoast.showToast(
          msg: value.errorResponse as String? ?? "Unable to get units");
      emit(state.copyWith(loadingState: LoadingState.error));
    });
  }

  Future<void> getMoreUnits(BuildContext context, int? id) async {
    emit(state.copyWith(
        loadMoreState: LoadingState.loading, page: state.page + 1));
    await UnitsService.getUnits(context, id, state.page).then((value) {
      if (value is Success) {
        if (unitsModelFromJson(value.response as String).units?.isNotEmpty ??
            false) {
          state.unitsModel?.units?.addAll(
              unitsModelFromJson(value.response as String).units ?? []);
          return emit(state.copyWith(
            unitsModel: state.unitsModel,
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
          msg: value.errorResponse as String? ?? "Unable to get units");
      emit(state.copyWith(loadMoreState: LoadingState.error));
    });
  }
}
