part of 'receipts_cubit.dart';

class ReceiptsState {
  final ReceiptsModel? receiptsModel;
  final LoadingState loadingState;
  final LoadingState loadMoreState;
  final DateTimeRange? dateRange;
  final String keyword;
  final int page;
  const ReceiptsState({
    this.receiptsModel,
    this.loadingState = LoadingState.none,
    this.loadMoreState = LoadingState.none,
    this.dateRange,
    this.keyword = "",
    this.page = 1,
  });
  ReceiptsState copyWith({
    final ReceiptsModel? receiptsModel,
    final LoadingState? loadingState,
    final LoadingState? loadMoreState,
    final DateTimeRange? dateRange,
    final String? keyword,
    final int? page,
  }) {
    return ReceiptsState(
      receiptsModel: receiptsModel ?? this.receiptsModel,
      loadingState: loadingState ?? this.loadingState,
      loadMoreState: loadMoreState ?? this.loadMoreState,
      dateRange: dateRange ?? this.dateRange,
      keyword: keyword ?? this.keyword,
      page: page ?? this.page,
    );
  }

  ReceiptsState reset({
    final ReceiptsModel? receiptsModel,
    final LoadingState? loadingState,
    final DateTimeRange? dateRange,
    final String? keyword,
  }) {
    return ReceiptsState(
      receiptsModel: receiptsModel ?? this.receiptsModel,
      loadingState: loadingState ?? this.loadingState,
      dateRange: null,
      page: 1,
      keyword: keyword ?? this.keyword,
    );
  }
}
