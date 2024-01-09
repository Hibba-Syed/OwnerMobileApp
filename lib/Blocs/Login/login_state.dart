part of 'login_cubit.dart';

class LoginState {
  final LoginModel? loginModel;
  final LoadingState loadingState;
  final String email;
  final String password;
  final bool obscure;
  const LoginState({
    this.loginModel,
    this.email = "",
    this.password = "",
    this.obscure = true,
    this.loadingState = LoadingState.none,
  });
  LoginState copyWith({
    final LoginModel? loginModel,
    final String? email,
    final String? password,
    final LoadingState? loadingState,
    final bool? obscure,
  }) {
    return LoginState(
      loginModel: loginModel ?? this.loginModel,
      loadingState: loadingState ?? this.loadingState,
      email: email ?? this.email,
      password: password ?? this.password,
      obscure: obscure ?? this.obscure,
    );
  }
}
