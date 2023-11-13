part of 'credit_notes_cubit.dart';

class CreditNotesState {
  final CreditNotesModel? creditNotesModel;
  final LoadingState loadingState;
  final DateTimeRange? dateRange;
  final String keyword;
  const CreditNotesState({
    this.creditNotesModel,
    this.loadingState = LoadingState.none,
    this.dateRange,
    this.keyword = "",
  });
  CreditNotesState copyWith({
    final CreditNotesModel? creditNotesModel,
    final LoadingState? loadingState,
    final DateTimeRange? dateRange,
    final String? keyword,
  }) {
    return CreditNotesState(
      creditNotesModel: creditNotesModel ?? this.creditNotesModel,
      loadingState: loadingState ?? this.loadingState,
      dateRange: dateRange ?? this.dateRange,
      keyword: keyword ?? this.keyword,
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
      keyword: keyword ?? this.keyword,
    );
  }
}
