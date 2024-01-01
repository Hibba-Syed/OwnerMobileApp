import 'package:iskaanowner/Models/Requests/cs.dart';
import 'package:iskaanowner/Models/Requests/fo.dart';
import 'package:iskaanowner/Models/Requests/mo.dart';
import 'package:iskaanowner/Models/Requests/ri.dart';
import 'package:iskaanowner/Models/Requests/ss.dart';
import 'package:iskaanowner/Models/Requests/tp.dart';

import '../../Models/Requests/ad.dart';
import '../../Models/Requests/dp.dart';
import '../../Models/Requests/hb.dart';
import '../../Models/Requests/mi.dart';
import '../../Models/Requests/wp.dart';
import '../../Utils/utils.dart';

part 'request_details_state.dart';

class RequestDetailsCubit extends Cubit<RequestDetailsState> {
  RequestDetailsCubit() : super(const RequestDetailsState());
  Future<void> getRequestDetails(
      BuildContext context, int? requestId, String? type) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    await UnitsService.getUnitRequestDetails(context, requestId, type)
        .then((value) {
      if (value is Success) {
        if (type?.toLowerCase() == "ad") {
          return emit(state.copyWith(
            adDetailsModel: adDetailsModelFromJson(value.response as String),
            loadingState: LoadingState.success,
          ));
        }
        if (type?.toLowerCase() == "fo") {
          return emit(state.copyWith(
            foDetailsModel: foDetailsModelFromJson(value.response as String),
            loadingState: LoadingState.success,
          ));
        }
        if (type?.toLowerCase() == "ri") {
          return emit(state.copyWith(
            riDetailsModel: riDetailsModelFromJson(value.response as String),
            loadingState: LoadingState.success,
          ));
        }
        if (type?.toLowerCase() == "wp") {
          return emit(state.copyWith(
            wpDetailsModel: wpDetailsModelFromJson(value.response as String),
            loadingState: LoadingState.success,
          ));
        }
        if (type?.toLowerCase() == "ss") {
          return emit(state.copyWith(
            ssDetailsModel: ssDetailsModelFromJson(value.response as String),
            loadingState: LoadingState.success,
          ));
        }
        if (type?.toLowerCase() == "cs") {
          return emit(state.copyWith(
            csDetailsModel: csDetailsModelFromJson(value.response as String),
            loadingState: LoadingState.success,
          ));
        }
        if (type?.toLowerCase() == "hb") {
          return emit(state.copyWith(
            hbDetailsModel: hbDetailsModelFromJson(value.response as String),
            loadingState: LoadingState.success,
          ));
        }
        if (type?.toLowerCase() == "mo") {
          return emit(state.copyWith(
            moDetailsModel: moDetailsModelFromJson(value.response as String),
            loadingState: LoadingState.success,
          ));
        }

        if (type?.toLowerCase() == "dp") {
          return emit(state.copyWith(
            dpDetailsModel: dpDetailsModelFromJson(value.response as String),
            loadingState: LoadingState.success,
          ));
        }
        if (type?.toLowerCase() == "tp") {
          return emit(state.copyWith(
            tpDetailsModel: tpDetailsModelFromJson(value.response as String),
            loadingState: LoadingState.success,
          ));
        }
        if (type?.toLowerCase() == "mi") {
          return emit(state.copyWith(
            miDetailsModel: miDetailsModelFromJson(value.response as String),
            loadingState: LoadingState.success,
          ));
        }
      }
      value as Failure;
      Fluttertoast.showToast(
        msg: value.errorResponse as String? ?? "Unable to get request details",
      );
      emit(state.copyWith(loadingState: LoadingState.error));
    });
  }
}
