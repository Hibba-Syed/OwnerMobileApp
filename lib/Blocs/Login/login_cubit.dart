import '../../Utils/utils.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void onChangeLoginModel(LoginModel? loginModel) {
    emit(state.copyWith(loginModel: loginModel));
  }

  void onChangeEmail(String? email) {
    emit(state.copyWith(email: email));
  }

  void onChangeObsure(bool? obsure) {
    emit(state.copyWith(obsure: obsure));
  }

  void onChangePassword(String? password) {
    emit(state.copyWith(password: password));
  }

  void onChangeCompanyId(String? companyId) {
    emit(state.copyWith(companyId: companyId));
  }

  Future<void> loginUser(BuildContext context) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    await AuthenticationService.loginUser(
            state.email, state.password, state.companyId)
        .then((value) {
      if (value is Success) {
        emit(state.copyWith(
          loginModel: loginModelFromJson(value.response as String),
        ));
        Global.storageService.setAuthenticationModelString(
            loginModelFromJson(value.response as String));
        return context
            .read<ProfileCubit>()
            .getProfile(context)
            .then((isLoaded) {
          if (isLoaded) {
            emit(state.copyWith(
              loginModel: loginModelFromJson(value.response as String),
              loadingState: LoadingState.success,
            ));
            const LoginPage().initialCalls(context);
            return Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
          } else {
            Fluttertoast.showToast(msg: "Unable to load profile");
            emit(state.copyWith(loadingState: LoadingState.error));
          }
        });
      }
      value as Failure;
      Fluttertoast.showToast(
          msg: value.errorResponse as String? ?? "Unable to login");
      emit(state.copyWith(loadingState: LoadingState.error));
    });
  }
}
