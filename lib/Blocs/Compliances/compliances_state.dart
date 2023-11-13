part of 'compliances_cubit.dart';

class CompliancesState {
  final CompliancesModel? compliancesModel;
  final LoadingState loadingState;
  final String keyword;
  const CompliancesState({
    this.compliancesModel,
    this.loadingState = LoadingState.none,
    this.keyword = "",
  });
  CompliancesState copyWith({
    final CompliancesModel? compliancesModel,
    final LoadingState? loadingState,
    final String? keyword,
  }) {
    return CompliancesState(
      compliancesModel: compliancesModel ?? this.compliancesModel,
      loadingState: loadingState ?? this.loadingState,
      keyword: keyword ?? this.keyword,
    );
  }
}
