import 'dart:convert';

import 'package:iskaanowner/Utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  late final SharedPreferences _pref;
  Future<StorageService> init() async {
    _pref = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setAuthenticationModelString(LoginModel? value,
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
      return await _pref.setString("users", jsonEncode(users));
    }
    return await _pref.setString("users", jsonEncode([value]));
  }

  Future<bool> setAuthenticationModelListString(
    String value,
  ) async {
    return await _pref.setString("users", value);
  }

  Future<bool> removeAuthenticationModelString({required int index}) async {
    String? userList = getAuthenticationModelString();
    if (userList != null) {
      List users = jsonDecode(userList);
      users.removeAt(index);
      return await _pref.setString("users", jsonEncode(users));
    }
    return false;
  }

  Future<bool> setLoginCreds(List creds) async {
    return await _pref.setString("creds", jsonEncode(creds));
  }

  Future<bool> setAppLogo(String logo) async {
    return await _pref.setString("logo", logo);
  }

  Future<bool> setNewDevice() async {
    return await _pref.setString("newDevice", "false");
  }

  Future<bool> setAppTheme(String theme) async {
    return await _pref.setString("theme", theme);
  }

  String? getAppLogo() {
    return _pref.getString("logo");
  }

  String? getAppTheme() {
    return _pref.getString("theme");
  }

  List? getLoginCreds() {
    String? creds = _pref.getString("creds");
    if (creds == null) {
      return null;
    }
    return jsonDecode(creds);
  }

  String? getAuthenticationModelString() {
    return _pref.getString("users");
  }

  String? getNewDevice() {
    return _pref.getString("newDevice");
  }

  Future<void> removeUser() async {
    await _pref.remove("users");
  }
}
