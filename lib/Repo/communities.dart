import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Utils/utils.dart';

class CommunitiesService {
  static Future<Object?> getCommunities(BuildContext context, int page,
      {int limit = 10}) async {
    return await ExceptionService.applyTryCatch(() async {
      return await http.get(
          Uri.parse(
            "$baseUrl/mobile/owner/property/communities?page=$page&limit=$limit",
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
      BuildContext context, int? unitId, int page) async {
    return await ExceptionService.applyTryCatch(() async {
      String url =
          "$baseUrl/mobile/owner/property/unit-shared-documents/$unitId?page=$page";
      if (unitId == null) {
        url = "$baseUrl/mobile/owner/profile/shared-documents?page=$page";
      }
      return await http.get(
          Uri.parse(
            url,
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
