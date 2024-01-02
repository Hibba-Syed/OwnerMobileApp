import 'package:iskaanowner/Repo/user.dart';

import '../../Utils/utils.dart';

part 'send_otp_state.dart';

class SendOtpCubit extends Cubit<SendOtpState> {
  SendOtpCubit() : super(const SendOtpState());

  void onChangeEmail(String? email) {
    emit(state.copyWith(email: email));
  }

  Future<bool> sendOTP(BuildContext context, {bool pushPage = true}) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    return await UserService.sendOTP(context, state.email).then((value) {
      if (value is Success) {
        Fluttertoast.showToast(msg: "Otp sent successfully");

        emit(state.copyWith(
          loadingState: LoadingState.success,
        ));
        if (pushPage) {
          Navigator.pushNamed(context, AppRoutes.otpVerification,
              arguments: state.email);
        }
        return true;
      }
      value as Failure;
      Fluttertoast.showToast(
        msg: "Unable to send OTP",
      );
      emit(state.copyWith(loadingState: LoadingState.error));
      return false;
    });
  }
}
