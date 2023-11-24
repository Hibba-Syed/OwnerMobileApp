part of 'reset_password_cubit.dart';

class ResetPasswordState {
  final String newPassword;
  final bool newPasswordObscure;
  final bool confirmPasswordObscure;
  final LoadingState loadingState;
  const ResetPasswordState({
    this.newPassword = "",
    this.newPasswordObscure = true,
    this.confirmPasswordObscure = true,
    this.loadingState = LoadingState.none,
  });
  ResetPasswordState copyWith({
    final String? newPassword,
    final String? confirmPassword,
    final bool? newPasswordObscure,
    final bool? confirmPasswordObscure,
    final LoadingState? loadingState,
  }) {
    return ResetPasswordState(
      newPassword: newPassword ?? this.newPassword,
      newPasswordObscure: newPasswordObscure ?? this.newPasswordObscure,
      confirmPasswordObscure:
          confirmPasswordObscure ?? this.confirmPasswordObscure,
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
