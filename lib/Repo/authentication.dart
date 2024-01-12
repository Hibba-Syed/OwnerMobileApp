import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Utils/utils.dart';

class AuthenticationService {
  static Future<Object> loginUser(String email, String password) async {
    return await ExceptionService.applyTryCatch(() async {
      return await http.post(
          Uri.parse(
            "$baseUrl/mobile/owner/auth/login",
          ),
          body: {
            "username": email,
            "password": password,
          }).then((value) {
        print("$baseUrl/mobile/owner/auth/login");
        print(email);
        print(password);
        if (value.statusCode == 200) {
          return Success(200, value.body);
        }
        return Failure(400, jsonDecode(value.body)["message"]);
      });
    });
  }

  static Future<Object?> getCompanies(
      BuildContext context, String? email) async {
    return await ExceptionService.applyTryCatch(() async {
      return await http.get(
          Uri.parse(
            "$baseUrl/mobile/owner/auth/companies?email=$email",
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
}
