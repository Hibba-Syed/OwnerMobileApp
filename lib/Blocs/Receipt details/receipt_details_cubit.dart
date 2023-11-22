import '../../Models/receipt_details.dart';
import '../../Utils/utils.dart';

part 'receipt_details_state.dart';

class ReceiptDetailsCubit extends Cubit<ReceiptDetailsState> {
  ReceiptDetailsCubit() : super(const ReceiptDetailsState());

  Future<void> getReceiptDetails(BuildContext context, int? id) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    await UnitsService.getUnitReceiptDetails(context, id).then((value) {
      if (value is Success) {
        return emit(state.copyWith(
          receiptDetailsModel:
              receiptDetailsModelFromJson(value.response as String),
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
