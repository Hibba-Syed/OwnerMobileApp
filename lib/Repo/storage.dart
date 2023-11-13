import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  late final SharedPreferences _prefs;
  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setAuthenticationModelString(String value) async {
    return await _prefs.setString("authenticationModel", value);
  }

  Future<bool> setIsNewDeviceString(String value) async {
    return await _prefs.setString("device", value);
  }

  String? getIsNewDeviceString() {
    return _prefs.getString("device");
  }

  String? getAuthenticationModelString() {
    return _prefs.getString("authenticationModel");
  }

  Future<void> removeUser() async {
    await _prefs.remove("authenticationModel");
  }
}
