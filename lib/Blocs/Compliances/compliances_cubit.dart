import '../../Models/compliances.dart';
import '../../Utils/utils.dart';

part 'compliances_state.dart';

class CompliancesCubit extends Cubit<CompliancesState> {
  CompliancesCubit() : super(const CompliancesState());
  void onChangeKeyword(String? keyword) {
    emit(state.copyWith(keyword: keyword));
  }

  Future<void> getCompliances(BuildContext context, int? id) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    await UnitsService.getUnitCompliances(context, id,state.keyword).then((value) {
      if (value is Success) {
        return emit(state.copyWith(
          compliancesModel: compliancesModelFromJson(value.response as String),
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
