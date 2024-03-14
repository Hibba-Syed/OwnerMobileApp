import 'package:iskaanowner/Models/short_stay_occupant.dart';

import '../../Utils/utils.dart';

part 'occupant_state.dart';

class OccupantCubit extends Cubit<OccupantState> {
  OccupantCubit() : super(const OccupantState());

  Future<void> getOccupant(BuildContext context, int? id) async {
    emit(state.copyWith(
        loadingState: LoadingState.loading, occupantModel: null));
    await UnitsService.getUnitOccupant(context, id).then((value) {
      if (value is Success) {
        return emit(state.copyWith(
          occupantModel: occupantModelFromJson(value.response as String),
          loadingState: LoadingState.success,
        ));
      }
      value as Failure;
      Fluttertoast.showToast(
          msg: value.errorResponse as String? ?? "Unable to get occupant");
      emit(state.copyWith(loadingState: LoadingState.error));
    });
  }

  Future<void> getShortStayOccupant(BuildContext context, int? id) async {
    emit(state.copyWith(
        loadingState: LoadingState.loading, shortStayOccupantModel: null));
    await UnitsService.getUnitShortStayOccupant(context, id).then((value) {
      if (value is Success) {
        return emit(state.copyWith(
          shortStayOccupantModel:
              shortStayOccupantModelFromJson(value.response as String),
          loadingState: LoadingState.success,
        ));
      }
      value as Failure;
      Fluttertoast.showToast(
          msg: value.errorResponse as String? ?? "Unable to get occupant");
      emit(state.copyWith(loadingState: LoadingState.error));
    });
  }
}
