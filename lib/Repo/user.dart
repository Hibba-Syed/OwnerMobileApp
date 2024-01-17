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

  static Future<Object?> logout(BuildContext context) async {
    return await ExceptionService.applyTryCatch(() async {
      return await http
          .post(
        Uri.parse("$baseUrl/mobile/owner/auth/logout"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization":
              "Bearer ${context.read<LoginCubit>().state.loginModel?.accessToken}"
        },
        body: jsonEncode({
          "token": loginModelFromJson(
                  Global.storageService.getAuthenticationModelString() ?? "")
              .map((e) => e.accessToken)
              .toList()
        }),
      )
          .then((value) {
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

  static Future<Object?> verifyOTP(
      BuildContext context, String email, String otp) async {
    return await ExceptionService.applyTryCatch(() async {
      return await http.post(
          Uri.parse(
            "$baseUrl/mobile/owner/auth/verify-otp",
          ),
          headers: {
            "Authorization":
                "Bearer ${context.read<LoginCubit>().state.loginModel?.accessToken}"
          },
          body: {
            "email": email,
            "verification_code": otp,
          }).then((value) {
        if (value.statusCode == 201 || value.statusCode == 200) {
          return Success(201, value.body);
        }
        return Failure(400, jsonDecode(value.body)["message"]);
      });
    });
  }

  static Future<Object?> resetPassword(BuildContext context, String email,
      String password, int? companyId) async {
    return await ExceptionService.applyTryCatch(() async {
      return await http.post(
          Uri.parse(
            "$baseUrl/mobile/owner/auth/reset-password",
          ),
          headers: {
            "Authorization":
                "Bearer ${context.read<LoginCubit>().state.loginModel?.accessToken}"
          },
          body: {
            "email": email,
            "password": password,
            if (companyId != null) "company_id": companyId.toString(),
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
        String body = await response.stream.bytesToString();
        if (response.statusCode == 200) {
          return Success(200, body);
        }
        return Failure(
            400, jsonDecode(body)["message"] ?? "unable to change password");
      });
    });
  }
}
