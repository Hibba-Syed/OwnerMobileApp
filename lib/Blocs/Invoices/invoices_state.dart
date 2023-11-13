part of 'invoices_cubit.dart';

class InvoicesState {
  final InvoicesModel? invoicesModel;
  final LoadingState loadingState;
  final DateTimeRange? invoiceDateRange;
  final DateTimeRange? dueDateRange;
  final String keyword;
  const InvoicesState({
    this.invoicesModel,
    this.loadingState = LoadingState.none,
    this.invoiceDateRange,
    this.dueDateRange,
    this.keyword = "",
  });
  InvoicesState copyWith({
    final InvoicesModel? invoicesModel,
    final LoadingState? loadingState,
    final DateTimeRange? invoiceDateRange,
    final DateTimeRange? dueDateRange,
    final String? keyword,
  }) {
    return InvoicesState(
      invoicesModel: invoicesModel ?? this.invoicesModel,
      loadingState: loadingState ?? this.loadingState,
      invoiceDateRange: invoiceDateRange ?? this.invoiceDateRange,
      dueDateRange: dueDateRange ?? this.dueDateRange,
      keyword: keyword ?? this.keyword,
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
