import 'package:iskaanowner/Models/companies.dart';

import '../../Utils/utils.dart';

part 'companies_state.dart';

class CompaniesCubit extends Cubit<CompaniesState> {
  CompaniesCubit() : super(const CompaniesState());

  Future<void> getCompanies(BuildContext context) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    await AuthenticationService.getCompanies(context).then((value) {
      if (value is Success) {
        return emit(state.copyWith(
          companiesModel: companiesModelFromJson(value.response as String),
          loadingState: LoadingState.success,
        ));
      }
      value as Failure;
      Fluttertoast.showToast(
          msg: value.errorResponse as String? ?? "Unable to get communities");
      emit(state.copyWith(loadingState: LoadingState.error));
    });
  }
}
