import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../Utils/utils.dart';

class AuthenticationService {
  static Future<Object> loginUser(
      String email, String password, String companyId) async {
    return await ExceptionService.applyTryCatch(() async {
      return await http.post(
          Uri.parse(
            "$baseUrl/mobile/owner/auth/login",
          ),
          body: {
            "company_id": companyId,
            "username": email,
            "password": password,
            "device_type": Platform.isAndroid ? "android" : "ios",
            "device_token": "ashdgkhjfgiqheqiwjehklasjdkasljklajsdkajlsdl"
          }).then((value) {
        if (value.statusCode == 200) {
          return Success(200, value.body);
        }
        return Failure(400, jsonDecode(value.body)["message"]);
      });
    });
  }
}
