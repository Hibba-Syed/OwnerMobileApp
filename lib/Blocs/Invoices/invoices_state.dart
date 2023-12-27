part of 'invoices_cubit.dart';

class InvoicesState {
  final InvoicesModel? invoicesModel;
  final LoadingState loadingState;
  final LoadingState loadMoreState;
  final DateTimeRange? invoiceDateRange;
  final DateTimeRange? dueDateRange;
  final String keyword;
  final int page;
  const InvoicesState({
    this.invoicesModel,
    this.loadingState = LoadingState.none,
    this.loadMoreState = LoadingState.none,
    this.invoiceDateRange,
    this.dueDateRange,
    this.keyword = "",
    this.page = 1,
  });
  InvoicesState copyWith({
    final InvoicesModel? invoicesModel,
    final LoadingState? loadingState,
    final LoadingState? loadMoreState,
    final DateTimeRange? invoiceDateRange,
    final DateTimeRange? dueDateRange,
    final String? keyword,
    final int? page,
  }) {
    return InvoicesState(
      invoicesModel: invoicesModel ?? this.invoicesModel,
      loadingState: loadingState ?? this.loadingState,
      loadMoreState: loadMoreState ?? this.loadMoreState,
      invoiceDateRange: invoiceDateRange ?? this.invoiceDateRange,
      dueDateRange: dueDateRange ?? this.dueDateRange,
      keyword: keyword ?? this.keyword,
      page: page ?? this.page,
    );
  }

  InvoicesState reset({
    final InvoicesModel? invoicesModel,
    final LoadingState? loadingState,
    final DateTimeRange? invoiceDateRange,
    final DateTimeRange? dueDateRange,
    final String? keyword,
  }) {
    return InvoicesState(
      invoicesModel: invoicesModel ?? this.invoicesModel,
      loadingState: loadingState ?? this.loadingState,
      invoiceDateRange: null,
      dueDateRange: null,
      keyword: keyword ?? this.keyword,
    );
  }
}
