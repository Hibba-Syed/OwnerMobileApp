part of 'send_otp_cubit.dart';

class SendOtpState {
  final String email;
  final LoadingState loadingState;
  const SendOtpState({
    this.email = "",
    this.loadingState = LoadingState.none,
  });
  SendOtpState copyWith(
      {final String? email, final LoadingState? loadingState}) {
    return SendOtpState(
      email: email ?? this.email,
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
