part of 'login_cubit.dart';

class LoginState {
  final LoginModel? loginModel;
  final LoadingState loadingState;
  final String email;
  final String password;
  final bool obsure;
  final String companyId;
  const LoginState({
    this.loginModel,
    this.email = "imhammadahmad94@gmail.com",
    this.password = "hammad123",
    this.companyId = "1",
    this.obsure = true,
    this.loadingState = LoadingState.none,
  });
  LoginState copyWith({
    final LoginModel? loginModel,
    final String? email,
    final String? password,
    final String? companyId,
    final LoadingState? loadingState,
    final bool? obsure,
  }) {
    return LoginState(
      loginModel: loginModel ?? this.loginModel,
      loadingState: loadingState ?? this.loadingState,
      email: email ?? this.email,
      password: password ?? this.password,
      companyId: companyId ?? this.companyId,
      obsure: obsure ?? this.obsure,
    );
  }
}
