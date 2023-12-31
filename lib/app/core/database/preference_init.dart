import 'package:shared_preferences/shared_preferences.dart';

class GlobalPreferences {
  static late SharedPreferences _prefs;
  static bool _initialized = false;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _initialized = true;
  }

  static SharedPreferences get instance {
    if (!_initialized) {
      throw Exception("GlobalPreferences not initialized");
    }
    return _prefs;
  }
}
