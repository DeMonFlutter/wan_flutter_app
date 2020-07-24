
import 'package:shared_preferences/shared_preferences.dart';

/// @author DeMon
/// Created on 2020/6/15.
/// E-mail 757454343@qq.com
/// Desc:
class SPUtils {
  static setData(String key, Object data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (data is int) {
      await prefs.setInt(key, data);
    } else if (data is double) {
      await prefs.setDouble(key, data);
    } else if (data is bool) {
      await prefs.setBool(key, data);
    } else if (data is List<String>) {
      await prefs.setStringList(key, data);
    } else {
      await prefs.setString(key, data);
    }
  }

  static Future<T> getData<T>(String key, T def) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (def is int) {
      return prefs.getInt(key) as T ?? def;
    } else if (def is double) {
      return prefs.getDouble(key) as T ?? def;
    } else if (def is bool) {
      return prefs.getBool(key) as T ?? def;
    } else if (def is List<String>) {
      return prefs.getStringList(key) as T ?? def;
    } else {
      return prefs.getString(key) as T ?? def;
    }
  }
}
