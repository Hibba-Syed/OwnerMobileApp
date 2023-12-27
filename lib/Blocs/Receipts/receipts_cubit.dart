import '../../Models/receipts.dart';
import '../../Utils/utils.dart';

part 'receipts_state.dart';

class ReceiptsCubit extends Cubit<ReceiptsState> {
  ReceiptsCubit() : super(const ReceiptsState());
  void onChangedateRange(DateTimeRange? dateRange) {
    emit(state.copyWith(dateRange: dateRange));
  }

  void onChangeKeyword(String? keyword) {
    emit(state.copyWith(keyword: keyword));
  }

  void reset() {
    emit(state.reset());
  }

  Future<void> getReceipts(BuildContext context, int? id) async {
    emit(state.copyWith(loadingState: LoadingState.loading, page: 1));
    await UnitsService.getUnitReceipts(
            context, id, state.dateRange, state.keyword)
        .then((value) {
      if (value is Success) {
        return emit(state.copyWith(
          receiptsModel: receiptsModelFromJson(value.response as String),
          loadingState: LoadingState.success,
        ));
      }
      value as Failure;
      Fluttertoast.showToast(
          msg: value.errorResponse as String? ?? "Unable to get receipts");
      emit(state.copyWith(loadingState: LoadingState.error));
    });
  }

  Future<void> getMoreReceipts(BuildContext context, int? id) async {
    emit(state.copyWith(
        loadMoreState: LoadingState.loading, page: state.page + 1));
    await UnitsService.getUnitReceipts(
            context, id, state.dateRange, state.keyword)
        .then((value) {
      if (value is Success) {
        if (receiptsModelFromJson(value.response as String)
                .receipts
                ?.isNotEmpty ??
            false) {
          state.receiptsModel?.receipts?.addAll(
              receiptsModelFromJson(value.response as String).receipts ?? []);
          return emit(state.copyWith(
            receiptsModel: state.receiptsModel,
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
