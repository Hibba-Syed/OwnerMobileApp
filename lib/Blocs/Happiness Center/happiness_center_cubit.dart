import 'dart:io';

import 'package:iskaanowner/Repo/happiness_center_service.dart';

import '../../Utils/utils.dart';

part 'happiness_center_state.dart';

class HappinessCenterCubit extends Cubit<HappinessCenterState> {
  HappinessCenterCubit() : super(const HappinessCenterState(fileList: []));
  onChangeRadioValue(String? radioValue) {
    emit(state.copyWith(radioValue: radioValue));
  }

  onChangeEmail(String? email) {
    emit(state.copyWith(email: email));
  }

  onChangeFiles(List<File>? fileList) {
    if (state.fileList?.isEmpty ?? true) {
      return emit(state.copyWith(fileList: fileList));
    }
    if (((state.fileList?.length ?? 0) + (fileList?.length ?? 0)) > 3) {
      return Fluttertoast.showToast(
          msg:
              "You only select ${(3 - (state.fileList?.length ?? 0))} more file");
    }
    state.fileList?.addAll(fileList ?? []);
    emit(state.copyWith(fileList: state.fileList));
  }

  removeFile(File file) {
    state.fileList?.remove(file);
    emit(state.copyWith(fileList: state.fileList));
  }

  onChangeMessage(String? message) {
    emit(state.copyWith(message: message));
  }

  onChangeService(String? service) {
    emit(state.copyWith(service: service));
  }

  onChangeComplaintType(String? complaintType) {
    emit(state.copyWith(complaintType: complaintType));
  }

  onChangeCommunityId(int? communityId) {
    emit(state.copyWith(communityId: communityId));
  }

  onChangeVerifiedUser(bool? verifiedUser) {
    emit(state.copyWith(verifiedUser: verifiedUser));
  }

  onChangeUnitId(int? unitId) {
    emit(state.copyWith(unitId: unitId));
  }

  Future<void> submitQuery(BuildContext context) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    await HappinessCenterService.submitQuery(
      context,
      state.fileList ?? [],
      state.complaintType ?? "",
      state.communityId.toString(),
      state.radioValue,
      state.unitId.toString(),
      state.service ?? "",
      state.message ?? "",
    ).then((value) {
      if (value is Success) {
        emit(state.copyWith(
          loadingState: LoadingState.success,
        ));
        Navigator.pop(context);
        return Fluttertoast.showToast(msg: "Query submitted successfully.");
      }
      value as Failure;
      Fluttertoast.showToast(
          msg: value.errorResponse as String? ?? "Unable to change password");
      emit(state.copyWith(loadingState: LoadingState.error));
    });
  }
}
