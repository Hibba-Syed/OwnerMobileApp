import 'dart:convert';
import 'dart:io';

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

  static Future<Object?> submitQuery(
    BuildContext context,
    List<File> fileList,
    String type,
    String associationId,
    String complaintFor,
    String unitId,
    String subject,
    String message,
  ) async {
    return await ExceptionService.applyTryCatch(() async {
      final body = {
        'status': 'Open',
        'type': type,
        'recipient_type': 'owner',
        if (type.toLowerCase() == "complaint") 'complaint_for': complaintFor,
        'company_id':
            (context.read<LoginCubit>().state.loginModel?.owner?.company?.id ??
                    0)
                .toString(),
        'association_id': associationId,
        'unit_id': unitId,
        if (type.toLowerCase() == "complaint")
          'email_enquiry_setting_id':
              type.toLowerCase() == "unit" ? "50" : "51",
        'recipient_id':
            (context.read<ProfileCubit>().state.profileModel?.record?.id ?? 0)
                .toString(),
        'subject': subject,
        'message': message
      };
      var headers = {
        "Authorization":
            "Bearer ${context.read<LoginCubit>().state.loginModel?.accessToken}"
      };
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'http://api.synergic360.com/mobile/services/happiness-center'));
      request.fields.addAll(body);
      for (var element in fileList) {
        request.files.add(
            await http.MultipartFile.fromPath('attachments[]', element.path));
      }
      request.headers.addAll(headers);
      return await request.send().then((value) async {
        String body = await value.stream.bytesToString();
        if (value.statusCode == 201) {
          return Success(200, body);
        }
        return Failure(400, "Unable to submit query");
      });
    });
  }
}
