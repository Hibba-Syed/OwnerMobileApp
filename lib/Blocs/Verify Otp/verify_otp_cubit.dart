import 'package:iskaanowner/Repo/user.dart';

import '../../Utils/utils.dart';

part 'verify_otp_state.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  VerifyOtpCubit() : super(const VerifyOtpState());
  void onChangeOtp(String? otp) {
    emit(state.copyWith(otp: otp));
  }

  Future<void> verifyOTP(BuildContext context, String email) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    await UserService.verifyOTP(context, email, state.otp).then((value) {
      if (value is Success) {
        Fluttertoast.showToast(msg: "Otp verified successfully");
        Navigator.pushNamed(context, AppRoutes.resetPassword, arguments: email);
        return emit(state.copyWith(
          loadingState: LoadingState.success,
        ));
      }
      value as Failure;
      Fluttertoast.showToast(
        msg: "Unable to verify OTP",
      );
      emit(state.copyWith(loadingState: LoadingState.error));
    });
  }
}
