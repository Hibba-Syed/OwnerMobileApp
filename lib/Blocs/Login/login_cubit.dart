import 'package:iskaanowner/Blocs/App%20Theme/app_theme_cubit.dart';

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

  void onChangeObscure(bool? obscure) {
    emit(state.copyWith(obscure: obscure));
  }

  void addItemInSecondaryLoginModelList(LoginModel? loginModel) {
    state.secondaryLoginModelList?.add(loginModel);
    emit(state.copyWith(
        secondaryLoginModelList: state.secondaryLoginModelList ?? []));
  }

  void removeItemFromSecondaryLoginModelList(LoginModel? loginModel) {
    state.secondaryLoginModelList?.remove(loginModel);
    emit(state.copyWith(
        secondaryLoginModelList: state.secondaryLoginModelList ?? []));
  }

  void onChangePassword(String? password) {
    emit(state.copyWith(password: password));
  }

  Future<void> loginUser(BuildContext context, {bool newUser = false}) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    await AuthenticationService.loginUser(
      state.email,
      state.password,
    ).then((value) {
      if (value is Success) {
        emit(state.copyWith(
          loginModel: loginModelFromJson(value.response as String)[0],
        ));
        if (loginModelFromJson(value.response as String).length == 1) {
          Global.storageService.setAuthenticationModelString(
              loginModelFromJson(value.response as String)[0],
              newUser: newUser);
          return context
              .read<ProfileCubit>()
              .getProfile(context)
              .then((isLoaded) {
            if (isLoaded) {
              emit(state.copyWith(
                loginModel: loginModelFromJson(value.response as String)[0],
                loadingState: LoadingState.success,
              ));
              if (!newUser) {
                Global.storageService
                    .setLoginCreds([state.email, state.password]);
              }
              context.read<AppThemeCubit>().onChangeAppTheme(const ProfilePage()
                  .parseHexColor(state.loginModel?.owner?.company?.themeColor ??
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
          if (!newUser) {
            Global.storageService.setLoginCreds([state.email, state.password]);
          }
          emit(state.copyWith(
            loginModel: loginModelFromJson(value.response as String)[0],
            loadingState: LoadingState.success,
          ));
          return Navigator.pushNamed(context, AppRoutes.companies, arguments: [
            loginModelFromJson(value.response as String),
            newUser
          ]);
        }
      }
      value as Failure;
      Fluttertoast.showToast(
          msg: value.errorResponse as String? ?? "Unable to login");
      emit(state.copyWith(loadingState: LoadingState.error));
    });
  }
}
