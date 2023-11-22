import 'package:iskaanowner/Models/invoice_details.dart';

import '../../Utils/utils.dart';

part 'invoice_details_state.dart';

class InvoiceDetailsCubit extends Cubit<InvoiceDetailsState> {
  InvoiceDetailsCubit() : super(const InvoiceDetailsState());

  Future<void> getInvoiceDetails(BuildContext context, int? id) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    await UnitsService.getUnitInvoiceDetails(context, id).then((value) {
      if (value is Success) {
        return emit(state.copyWith(
          invoiceDetailsModel:
              invoiceDetailsModelFromJson(value.response as String),
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
