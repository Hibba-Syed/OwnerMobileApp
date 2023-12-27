import '../../Models/compliances.dart';
import '../../Utils/utils.dart';

part 'compliances_state.dart';

class CompliancesCubit extends Cubit<CompliancesState> {
  CompliancesCubit() : super(const CompliancesState());
  void onChangeKeyword(String? keyword) {
    emit(state.copyWith(keyword: keyword));
  }

  Future<void> getCompliances(BuildContext context, int? id) async {
    emit(state.copyWith(loadingState: LoadingState.loading, page: 1));
    await UnitsService.getUnitCompliances(
            context, id, state.keyword, state.page)
        .then((value) {
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

  Future<void> getMoreCompliances(BuildContext context, int? id) async {
    emit(state.copyWith(
        loadMoreState: LoadingState.loading, page: state.page + 1));
    await UnitsService.getUnitCompliances(
            context, id, state.keyword, state.page)
        .then((value) {
      if (value is Success) {
        if (compliancesModelFromJson(value.response as String)
                .compliances
                ?.isNotEmpty ??
            false) {
          state.compliancesModel?.compliances?.addAll(
              compliancesModelFromJson(value.response as String).compliances ??
                  []);
          return emit(state.copyWith(
            compliancesModel: state.compliancesModel,
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
          msg: value.errorResponse as String? ?? "Unable to get compliances");
      emit(state.copyWith(loadMoreState: LoadingState.error));
    });
  }
}
