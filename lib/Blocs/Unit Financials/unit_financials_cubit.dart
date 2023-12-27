import 'package:iskaanowner/Models/unit_financials.dart';

import '../../Utils/utils.dart';

part 'unit_financials_state.dart';

class UnitFinancialsCubit extends Cubit<UnitFinancialsState> {
  UnitFinancialsCubit() : super(const UnitFinancialsState(selectedUnits: []));

  onChangeSelectedUnits(List<dynamic>? selectedUnits) {
    return emit(state.copyWith(selectedUnits: selectedUnits));
  }

  Future<void> getUnitFinancials(BuildContext context) async {
    emit(state.copyWith(loadingState: LoadingState.loading, page: 1));
    await UnitsService.getUnitFinancials(context, state.page).then((value) {
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

  Future<void> getMoreUnitFinancials(BuildContext context) async {
    emit(state.copyWith(
        loadMoreState: LoadingState.loading, page: state.page + 1));
    await UnitsService.getUnitFinancials(context, state.page).then((value) {
      if (value is Success) {
        if (unitFinancialsModelFromJson(value.response as String)
                .unitSummaries
                ?.isNotEmpty ??
            false) {
          state.unitFinancialsModel?.unitSummaries?.addAll(
              unitFinancialsModelFromJson(value.response as String).unitSummaries ??
                  []);
          return emit(state.copyWith(
            unitFinancialsModel: state.unitFinancialsModel,
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
