part of 'notifications_cubit.dart';

class NotificationsState {
  final NotificationsModel? notificationsModel;
  final LoadingState loadingState;
  const NotificationsState({
    this.notificationsModel,
    this.loadingState = LoadingState.none,
  });
  NotificationsState copyWith({
    final NotificationsModel? notificationsModel,
    final LoadingState? loadingState,
  }) {
    return NotificationsState(
        notificationsModel: notificationsModel ?? this.notificationsModel,
        loadingState: loadingState ?? this.loadingState);
  }
}
