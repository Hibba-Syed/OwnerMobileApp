import '../../Models/requests.dart';
import '../../Utils/utils.dart';

part 'requests_state.dart';

class RequestsCubit extends Cubit<RequestsState> {
  RequestsCubit() : super(const RequestsState());

  void onChangeRequestType(String? requestType) {
    emit(state.copyWith(requestType: requestType));
  }

  void onChangeStatus(String? status) {
    emit(state.copyWith(status: status));
  }

  void onChangeKeyword(String? keyword) {
    emit(state.copyWith(keyword: keyword));
  }

  void resetFilters() {
    emit(state.reset());
  }

  Future<void> getRequests(BuildContext context, int? id) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    await UnitsService.getUnitRequests(
            context, id, state.keyword, state.requestType, state.status)
        .then((value) {
      if (value is Success) {
        return emit(state.copyWith(
          requestsModel: requestsModelFromJson(value.response as String),
          loadingState: LoadingState.success,
        ));
      }
      value as Failure;
      Fluttertoast.showToast(
          msg: value.errorResponse as String? ?? "Unable to get owners");
      emit(state.copyWith(loadingState: LoadingState.error));
    });
  }
}
