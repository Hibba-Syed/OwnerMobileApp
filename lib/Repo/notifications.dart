import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Utils/utils.dart';

class NotificationsService {
  static Future<Object?> getNotifications(
      BuildContext context, int page) async {
    return await ExceptionService.applyTryCatch(() async {
      return await http.get(
          Uri.parse(
            "$baseUrl/mobile/owner/profile/notifications?page=$page",
          ),
          headers: {
            "Authorization":
                "Bearer ${context.read<LoginCubit>().state.loginModel?.accessToken}"
          }).then((value) {
        if (value.statusCode == 201) {
          return Success(200, value.body);
        }
        return Failure(400, jsonDecode(value.body)["message"]);
      });
    });
  }

  static Future<Object?> readAllNotifications(BuildContext context) async {
    return await ExceptionService.applyTryCatch(() async {
      return await http.get(
          Uri.parse(
            "$baseUrl/mobile/owner/profile/notifications/read-all",
          ),
          headers: {
            "Authorization":
                "Bearer ${context.read<LoginCubit>().state.loginModel?.accessToken}"
          }).then((value) {
        if (value.statusCode == 201 || value.statusCode == 200) {
          return Success(200, value.body);
        }
        return Failure(400, jsonDecode(value.body)["message"]);
      });
    });
  }

  static Future<Object?> readNotification(BuildContext context, int? id) async {
    return await ExceptionService.applyTryCatch(() async {
      return await http.get(
          Uri.parse(
            "$baseUrl/mobile/owner/profile/notifications/$id/read",
          ),
          headers: {
            "Authorization":
                "Bearer ${context.read<LoginCubit>().state.loginModel?.accessToken}"
          }).then((value) {
        if (value.statusCode == 201 || value.statusCode == 200) {
          return Success(200, value.body);
        }
        return Failure(400, jsonDecode(value.body)["message"]);
      });
    });
  }
}
