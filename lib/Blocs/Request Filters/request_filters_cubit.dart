import 'package:iskaanowner/Models/request_filters.dart';

import '../../Utils/utils.dart';

part 'request_filters_state.dart';

class RequestsFiltersCubit extends Cubit<RequestsFiltersState> {
  RequestsFiltersCubit() : super(const RequestsFiltersState());
  Future<void> getRequestsFilters(BuildContext context) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    await UnitsService.getUnitRequestsFilters(context).then((value) {
      if (value is Success) {
        return emit(state.copyWith(
          requestsFiltersModel:
              requestsFiltersModelFromJson(value.response as String),
          loadingState: LoadingState.success,
        ));
      }
      value as Failure;
      Fluttertoast.showToast(
          msg: value.errorResponse as String? ?? "Unable to get compliances");
      emit(state.copyWith(loadingState: LoadingState.error));
    });
  }
}
