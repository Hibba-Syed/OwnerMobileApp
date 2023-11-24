part of 'logout_cubit.dart';

class LogoutState {
  final LoadingState loadingState;
  const LogoutState({
    this.loadingState = LoadingState.none,
  });
  LogoutState copyWith({final LoadingState? loadingState}) {
    return LogoutState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
