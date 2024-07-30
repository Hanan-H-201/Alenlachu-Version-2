import 'package:shared_preferences/shared_preferences.dart';

class LoginManager {
  static const String _rolekey = 'role';
  static const String _token = 'usertoken';

  static Future<String?> getUserRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_rolekey);
  }

  static Future<void> saveUserRole(String role) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_rolekey, role);
  }

  static Future<void> saveUserToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_token, token);
  }

  static Future<String?> getUserToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_token);
  }

  static Future<void> removeToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_token);
  }

  static Future<void> clearStorages() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
