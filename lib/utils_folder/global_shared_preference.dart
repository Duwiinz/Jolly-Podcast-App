import 'package:shared_preferences/shared_preferences.dart';

class GlobalSharedPreference {
  static set({required String key, required String value}) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<String?> get({required String key}) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static delete({required String key}) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
