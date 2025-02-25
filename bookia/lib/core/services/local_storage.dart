import 'package:shared_preferences/shared_preferences.dart';

class AppLocalStorage {
  static late SharedPreferences _preferences;
  static init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static void cacheData(String key, value) {
    if (value is int) {
      _preferences.setInt(key, value);
    } else if (value is String) {
      _preferences.setString(key, value);
    } else if (value is bool) {
      _preferences.setBool(key, value);
    } else {
      _preferences.setDouble(key, value);
    }
  }

  static dynamic getData(String key) {
    return _preferences.get(key);
  }
}
