part of 'credit_notes_cubit.dart';

class CreditNotesState {
  final CreditNotesModel? creditNotesModel;
  final LoadingState loadingState;
  final LoadingState loadMoreState;
  final DateTimeRange? dateRange;
  final String keyword;
  final int page;
  const CreditNotesState({
    this.creditNotesModel,
    this.loadingState = LoadingState.none,
    this.loadMoreState = LoadingState.none,
    this.dateRange,
    this.keyword = "",
    this.page = 1,
  });
  CreditNotesState copyWith({
    final CreditNotesModel? creditNotesModel,
    final LoadingState? loadingState,
    final LoadingState? loadMoreState,
    final DateTimeRange? dateRange,
    final String? keyword,
    final int? page,
  }) {
    return CreditNotesState(
      creditNotesModel: creditNotesModel ?? this.creditNotesModel,
      loadingState: loadingState ?? this.loadingState,
      loadMoreState: loadMoreState ?? this.loadMoreState,
      dateRange: dateRange ?? this.dateRange,
      keyword: keyword ?? this.keyword,
      page: page ?? this.page,
    );
  }

  CreditNotesState reset({
    final CreditNotesModel? creditNotesModel,
    final LoadingState? loadingState,
    final DateTimeRange? dateRange,
    final String? keyword,
  }) {
    return CreditNotesState(
      creditNotesModel: creditNotesModel ?? this.creditNotesModel,
      loadingState: loadingState ?? this.loadingState,
      dateRange: null,
      page: 1,
      keyword: keyword ?? this.keyword,
    );
  }
}
