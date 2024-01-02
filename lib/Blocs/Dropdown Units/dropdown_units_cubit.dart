import '../../Models/drop_down_unit_model.dart';
import '../../Utils/utils.dart';

part 'dropdown_units_state.dart';

class DropdownUnitsCubit extends Cubit<DropdownUnitsState> {
  DropdownUnitsCubit() : super(const DropdownUnitsState());

  Future<void> getUnits(BuildContext context, int? id) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    await UnitsService.getDropdownUnits(
      context,
      id,
    ).then((value) {
      if (value is Success) {
        return emit(state.copyWith(
          unitsModel: dropdownUnitModelFromJson(value.response as String),
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
