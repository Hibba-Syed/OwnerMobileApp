part of 'invoice_details_cubit.dart';

 class InvoiceDetailsState {
     final InvoiceDetailsModel? invoiceDetailsModel;
  final LoadingState loadingState;
  const InvoiceDetailsState({
    this.invoiceDetailsModel,
    this.loadingState = LoadingState.none,
  });
  InvoiceDetailsState copyWith({
    final InvoiceDetailsModel? invoiceDetailsModel,
    final LoadingState? loadingState,
  }) {
    return InvoiceDetailsState(
        invoiceDetailsModel: invoiceDetailsModel ?? this.invoiceDetailsModel,
        loadingState: loadingState ?? this.loadingState);
  }
 }
