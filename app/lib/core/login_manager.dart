import 'package:shared_preferences/shared_preferences.dart';

class LoginManager {
  static const String _rolekey = 'userRole';
  static const String _userKey = 'user';

  Future<String?> getUserRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_rolekey);
  }

  Future<void> saveUserRole(String role) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_rolekey, role);
  }

  Future<void> clearStorages() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
