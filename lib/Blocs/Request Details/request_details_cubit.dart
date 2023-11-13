import 'package:iskaanowner/Models/request_details.dart';

import '../../Utils/utils.dart';

part 'request_details_state.dart';

class RequestDetailsCubit extends Cubit<RequestDetailsState> {
  RequestDetailsCubit() : super(const RequestDetailsState());
  Future<void> getRequestDetails(BuildContext context, int? requestId) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    await UnitsService.getUnitRequestDetails(context, requestId).then((value) {
      if (value is Success) {
        return emit(state.copyWith(
          requestDetailsModel:
              requestDetailsModelFromJson(value.response as String),
          loadingState: LoadingState.success,
        ));
      }
      value as Failure;
      Fluttertoast.showToast(
        msg: value.errorResponse as String? ?? "Unable to get request details",
      );
      emit(state.copyWith(loadingState: LoadingState.error));
    });
  }
}
