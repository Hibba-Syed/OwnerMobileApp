part of 'change_password_cubit.dart';

class ChangePasswordState {
  final String? oldPassword;
  final String? newPassword;
  final bool oldObscure;
  final bool newObscure;
  final bool confirmObscure;
  final LoadingState loadingState;
  ChangePasswordState(
      {this.oldPassword,
      this.newPassword,
      this.oldObscure = true,
      this.newObscure = true,
      this.confirmObscure = true,
      this.loadingState = LoadingState.none});
  ChangePasswordState copyWith(
      {final String? oldPassword,
      final String? newPassword,
      final bool? oldObscure,
      final bool? newObscure,
      final bool? confirmObscure,
      final LoadingState? loadingState}) {
    return ChangePasswordState(
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
      oldObscure: oldObscure ?? this.oldObscure,
      newObscure: newObscure ?? this.newObscure,
      confirmObscure: confirmObscure ?? this.confirmObscure,
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
