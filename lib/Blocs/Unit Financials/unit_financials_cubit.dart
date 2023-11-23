import 'package:iskaanowner/Models/unit_financials.dart';

import '../../Utils/utils.dart';

part 'unit_financials_state.dart';

class UnitFinancialsCubit extends Cubit<UnitFinancialsState> {
  UnitFinancialsCubit() : super(const UnitFinancialsState());
  Future<void> getUnitFinancials(BuildContext context) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    await UnitsService.getUnitFinancials(context).then((value) {
      if (value is Success) {
        return emit(state.copyWith(
          unitFinancialsModel:
              unitFinancialsModelFromJson(value.response as String),
          loadingState: LoadingState.success,
        ));
      }
      value as Failure;
      Fluttertoast.showToast(
          msg: value.errorResponse as String? ??
              "Unable to get unit financials");
      emit(state.copyWith(loadingState: LoadingState.error));
    });
  }
}
