part of 'credit_note_details_cubit.dart';

class CreditNoteDetailsState {
    final CreditNoteDetailsModel? creditNoteDetailsModel;
  final LoadingState loadingState;
  const CreditNoteDetailsState({
    this.creditNoteDetailsModel,
    this.loadingState = LoadingState.none,
  });
  CreditNoteDetailsState copyWith({
    final CreditNoteDetailsModel? creditNoteDetailsModel,
    final LoadingState? loadingState,
  }) {
    return CreditNoteDetailsState(
        creditNoteDetailsModel: creditNoteDetailsModel ?? this.creditNoteDetailsModel,
        loadingState: loadingState ?? this.loadingState);
  }
}

