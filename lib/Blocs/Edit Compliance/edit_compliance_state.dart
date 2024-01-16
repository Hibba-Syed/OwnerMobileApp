part of 'edit_compliance_cubit.dart';

class EditComplianceState {
  final LoadingState loadingState;
  final File? file;
  final bool notApplicable;
  final DateTimeRange? customDateRange;
  final String? description;
  final String? name;
  final String? certificateUrl;
  EditComplianceState({
    this.loadingState = LoadingState.none,
    this.file,
    this.notApplicable = false,
    this.customDateRange,
    this.description,
    this.name,
    this.certificateUrl,
  });
  EditComplianceState copyWith({
    final LoadingState? loadingState,
    final File? file,
    final bool? applicable,
    final DateTimeRange? customDateRange,
    final String? description,
    final String? name,
    final String? certificateUrl,
  }) {
    return EditComplianceState(
      loadingState: loadingState ?? this.loadingState,
      file: file ?? this.file,
      notApplicable: applicable ?? this.notApplicable,
      customDateRange: customDateRange ?? this.customDateRange,
      description: description ?? this.description,
      name: name ?? this.name,
      certificateUrl: certificateUrl?? this.certificateUrl,
    );
  }
  EditComplianceState removeFile({
    final LoadingState? loadingState,
    final File? file,
    final bool? applicable,
    final DateTimeRange? customDateRange,
    final String? description,
    final String? name,
  }) {
    return EditComplianceState(
      loadingState: loadingState ?? this.loadingState,
      file: file,
      notApplicable: applicable ?? this.notApplicable,
      customDateRange: customDateRange ?? this.customDateRange,
      description: description ?? this.description,
      name: name ?? this.name,
    );
  }
}
