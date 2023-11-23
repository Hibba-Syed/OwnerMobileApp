import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Utils/utils.dart';

class UserService {
  static Future<Object?> getProfile(BuildContext context) async {
    return await ExceptionService.applyTryCatch(() async {
      return await http.get(
          Uri.parse(
            "$baseUrl/mobile/owner/profile",
          ),
          headers: {
            "Authorization":
                "Bearer ${context.read<LoginCubit>().state.loginModel?.accessToken}"
          }).then((value) {
        if (value.statusCode == 200) {
          return Success(200, value.body);
        }
        return Failure(400, jsonDecode(value.body)["message"]);
      });
    });
  }

  static Future<Object?> sendOTP(BuildContext context, String email) async {
    return await ExceptionService.applyTryCatch(() async {
      return await http.post(
          Uri.parse(
            "$baseUrl/mobile/owner/auth/send-otp",
          ),
          headers: {
            "Authorization":
                "Bearer ${context.read<LoginCubit>().state.loginModel?.accessToken}"
          },
          body: {
            "email": email,
          }).then((value) {
        if (value.statusCode == 201 || value.statusCode == 200) {
          return Success(201, value.body);
        }
        return Failure(400, jsonDecode(value.body)["message"]);
      });
    });
  }

  static Future<Object?> changePassword(
      BuildContext context, String? oldPassword, String? newPassword) async {
    return await ExceptionService.applyTryCatch(() async {
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'http://api.synergic360.com/mobile/owner/auth/change-password'));
      request.fields.addAll({
        'current_password': oldPassword ?? "",
        'password': newPassword ?? "",
        'password_confirmation': newPassword ?? ""
      });
      Map<String, String> headers = {
        "Authorization":
            "Bearer ${context.read<LoginCubit>().state.loginModel?.accessToken}"
      };
      request.headers.addAll(headers);

      return await request.send().then((response) async {
        if (response.statusCode == 200) {
          return Success(200, await response.stream.bytesToString());
        }
        return Failure(
            400, response.reasonPhrase ?? "unable to change password");
      });
    });
  }
}
