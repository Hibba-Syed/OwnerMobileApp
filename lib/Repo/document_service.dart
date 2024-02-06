import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../Utils/utils.dart';

class DocumentService {
  static Future<Object> downloadAndOpenFile(
      BuildContext context, final String url) async {
    return await ExceptionService.applyTryCatch(() async {
      var response = await http.get(Uri.parse(url), headers: {
        "Authorization":
            "Bearer ${context.read<LoginCubit>().state.loginModel?.accessToken}"
      });
      if (response.statusCode == 200) {
        String? extension = response.headers['content-type'];
        extension = extension?.split('/').last;
        if (extension ==
            "vnd.openxmlformats-officedocument.spreadsheetml.sheet") {
          extension = "xlsx";
        }
        String fileName = url.split('/').last;
        final directory = await getApplicationDocumentsDirectory();
        String filePath = '${directory.path}/$fileName.$extension';
        final existingFile = File(filePath);
        if (await existingFile.exists()) {
          int count = 1;
          String newFileName;
          do {
            newFileName = '$fileName (${count++})';
            filePath = '${directory.path}/$newFileName.$extension';
          } while (await File(filePath).exists());
        }
        await File(filePath).writeAsBytes(response.bodyBytes);
        return Success(200, filePath);
      }
      return Failure(400, "Failed to download");
    });
  }
}
