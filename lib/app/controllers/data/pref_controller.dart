import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/core/database/preference_init.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin PrefController {
  SharedPreferences get prefs => GlobalPreferences.instance;

  Future<void> saveString(String key, String value) async {
    await prefs.setString(key, value);
  }

  String? getString(String key) {
    return prefs.getString(key);
  }

  Future<void> saveInt(String key, int value) async {
    await prefs.setInt(key, value);
  }

  int? getInt(String key) {
    return prefs.getInt(key);
  }
}
