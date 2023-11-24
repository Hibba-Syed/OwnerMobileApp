part of 'verify_otp_cubit.dart';

class VerifyOtpState {
  final String otp;
  final LoadingState loadingState;
  const VerifyOtpState({this.otp = "", this.loadingState = LoadingState.none});
  VerifyOtpState copyWith(
      {final String? otp, final LoadingState? loadingState}) {
    return VerifyOtpState(
      loadingState: loadingState ?? this.loadingState,
      otp: otp ?? this.otp,
    );
  }
}
