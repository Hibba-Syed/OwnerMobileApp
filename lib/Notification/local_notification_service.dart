import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../Utils/utils.dart';

class LocalNotificationService {
  final BuildContext context;
  LocalNotificationService(
    this.context,
  );
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    InitializationSettings initializationSettings = InitializationSettings(
        android: const AndroidInitializationSettings("@mipmap/ic_launcher"),
        iOS: DarwinInitializationSettings(
          requestSoundPermission: false,
          requestBadgePermission: false,
          requestAlertPermission: false,
          onDidReceiveLocalNotification: onDidReceiveLocalNotification,
        ));
    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        if (details.payload != null) {
          handleOnTapNotificationEvent(context, details.payload ?? "");
        }
      },
    );
  }

  Future<void> onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    if (kDebugMode) {
      print("received local notification");
    }
  }

  static NotificationDetails notificationSettings() {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          "iskaanNotifications",
          "Iskaan Channel",
        ),
        iOS: DarwinNotificationDetails());
  }

  static Future<void> display(
      int id, String? title, String? body, String? payload) async {
    await _notificationsPlugin.show(id, title, body, notificationSettings(),
        payload: payload);
  }

  static void handleOnTapNotificationEvent(BuildContext context, String data) {
    // Map notification = jsonDecode(data);
    // Widget? page;
    // var testid = notification["id"];
    // if (notification["type"] == "lead_view") {
    //   context.read<ViewingDetailsViewModel>().getViewingDetails(
    //       token: context.read<LoginViewModel>().loginModel?.accessToken ?? "",
    //       viewingId: notification["id"].toString());
    //   page = ViewingsDetailsPage(
    //       viewing: Viewing(
    //           id: testid.runtimeType == String
    //               ? int.parse(notification["id"])
    //               : notification["id"]));
    // }
    // if (notification["type"] == "listing") {
    //   context.read<SingleListingDetailViewModel>().getsingleListing(
    //       token: context.read<LoginViewModel>().loginModel?.accessToken ?? "",
    //       listingId: notification["id"].toString());
    //   page = ListingDetailsTabbarPage(
    //     id: notification["id"].toString(),
    //   );
    // }
    // if (notification["type"] == "lead") {
    //   context.read<SingleLeadDetailsViewModel>().getSingleLeadDetails(
    //       token: context.read<LoginViewModel>().loginModel?.accessToken ?? "",
    //       leadId: notification["id"].toString());
    //   page = const SingleLeadDetailsTabbarPage();
    // }
    // if (notification["type"] == "task") {
    //   context.read<TaskDetailViewModel>().getTaskDetails(
    //       taskId: notification["id"].toString(),
    //       token: context.read<LoginViewModel>().loginModel?.accessToken ?? "");
    //   page = TasksDetailsPage(
    //     taskId: notification["id"].toString(),
    //   );
    // }
    // if (notification["type"] == "chat") {
    //   ChatChannelViewModel chatChannelViewModel =
    //       context.read<ChatChannelViewModel>();
    //   chatChannelViewModel.getChannel(
    //       context: context,
    //       token: context.read<LoginViewModel>().loginModel?.accessToken ?? "",
    //       senderId: context.read<ProfileViewModel>().profileModel?.record?.id,
    //       receiverId: int.parse(notification["id"]));
    //   AllUsersViewModel allUsersViewModel = context.read<AllUsersViewModel>();
    //   allUsersViewModel.getUsers(
    //       token: context.read<LoginViewModel>().loginModel?.accessToken ?? "");
    //   String? userName;
    //   for (var x in allUsersViewModel.allUsersModel!.record!) {
    //     if (x.id == int.parse(notification["id"])) {
    //       userName = x.fullName;
    //       break;
    //     }
    //   }
    //   page = ChatPage(
    //       chatType: "individual", //later change it to dynamic
    //       userName: userName,
    //       userId: int.parse(notification["id"]));
    // }
    // if (page != null) {
    //   KRoutes.push(context, page);
    // }
  }
}
