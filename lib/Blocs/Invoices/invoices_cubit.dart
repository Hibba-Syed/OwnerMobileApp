import '../../Models/invoices.dart';
import '../../Utils/utils.dart';

part 'invoices_state.dart';

class InvoicesCubit extends Cubit<InvoicesState> {
  InvoicesCubit() : super(const InvoicesState());

  void onChangeInvoiceDateRange(DateTimeRange? invoiceDateRange) {
    emit(state.copyWith(invoiceDateRange: invoiceDateRange));
  }

  void onChangeDueDateRange(DateTimeRange? dueDateRange) {
    emit(state.copyWith(dueDateRange: dueDateRange));
  }

  void reset() {
    emit(state.reset());
  }

  void onChangeKeyword(String? keyword) {
    emit(state.copyWith(keyword: keyword));
  }

  Future<void> getInvoices(BuildContext context, int? id) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    await UnitsService.getUnitInvoices(
      context,
      id,
      state.keyword,
      state.invoiceDateRange,
      state.dueDateRange,
    ).then((value) {
      if (value is Success) {
        return emit(state.copyWith(
          invoicesModel: invoicesModelFromJson(value.response as String),
          loadingState: LoadingState.success,
        ));
      }
      value as Failure;
      Fluttertoast.showToast(
          msg: value.errorResponse as String? ?? "Unable to get invoices");
      emit(state.copyWith(loadingState: LoadingState.error));
    });
  }
}
