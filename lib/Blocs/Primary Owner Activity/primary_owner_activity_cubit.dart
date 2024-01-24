import 'package:iskaanowner/Models/primary_owner_activity.dart';

import '../../Utils/utils.dart';

part 'primary_owner_activity_state.dart';

class PrimaryOwnerActivityCubit extends Cubit<PrimaryOwnerActivityState> {
  PrimaryOwnerActivityCubit() : super(const PrimaryOwnerActivityState());
  Future<void> getPrimaryOwnerActivity(
      BuildContext context, int? unitId) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    await UnitsService.getUnitPrimaryOwnerActivity(context, unitId)
        .then((value) {
      if (value is Success) {
        return emit(state.copyWith(
          primaryOwnerActivityModel:
              primaryOwnerActivityModelFromJson(value.response as String),
          loadingState: LoadingState.success,
        ));
      }
      value as Failure;
      Fluttertoast.showToast(
          msg: value.errorResponse as String? ?? "Unable to get results");
      emit(state.copyWith(loadingState: LoadingState.error));
    });
  }
}
