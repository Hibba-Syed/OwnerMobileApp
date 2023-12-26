import 'package:iskaanowner/Models/ledger_by_account.dart';
import 'package:iskaanowner/Models/ledgers_type.dart';

import '../../Models/ledger_by_date.dart';
import '../../Models/ledger_by_statement.dart';
import '../../Utils/utils.dart';

part 'ledger_state.dart';

class LedgerCubit extends Cubit<LedgerState> {
  LedgerCubit()
      : super(
          LedgerState(
            customDateRange: DateTimeRange(
              start: DateTime(DateTime.now().year, 1, 1),
              end: DateTime(DateTime.now().year, 12, 31),
            ),
          ),
        );

  void onChangeLedgerType(IndividualLedger? ledgerType) {
    emit(state.copyWith(ledgerType: ledgerType));
  }

  void onChangeCustomDateRange(DateTimeRange? customDateRange) {
    emit(state.copyWith(customDateRange: customDateRange));
  }

  void reset(BuildContext context) {
    emit(state.copyWith(
      ledgerType: context
          .read<LedgerTypesCubit>()
          .state
          .ledgerTypesModel
          ?.record
          ?.ledgers
          ?.first,
      customDateRange: DateTimeRange(
        start: DateTime(DateTime.now().year, 1, 1),
        end: DateTime(DateTime.now().year, 12, 31),
      ),
    ));
  }

  void onChangeKeyword(int? year) {
    emit(state.copyWith(year: year));
  }

  Future<void> getLedgerByStatement(BuildContext context, int? id) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    await UnitsService.getUnitLedgerByStatement(
            context, id, state.ledgerType, state.customDateRange)
        .then((value) {
      if (value is Success) {
        return emit(state.copyWith(
          ledgerByStatementModel:
              ledgerByStatementModelFromJson(value.response as String),
          loadingState: LoadingState.success,
        ));
      }
      value as Failure;
      Fluttertoast.showToast(
        msg: value.errorResponse as String? ??
            "Unable to get ledger by statement",
      );
      emit(state.copyWith(loadingState: LoadingState.error));
    });
  }

  Future<void> getLedgerByDate(BuildContext context, int? id) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    await UnitsService.getUnitLedgerByDate(
            context, id, state.ledgerType, state.customDateRange)
        .then((value) {
      if (value is Success) {
        return emit(state.copyWith(
          ledgerByDateModel:
              ledgerByDateModelFromJson(value.response as String),
          loadingState: LoadingState.success,
        ));
      }
      value as Failure;
      Fluttertoast.showToast(
        msg: value.errorResponse as String? ?? "Unable to get ledger by date",
      );
      emit(state.copyWith(loadingState: LoadingState.error));
    });
  }

  Future<void> getLedgerByAccount(BuildContext context, int? id) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    await UnitsService.getUnitLedgerByAccount(
            context, id, state.ledgerType, state.customDateRange)
        .then((value) {
      if (value is Success) {
        return emit(state.copyWith(
          ledgerByAccountModel:
              ledgerByAccountModelFromJson(value.response as String),
          loadingState: LoadingState.success,
        ));
      }
      value as Failure;
      Fluttertoast.showToast(
        msg:
            value.errorResponse as String? ?? "Unable to get ledger by account",
      );
      emit(state.copyWith(loadingState: LoadingState.error));
    });
  }
}
