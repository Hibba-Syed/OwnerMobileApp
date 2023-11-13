part of 'change_password_cubit.dart';

class ChangePasswordState {
  final String? oldPassword;
  final String? newPassword;
  final bool oldObsure;
  final bool newObsure;
  final bool confirmObsure;
  final LoadingState loadingState;
  ChangePasswordState(
      {this.oldPassword,
      this.newPassword,
      this.oldObsure = true,
      this.newObsure = true,
      this.confirmObsure = true,
      this.loadingState = LoadingState.none});
  ChangePasswordState copyWith(
      {final String? oldPassword,
      final String? newPassword,
      final bool? oldObsure,
      final bool? newObsure,
      final bool? confirmObsure,
      final LoadingState? loadingState}) {
    return ChangePasswordState(
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
      oldObsure: oldObsure ?? this.oldObsure,
      newObsure: newObsure ?? this.newObsure,
      confirmObsure: confirmObsure ?? this.confirmObsure,
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
