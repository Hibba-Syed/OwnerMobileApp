part of 'receipts_cubit.dart';

class ReceiptsState {
  final ReceiptsModel? receiptsModel;
  final LoadingState loadingState;
  final DateTimeRange? dateRange;
  final String keyword;
  const ReceiptsState({
    this.receiptsModel,
    this.loadingState = LoadingState.none,
    this.dateRange,
    this.keyword = "",
  });
  ReceiptsState copyWith({
    final ReceiptsModel? receiptsModel,
    final LoadingState? loadingState,
    final DateTimeRange? dateRange,
    final String? keyword,
  }) {
    return ReceiptsState(
      receiptsModel: receiptsModel ?? this.receiptsModel,
      loadingState: loadingState ?? this.loadingState,
      dateRange: dateRange ?? this.dateRange,
      keyword: keyword ?? this.keyword,
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
      keyword: keyword ?? this.keyword,
    );
  }
}
