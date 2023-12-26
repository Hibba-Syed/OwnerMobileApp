import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:iskaanowner/Notification/local_notification_service.dart';

import '../Utils/utils.dart';
import '../main.dart';

class FirebaseNotificationService {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  late StreamSubscription<RemoteMessage> messageSteam;
  late StreamSubscription<RemoteMessage> appOpeningSteam;
  late StreamSubscription<String> tokenSteam;
  Future<void> getPermissions() async {
    await firebaseMessaging.requestPermission();
  }

  handleTokenStatus(BuildContext context, String accessToken) async {
    if (kDebugMode) {
      print(await firebaseMessaging.getToken());
    }
    tokenSteam = firebaseMessaging.onTokenRefresh.listen((event) async {
      await makeFirebaseTokenRequest(context, accessToken);
    });
  }

  Future<void> makeFirebaseTokenRequest(
    BuildContext context,
    String accessToken,
  ) async {
    await firebaseMessaging.getToken().then((value) {
      Uri url = Uri.parse("$baseUrl/mobile/owner/auth/update/device-token");
      http.post(url, body: {
        "device_type": Platform.isAndroid ? "Android" : "IOS",
        "device_token": value,
      }, headers: {
        "Authorization": "Bearer $accessToken"
      }).then((value) {
        if (kDebugMode) {
          print(value.body);
        }
      });
    });
  }

  void handleOnMessage() {
    messageSteam = FirebaseMessaging.onMessage.listen((message) async {
      if (message.notification != null) {
        final int id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
        await LocalNotificationService.display(
            id,
            message.notification?.title,
            message.notification?.body,
            jsonEncode({
              "id": message.data["id"],
              "type": message.data["type"],
            }));
      }
    });
  }

  void handleOnBackground() {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  Future<void> handleOnTapBackground(BuildContext context) async {
    await firebaseMessaging.getInitialMessage().then((message) {
      if (message != null) {
        LocalNotificationService.handleOnTapNotificationEvent(
            context,
            jsonEncode({
              "id": message.data["id"],
              "type": message.data["type"],
            }));
      }
    });
  }

  void handleAppOpened(BuildContext context) {
    appOpeningSteam = FirebaseMessaging.onMessageOpenedApp.listen((message) {
      LocalNotificationService.handleOnTapNotificationEvent(
          context,
          jsonEncode({
            "id": message.data["id"],
            "type": message.data["type"],
          }));
    });
  }

  void dispose() {
    messageSteam.cancel();
    appOpeningSteam.cancel();
    tokenSteam.cancel();
  }
}
