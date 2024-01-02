import 'package:iskaanowner/Models/companies.dart';

import '../../Repo/user.dart';
import '../../Utils/utils.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(const ResetPasswordState());

  void onChangeNewPassword(String? newPassword) {
    emit(state.copyWith(newPassword: newPassword));
  }

  void onChangeNewPasswordObscure(bool? newPasswordObscure) {
    emit(state.copyWith(newPasswordObscure: newPasswordObscure));
  }

  void onChangeConfirmPasswordObscure(bool? confirmPasswordObscure) {
    emit(state.copyWith(confirmPasswordObscure: confirmPasswordObscure));
  }

  void onChangeComapinesRecord(CompaniesRecord? companiesRecord) {
    emit(state.copyWith(companiesRecord: companiesRecord));
  }

  Future<void> resetPassword(BuildContext context, String email) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    await UserService.resetPassword(
            context, email, state.newPassword, state.companiesRecord?.id)
        .then((value) {
      if (value is Success) {
        Fluttertoast.showToast(
            msg: "Password reset successful, Please login now.");
        Navigator.popUntil(context, (route) => route.isFirst);
        return emit(state.copyWith(
          loadingState: LoadingState.success,
        ));
      }
      value as Failure;
      Fluttertoast.showToast(
        msg: "Unable to reset password",
      );
      emit(state.copyWith(loadingState: LoadingState.error));
    });
  }
}
