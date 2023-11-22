part of 'receipt_details_cubit.dart';

class ReceiptDetailsState {
  final ReceiptDetailsModel? receiptDetailsModel;
  final LoadingState loadingState;
  const ReceiptDetailsState({
    this.receiptDetailsModel,
    this.loadingState = LoadingState.none,
  });
  ReceiptDetailsState copyWith({
    final ReceiptDetailsModel? receiptDetailsModel,
    final LoadingState? loadingState,
  }) {
    return ReceiptDetailsState(
        receiptDetailsModel: receiptDetailsModel ?? this.receiptDetailsModel,
        loadingState: loadingState ?? this.loadingState);
  }
}
