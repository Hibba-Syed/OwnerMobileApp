import 'api_status.dart';

class ExceptionService {
  static Future<Object> applyTryCatch(Function callback,
      {String? message}) async {
    try {
      Object result = await callback();
      return result;
    } catch (e) {
      if (message != null) {
        return Failure(400, message);
      }
      return Failure(400, e.toString());
    }
  }
}
