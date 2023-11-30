import 'package:iskaanowner/Blocs/App%20Theme/app_theme_cubit.dart';
import 'package:iskaanowner/Blocs/Companies/companies_cubit.dart';

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

  Future<void> loginUser(BuildContext context) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    await AuthenticationService.loginUser(state.email, state.password)
        .then((value) {
      if (value is Success) {
        emit(state.copyWith(
          loginModel: loginModelFromJson(value.response as String)[0],
        ));
        return context.read<CompaniesCubit>().getCompanies(context).then((_) {
          if (loginModelFromJson(value.response as String).length == 1 &&
              (context
                      .read<CompaniesCubit>()
                      .state
                      .companiesModel
                      ?.record
                      ?.isEmpty ??
                  false)) {
            Global.storageService.setAuthenticationModelString(
                loginModelFromJson(value.response as String)[0]);
            return context
                .read<ProfileCubit>()
                .getProfile(context)
                .then((isLoaded) {
              if (isLoaded) {
                emit(state.copyWith(
                  loginModel: loginModelFromJson(value.response as String)[0],
                  loadingState: LoadingState.success,
                ));
                context.read<AppThemeCubit>().onChangeAppTheme(
                    const SplashPage().parseHexColor(
                        state.loginModel?.owner?.company?.themeColor ??
                            "#751b50"));
                const LoginPage().initialCalls(context);
                return Navigator.pushReplacementNamed(
                    context, AppRoutes.dashboard);
              } else {
                Fluttertoast.showToast(msg: "Unable to load profile");
                emit(state.copyWith(loadingState: LoadingState.error));
              }
            });
          } else {
            emit(state.copyWith(
              loginModel: loginModelFromJson(value.response as String)[0],
              loadingState: LoadingState.success,
            ));
            return Navigator.pushNamed(context, AppRoutes.companies,
                arguments: loginModelFromJson(value.response as String));
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
