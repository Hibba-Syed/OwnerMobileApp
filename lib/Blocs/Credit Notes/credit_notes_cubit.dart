import '../../Models/credit_notes.dart';
import '../../Utils/utils.dart';

part 'credit_notes_state.dart';

class CreditNotesCubit extends Cubit<CreditNotesState> {
  CreditNotesCubit() : super(const CreditNotesState());

  void onChangedateRange(DateTimeRange? dateRange) {
    emit(state.copyWith(dateRange: dateRange));
  }

  void onChangeKeyword(String? keyword) {
    emit(state.copyWith(keyword: keyword));
  }

  void reset() {
    emit(state.reset());
  }

  Future<void> getCreditNotes(BuildContext context, int? id) async {
    emit(state.copyWith(loadingState: LoadingState.loading, page: 1));
    await UnitsService.getUnitCreditNotes(
      context,
      id,
      state.keyword,
      state.dateRange,
      state.page,
    ).then((value) {
      if (value is Success) {
        return emit(state.copyWith(
          creditNotesModel: creditNotesModelFromJson(value.response as String),
          loadingState: LoadingState.success,
        ));
      }
      value as Failure;
      Fluttertoast.showToast(
          msg: value.errorResponse as String? ?? "Unable to get receipts");
      emit(state.copyWith(loadingState: LoadingState.error));
    });
  }

  Future<void> getMoreCreditNotes(BuildContext context, int? id) async {
    emit(state.copyWith(
        loadMoreState: LoadingState.loading, page: state.page + 1));
    await UnitsService.getUnitCreditNotes(
      context,
      id,
      state.keyword,
      state.dateRange,
      state.page,
    ).then((value) {
      if (value is Success) {
        if (creditNotesModelFromJson(value.response as String)
                .creditNotes
                ?.isNotEmpty ??
            false) {
          state.creditNotesModel?.creditNotes?.addAll(
              creditNotesModelFromJson(value.response as String).creditNotes ??
                  []);
          return emit(state.copyWith(
            creditNotesModel: state.creditNotesModel,
            loadMoreState: LoadingState.success,
          ));
        }
        Fluttertoast.showToast(msg: "No further results found");
        return emit(state.copyWith(
          loadMoreState: LoadingState.success,
        ));
      }
      value as Failure;
      Fluttertoast.showToast(
          msg: value.errorResponse as String? ?? "Unable to get requests");
      emit(state.copyWith(loadMoreState: LoadingState.error));
    });
  }
}
