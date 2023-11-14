import 'package:iskaanowner/Blocs/Profile/profile_cubit.dart';

import '../../Utils/utils.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void onChangeLoginModel(LoginModel? loginModel) {
    emit(state.copyWith(loginModel: loginModel));
  }

  void onChangeEmail(String? email) {
    state.copyWith(email: email);
  }

  void onChangeObsure(bool? obsure) {
    emit(state.copyWith(obsure: obsure));
  }

  void onChangePassword(String? password) {
    state.copyWith(password: password);
  }

  void onChangeCompanyId(String? companyId) {
    state.copyWith(companyId: companyId);
  }

  Future<void> loginUser(BuildContext context) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    await AuthenticationService.loginUser(
            state.email, state.password, state.companyId)
        .then((value) {
      if (value is Success) {
        Global.storageService
            .setAuthenticationModelString(value.response as String);
        return context.read<ProfileCubit>().getProfile(context).then((_) {
          emit(state.copyWith(
            loginModel: loginModelFromJson(value.response as String),
            loadingState: LoadingState.success,
          ));
          const LoginPage().initialCalls(context);
          return Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
        });
      }
      value as Failure;
      Fluttertoast.showToast(
          msg: value.errorResponse as String? ?? "Unable to login");
      emit(state.copyWith(loadingState: LoadingState.error));
    });
  }
}
