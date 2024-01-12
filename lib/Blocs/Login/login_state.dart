part of 'login_cubit.dart';

class LoginState {
  final LoginModel? loginModel;
  final List<LoginModel?>? secondaryLoginModelList;
  final LoadingState loadingState;
  final String email;
  final String password;
  final bool obscure;
  const LoginState({
    this.loginModel,
    this.email = "",
    this.password = "",
    this.obscure = true,
    this.secondaryLoginModelList,
    this.loadingState = LoadingState.none,
  });
  LoginState copyWith({
    final LoginModel? loginModel,
    final List<LoginModel?>? secondaryLoginModelList,
    final String? email,
    final String? password,
    final LoadingState? loadingState,
    final bool? obscure,
  }) {
    return LoginState(
      loginModel: loginModel ?? this.loginModel,
      secondaryLoginModelList: secondaryLoginModelList ?? this.secondaryLoginModelList,
      loadingState: loadingState ?? this.loadingState,
      email: email ?? this.email,
      password: password ?? this.password,
      obscure: obscure ?? this.obscure,
    );
  }
}
