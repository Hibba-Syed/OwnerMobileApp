import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Utils/utils.dart';

class CommunitiesService {
  static Future<Object?> getCommunities(BuildContext context) async {
    return await ExceptionService.applyTryCatch(() async {
      return await http.get(
          Uri.parse(
            "$baseUrl/mobile/owner/property/communities",
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

  static Future<Object?> getSharedDocuments(
      BuildContext context, int? unitId) async {
    return await ExceptionService.applyTryCatch(() async {
      return await http.get(
          Uri.parse(
            unitId == null
                ? "$baseUrl/mobile/owner/profile/shared-documents"
                : "$baseUrl/mobile/owner/property/unit-shared-documents/$unitId",
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
