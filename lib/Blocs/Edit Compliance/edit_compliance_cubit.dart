import 'dart:io';

import 'package:iskaanowner/Models/compliance/update_compliance_response_model.dart';

import '../../Utils/utils.dart';

part 'edit_compliance_state.dart';

class EditComplianceCubit extends Cubit<EditComplianceState> {
  EditComplianceCubit() : super(EditComplianceState());
  onChangeCustomDateRange(DateTimeRange? dateTimeRange) {
    emit(state.copyWith(customDateRange: dateTimeRange));
  }

  onChangeNotApplicable(bool? notApplicable) {
    emit(state.copyWith(notApplicable: notApplicable));
  }

  onChangeFile(File? file) {
    emit(state.copyWith(file: file));
  }

  onChangeDescription(String? description) {
    emit(state.copyWith(description: description));
  }

  onChangeName(String? name) {
    emit(state.copyWith(name: name));
  }

  removeFile() {
    emit(state.removeFile());
  }

  setCertificateUrl(String url) {
    emit(state.copyWith(certificateUrl: url));
  }

  Future<void> updateCompliance(
    BuildContext context, {
    required int id,
    required int complianceAbleId,
  }) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    await UnitsService.updateUnitCompliance(
      context,
      id: id,
      notApplicable: state.notApplicable,
      certificateName: state.name ?? '',
      date: state.customDateRange?.start.toString() ?? '',
      expiry: state.customDateRange?.end.toString() ?? '',
      complianceAbleId: complianceAbleId,
      description: state.description ?? '',
      filePath: state.file?.path,
    ).then((value) {
      if (value is Success) {
        emit(
          state.copyWith(
            loadingState: LoadingState.success,
          ),
        );
     
        UpdateComplianceResponseModel responseModel =
            updateComplianceResponseModelFromJson(value.response as String);
        Fluttertoast.showToast(msg: "Updated successfully");
        Navigator.pop(
          context,
          {
            'success': true,
            'compliance': responseModel.compliance,
          },
        );
        return;
      }
      value as Failure;
      Fluttertoast.showToast(
          msg: value.errorResponse as String? ?? "Unable to update compliance");
      emit(state.copyWith(loadingState: LoadingState.error));
    });
  }
}
