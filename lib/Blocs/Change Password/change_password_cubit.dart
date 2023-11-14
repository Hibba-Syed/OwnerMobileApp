import 'package:iskaanowner/Repo/user.dart';

import '../../Utils/utils.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordState());
  void onChangeOldPassword(String? oldPassword) {
    emit(state.copyWith(
      oldPassword: oldPassword,
    ));
  }

  void onChangeNewPassword(String? newPassword) {
    emit(state.copyWith(
      newPassword: newPassword,
    ));
  }

  void onChangeOldObsure(bool? oldObscure) {
    emit(state.copyWith(
      oldObscure: oldObscure,
    ));
  }

  void onChangeNewObsure(bool? newObscure) {
    emit(state.copyWith(
      newObscure: newObscure,
    ));
  }

  void onChangeConfirmObsure(bool? confirmObscure) {
    emit(state.copyWith(
      confirmObscure: confirmObscure,
    ));
  }

  Future<void> changePassword(BuildContext context) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    await UserService.changePassword(
            context, state.oldPassword, state.newPassword)
        .then((value) {
      if (value is Success) {
        emit(state.copyWith(
          loadingState: LoadingState.success,
        ));
        Navigator.pop(context);
        return Fluttertoast.showToast(msg: "Password updated successfully.");
      }
      value as Failure;
      Fluttertoast.showToast(
          msg: value.errorResponse as String? ?? "Unable to change password");
      emit(state.copyWith(loadingState: LoadingState.error));
    });
  }
}
