part of 'notifications_cubit.dart';

class NotificationsState {
  final NotificationsModel? notificationsModel;
  final LoadingState loadingState;
  final LoadingState loadMoreState;
  final int page;
  const NotificationsState({
    this.notificationsModel,
    this.loadingState = LoadingState.none,
    this.loadMoreState = LoadingState.none,
    this.page = 1,
  });
  NotificationsState copyWith({
    final NotificationsModel? notificationsModel,
    final LoadingState? loadingState,
    final LoadingState? loadMoreState,
    final int? page,
  }) {
    return NotificationsState(
      notificationsModel: notificationsModel ?? this.notificationsModel,
      loadingState: loadingState ?? this.loadingState,
      loadMoreState: loadMoreState ?? this.loadMoreState,
      page: page ?? this.page,
    );
  }
}
