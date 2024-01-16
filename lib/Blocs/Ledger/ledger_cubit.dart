import 'package:iskaanowner/Models/ledger_by_account.dart';
import 'package:iskaanowner/Models/ledgers_type.dart';

import '../../Models/ledger_by_date.dart';
import '../../Models/ledger_by_statement.dart';
import '../../Utils/utils.dart';

part 'ledger_state.dart';

class LedgerCubit extends Cubit<LedgerState> {
  LedgerCubit()
      : super(LedgerState(
            customDateRange: DateTimeRange(
                start: DateTime(DateTime.now().year, 1, 1),
                end: DateTime(DateTime.now().year, 12, 31))));

  void onChangeLedgerType(IndividualLedger? ledgerType) {
    emit(state.copyWith(ledgerType: ledgerType));
  }

  void onChangeLedgerName(String? ledgerName) {
    emit(state.copyWith(ledgerName: ledgerName));
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

  /// -------- by Statement --------
  Future<void> getLedgerByStatement(BuildContext context, int? id) async {
    emit(state.copyWith(
        loadingState: LoadingState.loading, pageLedgerByStatement: 1));
    await UnitsService.getUnitLedgerByStatement(context, id, state.ledgerType,
            state.customDateRange, state.pageLedgerByStatement)
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

  Future<void> getMoreLedgerByStatement(BuildContext context, int? id) async {
    emit(state.copyWith(
        loadMoreLedgerByStatementState: LoadingState.loading,
        pageLedgerByStatement: state.pageLedgerByStatement + 1));
    await UnitsService.getUnitLedgerByStatement(context, id, state.ledgerType,
            state.customDateRange, state.pageLedgerByStatement)
        .then((value) {
      if (value is Success) {
        if (ledgerByStatementModelFromJson(value.response as String)
                .record
                ?.data
                ?.ledgers
                ?.isNotEmpty ??
            false) {
          state.ledgerByStatementModel?.record?.data?.ledgers?.addAll(
              ledgerByStatementModelFromJson(value.response as String)
                      .record
                      ?.data
                      ?.ledgers ??
                  []);
          return emit(state.copyWith(
            ledgerByStatementModel: state.ledgerByStatementModel,
            loadMoreLedgerByStatementState: LoadingState.success,
          ));
        }
        Fluttertoast.showToast(msg: "No further results found");
        return emit(state.copyWith(
          loadMoreLedgerByStatementState: LoadingState.success,
        ));
      }
      value as Failure;
      Fluttertoast.showToast(
          msg: value.errorResponse as String? ?? "Unable to get Ledger");
      emit(state.copyWith(loadMoreLedgerByStatementState: LoadingState.error));
    });
  }

  /// -------- by Date --------
  Future<void> getLedgerByDate(BuildContext context, int? id) async {
    emit(state.copyWith(
        loadingState: LoadingState.loading, pageLedgerByDate: 1));
    await UnitsService.getUnitLedgerByDate(context, id, state.ledgerType,
            state.customDateRange, state.pageLedgerByDate)
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

  Future<void> getMoreLedgerByDate(BuildContext context, int? id) async {
    emit(state.copyWith(
        loadMoreLedgerByDateState: LoadingState.loading,
        pageLedgerByDate: state.pageLedgerByDate + 1));
    await UnitsService.getUnitLedgerByDate(context, id, state.ledgerType,
            state.customDateRange, state.pageLedgerByDate)
        .then((value) {
      if (value is Success) {
        if (ledgerByDateModelFromJson(value.response as String)
                .record
                ?.data
                ?.isNotEmpty ??
            false) {
          state.ledgerByDateModel?.record?.data?.addAll(
              ledgerByDateModelFromJson(value.response as String)
                      .record
                      ?.data ??
                  []);
          return emit(state.copyWith(
            ledgerByDateModel: state.ledgerByDateModel,
            loadMoreLedgerByDateState: LoadingState.success,
          ));
        }
        Fluttertoast.showToast(msg: "No further results found");
        return emit(state.copyWith(
          loadMoreLedgerByDateState: LoadingState.success,
        ));
      }
      value as Failure;
      Fluttertoast.showToast(
          msg: value.errorResponse as String? ?? "Unable to get Ledger");
      emit(state.copyWith(loadMoreLedgerByDateState: LoadingState.error));
    });
  }

  /// -------- by Account --------
  Future<void> getLedgerByAccount(BuildContext context, int? id) async {
    emit(state.copyWith(
        loadingState: LoadingState.loading, pageLedgerByAccount: 1));
    await UnitsService.getUnitLedgerByAccount(context, id, state.ledgerType,
            state.customDateRange, state.pageLedgerByAccount)
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

  Future<void> getMoreLedgerByAccount(BuildContext context, int? id) async {
    emit(state.copyWith(
        loadMoreLedgerByAccountState: LoadingState.loading,
        pageLedgerByAccount: state.pageLedgerByAccount + 1));
    await UnitsService.getUnitLedgerByAccount(context, id, state.ledgerType,
            state.customDateRange, state.pageLedgerByAccount)
        .then((value) {
      if (value is Success) {
        if (ledgerByAccountModelFromJson(value.response as String)
                .record
                ?.ledgers
                ?.isNotEmpty ??
            false) {
          state.ledgerByAccountModel?.record?.ledgers?.addAll(
              ledgerByAccountModelFromJson(value.response as String)
                      .record
                      ?.ledgers ??
                  []);
          return emit(state.copyWith(
            ledgerByAccountModel: state.ledgerByAccountModel,
            loadMoreLedgerByAccountState: LoadingState.success,
          ));
        }
        Fluttertoast.showToast(msg: "No further results found");
        return emit(state.copyWith(
          loadMoreLedgerByAccountState: LoadingState.success,
        ));
      }
      value as Failure;
      Fluttertoast.showToast(
          msg: value.errorResponse as String? ?? "Unable to get Ledger");
      emit(state.copyWith(loadMoreLedgerByAccountState: LoadingState.error));
    });
  }
}
