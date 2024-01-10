part of 'compliance_details_cubit.dart';

class ComplianceDetailsState {
  final ComplianceDetailsModel? complianceDetailsModel;
  final LoadingState loadingState;
  const ComplianceDetailsState({
    this.complianceDetailsModel,
    this.loadingState = LoadingState.none,
  });
  ComplianceDetailsState copyWith({
    final ComplianceDetailsModel? complianceDetailsModel,
    final LoadingState? loadingState,
  }) {
    return ComplianceDetailsState(
        complianceDetailsModel:
            complianceDetailsModel ?? this.complianceDetailsModel,
        loadingState: loadingState ?? this.loadingState);
  }
}
