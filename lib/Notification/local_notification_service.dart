import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Utils/utils.dart';
import '../Views/ledger/ledger_by_account_details.dart';

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
    Map notification = jsonDecode(data);
    Object? arguments;
    String? route;
    if (notification["type"].toString().toLowerCase() == "owners" ||
        notification["type"].toString().toLowerCase() == "notice" ||
        notification["type"].toString().toLowerCase() == "email_enquiry") {
      showDialog(
        context: context,
        builder: (context) => Theme(
          data: ThemeData(dialogBackgroundColor: kWhite),
          child: AlertDialog(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Image.asset(
                      const LedgerByAccountDetailsPage().ledgerImageIcon(
                        notification["type"],
                        makeNotificationDefault: true,
                      ),
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: MediaQuery.of(context).size.width * 0.1,
                      color: context
                          .read<AppThemeCubit>()
                          .state
                          .primaryColor
                          .withOpacity(0.8),
                    ),
                    const Gap(10),
                    Expanded(
                      child: CustomText(
                        text: notification["object_type"] ?? "",
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                      ),
                    ),
                  ],
                ),
                const Gap(10),
                CustomText(
                  text: notification["message"] ?? "",
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                ),
                const Gap(5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.alarm_outlined,
                      size: MediaQuery.of(context).size.width * 0.03,
                      color: context.read<AppThemeCubit>().state.primaryColor,
                    ),
                    const Gap(5),
                    CustomText(
                      text: const OccupantPage()
                          .dateTimeFormatter(notification["createdAt"]),
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
      return;
    }
    if (notification["type"].toString().toLowerCase() == "application") {
      context.read<RequestDetailsCubit>().getRequestDetails(
            context,
            notification["objectId"],
            notification["objectType"],
          );
      route = const RequestsPage().getRouteName(notification["objectType"]);
      arguments = [
        notification["objectId"],
        notification["activity"],
        notification["objectType"],
      ];
      Navigator.pushNamed(context, route ?? "", arguments: arguments);
    }
    if (notification["type"].toString().toLowerCase() == "shared_docs") {
      context
          .read<SharedDocumentsCubit>()
          .getSharedDocuments(context, unitId: notification["objectId"]);
      route = AppRoutes.sharedDocument;
      arguments = notification["objectId"];
      Navigator.pushNamed(context, route, arguments: arguments);
    }
    const LedgerPage().decidePage(
      context,
      notification["objectId"],
      notification["objectType"],
    );
  }
}
