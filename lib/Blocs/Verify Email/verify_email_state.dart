part of 'verify_email_cubit.dart';

class VerifyEmailState {
  final LoadingState loadingState;
  const VerifyEmailState({
    this.loadingState = LoadingState.none,
  });
  VerifyEmailState copyWith(
      {
      final LoadingState? loadingState}) {
    return VerifyEmailState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
