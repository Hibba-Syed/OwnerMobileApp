import 'dart:convert';

import 'package:iskaanowner/Utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  late final SharedPreferences _prefs;
  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setAuthenticationModelString(LoginModel value,
      {bool addItInFront = false, int? index}) async {
    String? userList = getAuthenticationModelString();
    if (userList != null) {
      List users = jsonDecode(userList);
      if (addItInFront) {
        users.removeAt(index ?? 0);
        users.insert(0, value);
      } else {
        users.insert(0, value);
      }
      return await _prefs.setString("users", jsonEncode(users));
    }
    return await _prefs.setString("users", jsonEncode([value]));
  }

  String? getAuthenticationModelString() {
    return _prefs.getString("users");
  }

  Future<void> removeUser() async {
    await _prefs.remove("users");
  }
}
