import 'dart:io';

import '../../Utils/utils.dart';

part 'edit_compliance_state.dart';

class EditComplianceCubit extends Cubit<EditComplianceState> {
  EditComplianceCubit() : super(EditComplianceState());
  onChangeCustomDateRange(DateTimeRange? dateTimeRange) {
    emit(state.copyWith(customDateRange: dateTimeRange));
  }

  onChangeApplicable(bool? applicable) {
    emit(state.copyWith(applicable: applicable));
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
}
