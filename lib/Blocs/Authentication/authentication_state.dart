part of 'authentication_cubit.dart';

class AuthenticationState {
  final bool isAuthenticating;
  const AuthenticationState({this.isAuthenticating = false});
  AuthenticationState copyWith({final bool? isAuthenticating}) {
    return AuthenticationState(
      isAuthenticating: isAuthenticating ?? this.isAuthenticating,
    );
  }
}
