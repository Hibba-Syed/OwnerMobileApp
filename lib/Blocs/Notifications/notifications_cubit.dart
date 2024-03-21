import 'package:iskaanowner/Models/notifications.dart';
import 'package:iskaanowner/Repo/notifications.dart';

import '../../Utils/utils.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(const NotificationsState());

  Future<void> getNotifications(BuildContext context) async {
    emit(state.copyWith(loadingState: LoadingState.loading, page: 1));
    await NotificationsService.getNotifications(context, state.page)
        .then((value) {
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

  Future<void> getMoreNotifications(BuildContext context) async {
    emit(state.copyWith(
        loadMoreState: LoadingState.loading, page: state.page + 1));
    await NotificationsService.getNotifications(context, state.page)
        .then((value) {
      if (value is Success) {
        if (notificationsModelFromJson(value.response as String)
                .notifications
                ?.isNotEmpty ??
            false) {
          state.notificationsModel?.notifications?.addAll(
              notificationsModelFromJson(value.response as String)
                      .notifications ??
                  []);
          return emit(state.copyWith(
            notificationsModel: state.notificationsModel,
            loadMoreState: LoadingState.success,
          ));
        }
        Fluttertoast.showToast(msg: "No further results found");
        return emit(state.copyWith(
          loadMoreState: LoadingState.success,
        ));
      }
      value as Failure;

      Fluttertoast.showToast(
          msg: value.errorResponse as String? ?? "Unable to get notifications");
      emit(state.copyWith(loadMoreState: LoadingState.error));
    });
  }

  Future<void> readAllNotifications(BuildContext context) async {
    await NotificationsService.readAllNotifications(context).then((value) {
      if (value is Success) {
        state.notificationsModel?.notifications?.forEach((element) {
          element.isRead = 1;
        });
        LoginModel? loginModel = context.read<LoginCubit>().state.loginModel;
        loginModel?.unreadNotifications = 0;
        context.read<LoginCubit>().onChangeLoginModel(loginModel);
        Global.storageService.setAuthenticationModelString(loginModel,
            addItInFront: true, index: 0);
        return emit(state.copyWith(
          notificationsModel: state.notificationsModel,
        ));
      }
      value as Failure;
      Fluttertoast.showToast(
          msg: value.errorResponse as String? ??
              "Unable to read all notifications");
    });
  }

  Future<void> readNotification(
      BuildContext context, int? id, int index) async {
    await NotificationsService.readNotification(context, id).then((value) {
      if (value is Success) {
        state.notificationsModel?.notifications?[index].isRead = 1;
        LoginModel? loginModel = context.read<LoginCubit>().state.loginModel;
        if ((loginModel?.unreadNotifications ?? 0) > 0) {
          loginModel?.unreadNotifications =
              (loginModel.unreadNotifications ?? 0) - 1;
        }
        context.read<LoginCubit>().onChangeLoginModel(loginModel);
        Global.storageService.setAuthenticationModelString(loginModel,
            addItInFront: true, index: 0);
        return emit(state.copyWith(
          notificationsModel: state.notificationsModel,
        ));
      }
      value as Failure;
      Fluttertoast.showToast(
          msg: value.errorResponse as String? ??
              "Unable to read all notifications");
    });
  }
}
