part of 'login_cubit.dart';

class LoginState {
  final LoginModel? loginModel;
  final LoadingState loadingState;
  final String email;
  final String password;
  final bool obsure;
  const LoginState({
    this.loginModel,
    this.email = "",
    this.password = "",
    this.obsure = true,
    this.loadingState = LoadingState.none,
  });
  LoginState copyWith({
    final LoginModel? loginModel,
    final String? email,
    final String? password,
    final LoadingState? loadingState,
    final bool? obsure,
  }) {
    return LoginState(
      loginModel: loginModel ?? this.loginModel,
      loadingState: loadingState ?? this.loadingState,
      email: email ?? this.email,
      password: password ?? this.password,
      obsure: obsure ?? this.obsure,
    );
  }
}
