
import '../../Utils/utils.dart';

part 'units_state.dart';

class UnitsCubit extends Cubit<UnitsState> {
  UnitsCubit() : super(const UnitsState());

  Future<void> getUnits(BuildContext context, int? id) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    await UnitsService.getUnits(context, id).then((value) {
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
}
