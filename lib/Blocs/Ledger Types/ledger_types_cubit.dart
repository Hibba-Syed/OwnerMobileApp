import 'package:iskaanowner/Models/ledgers_type.dart';

import '../../Utils/utils.dart';

part 'ledger_types_state.dart';

class LedgerTypesCubit extends Cubit<LedgerTypesState> {
  LedgerTypesCubit() : super(const LedgerTypesState());
  Future<void> getLedgerTypes(BuildContext context) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    await UnitsService.getUnitLedgerTypes(context).then((value) {
      if (value is Success) {
        return emit(state.copyWith(
          ledgerTypesModel: ledgerTypesModelFromJson(value.response as String),
          loadingState: LoadingState.success,
        ));
      }
      value as Failure;
      Fluttertoast.showToast(
          msg: value.errorResponse as String? ?? "Unable to get compliances");
      emit(state.copyWith(loadingState: LoadingState.error));
    });
  }
}
