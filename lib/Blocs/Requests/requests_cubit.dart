import 'package:iskaanowner/Models/request_filters.dart';

import '../../Models/requests.dart';
import '../../Utils/utils.dart';

part 'requests_state.dart';

class RequestsCubit extends Cubit<RequestsState> {
  RequestsCubit() : super(const RequestsState());

  void onChangeRequestType(ApplicationType? requestType) {
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
    emit(state.copyWith(loadingState: LoadingState.loading, page: 1));
    await UnitsService.getUnitRequests(
      context,
      id,
      state.keyword,
      state.requestType?.key,
      state.status,
      state.page,
    ).then((value) {
      if (value is Success) {
        return emit(state.copyWith(
          requestsModel: requestsModelFromJson(value.response as String),
          loadingState: LoadingState.success,
        ));
      }
      value as Failure;
      Fluttertoast.showToast(
          msg: value.errorResponse as String? ?? "Unable to get requests");
      emit(state.copyWith(loadingState: LoadingState.error));
    });
  }

  Future<void> getMoreRequests(BuildContext context, int? id) async {
    emit(state.copyWith(
        loadMoreState: LoadingState.loading, page: state.page + 1));
    await UnitsService.getUnitRequests(context, id, state.keyword,
            state.requestType?.key, state.status, state.page)
        .then((value) {
      if (value is Success) {
        if (requestsModelFromJson(value.response as String)
                .applications
                ?.isNotEmpty ??
            false) {
          state.requestsModel?.applications?.addAll(
              requestsModelFromJson(value.response as String).applications ??
                  []);
          return emit(state.copyWith(
            requestsModel: state.requestsModel,
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
          msg: value.errorResponse as String? ?? "Unable to get requests");
      emit(state.copyWith(loadMoreState: LoadingState.error));
    });
  }
}
