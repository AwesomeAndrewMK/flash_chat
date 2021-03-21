import 'package:shared_preferences/shared_preferences.dart';

abstract class ThemeValue {
  static bool value = false;

  static Future<void> getValue() async {
    var prefs = await SharedPreferences.getInstance();
    value = prefs.getBool('value') ?? false;
  }

  static Future<void> toggleThemeValue() async {
    var prefs = await SharedPreferences.getInstance();
    var value = prefs.getBool('value') ?? false;
    await prefs.setBool('value', !value);
  }
}
