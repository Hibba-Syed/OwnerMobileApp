part of 'compliances_cubit.dart';

class CompliancesState {
  final CompliancesModel? compliancesModel;
  final LoadingState loadingState;
  final LoadingState loadMoreState;
  final String keyword;
  final int page;
  const CompliancesState({
    this.compliancesModel,
    this.loadingState = LoadingState.none,
    this.loadMoreState = LoadingState.none,
    this.keyword = "",
    this.page = 1,
  });
  CompliancesState copyWith({
    final CompliancesModel? compliancesModel,
    final LoadingState? loadingState,
    final LoadingState? loadMoreState,
    final String? keyword,
    final int? page,
  }) {
    return CompliancesState(
      compliancesModel: compliancesModel ?? this.compliancesModel,
      loadingState: loadingState ?? this.loadingState,
      loadMoreState: loadMoreState ?? this.loadMoreState,
      keyword: keyword ?? this.keyword,
      page: page ?? this.page,
    );
  }
}
