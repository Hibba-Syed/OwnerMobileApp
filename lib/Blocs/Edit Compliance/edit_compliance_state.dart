part of 'edit_compliance_cubit.dart';

class EditComplianceState {
  final LoadingState loadingState;
  final File? file;
  final bool applicable;
  final DateTimeRange? customDateRange;
  final String? description;
  final String? name;
  EditComplianceState({
    this.loadingState = LoadingState.none,
    this.file,
    this.applicable = false,
    this.customDateRange,
    this.description,
    this.name,
  });
  EditComplianceState copyWith({
    final LoadingState? loadingState,
    final File? file,
    final bool? applicable,
    final DateTimeRange? customDateRange,
    final String? description,
    final String? name,
  }) {
    return EditComplianceState(
      loadingState: loadingState ?? this.loadingState,
      file: file ?? this.file,
      applicable: applicable ?? this.applicable,
      customDateRange: customDateRange ?? this.customDateRange,
      description: description ?? this.description,
      name: name ?? this.name,
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
      applicable: applicable ?? this.applicable,
      customDateRange: customDateRange ?? this.customDateRange,
      description: description ?? this.description,
      name: name ?? this.name,
    );
  }
}
