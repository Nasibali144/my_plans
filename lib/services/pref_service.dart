import 'package:shared_preferences/shared_preferences.dart';

class Prefs {

  static Future<bool> saveUserId(String userId) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.setString('userId', userId);
  }

  static Future<String> loadUserId() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  static Future<bool> removeUserId() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.remove('userId');
  }
}