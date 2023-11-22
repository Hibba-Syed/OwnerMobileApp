import 'package:iskaanowner/Models/credit_note_details.dart';

import '../../Utils/utils.dart';

part 'credit_note_details_state.dart';

class CreditNoteDetailsCubit extends Cubit<CreditNoteDetailsState> {
  CreditNoteDetailsCubit() : super(const CreditNoteDetailsState());

  Future<void> getCreditNoteDetails(BuildContext context, int? id) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    await UnitsService.getUnitCreditNoteDetails(context, id).then((value) {
      if (value is Success) {
        return emit(state.copyWith(
          creditNoteDetailsModel:
              creditNoteDetailsModelFromJson(value.response as String),
          loadingState: LoadingState.success,
        ));
      }
      value as Failure;
      Fluttertoast.showToast(
          msg: value.errorResponse as String? ?? "Unable to get details");
      emit(state.copyWith(loadingState: LoadingState.error));
    });
  }
}
