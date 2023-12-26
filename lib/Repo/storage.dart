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
      {bool addItInFront = false, bool newUser = false, int? index}) async {
    String? userList = getAuthenticationModelString();
    if (userList != null) {
      List users = jsonDecode(userList);
      if (addItInFront) {
        users.removeAt(index ?? 0);
        users.insert(0, value);
      } else if (newUser) {
        users.insert(0, value);
      } else {
        users.add(value);
      }
      return await _prefs.setString("users", jsonEncode(users));
    }
    return await _prefs.setString("users", jsonEncode([value]));
  }

  Future<bool> setLoginCreds(List creds) async {
    return await _prefs.setString("creds", jsonEncode(creds));
  }

  List? getLoginCreds() {
    String? creds = _prefs.getString("creds");
    if (creds == null) {
      return null;
    }
    return jsonDecode(creds);
  }

  String? getAuthenticationModelString() {
    return _prefs.getString("users");
  }

  Future<void> removeUser() async {
    await _prefs.remove("users");
  }
}
