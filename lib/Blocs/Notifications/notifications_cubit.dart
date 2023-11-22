import 'package:iskaanowner/Models/notifications.dart';
import 'package:iskaanowner/Repo/notifications.dart';

import '../../Utils/utils.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(const NotificationsState());

  Future<void> getNotifications(BuildContext context) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    await NotificationsService.getNotifications(context).then((value) {
      if (value is Success) {
        return emit(state.copyWith(
          notificationsModel:
              notificationsModelFromJson(value.response as String),
          loadingState: LoadingState.success,
        ));
      }
      value as Failure;
      Fluttertoast.showToast(
          msg: value.errorResponse as String? ?? "Unable to get notifications");
      emit(state.copyWith(loadingState: LoadingState.error));
    });
  }
}
