import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  final SharedPreferences _prefs;

  AppPreferences(this._prefs);

  static const _tokenKey = 'auth_token';

  /// SAVE TOKEN
  Future<void> saveToken(String token) async {
    await _prefs.setString(_tokenKey, token);
  }

  /// READ TOKEN
  String? get token => _prefs.getString(_tokenKey);

  /// CLEAR SESSION
  Future<void> clearSession() async {
    await _prefs.remove(_tokenKey);
  }
}

