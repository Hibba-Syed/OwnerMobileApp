import 'package:iskaanowner/Models/compliance_details.dart';

import '../../Utils/utils.dart';

part 'compliance_details_state.dart';

class ComplianceDetailsCubit extends Cubit<ComplianceDetailsState> {
  ComplianceDetailsCubit() : super(const ComplianceDetailsState());
  Future<void> getUnitComplianceDetails(
    BuildContext context,
    int? id,
    int? unitId,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    await UnitsService.getUnitComplianceDetails(context, id, unitId)
        .then((value) {
      if (value is Success) {
        return emit(state.copyWith(
          complianceDetailsModel:
              complianceDetailsModelFromJson(value.response as String),
          loadingState: LoadingState.success,
        ));
      }
      value as Failure;
      Fluttertoast.showToast(
          msg: value.errorResponse as String? ?? "Unable to get details");
      emit(state.copyWith(loadingState: LoadingState.error));
    });
  }
}
