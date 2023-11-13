import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Utils/utils.dart';

class HappinessCenterService {
  static Future<Object?> verifyUser(
      BuildContext context, int? unitId, String? email) async {
    return await ExceptionService.applyTryCatch(() async {
      return await http.get(
          Uri.parse(
            "$baseUrl/mobile/services/verify?unit_id=$unitId&email=$email&client_type=Owner",
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
