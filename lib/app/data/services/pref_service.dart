import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  Future<SharedPreferences> get _instance async =>
      await SharedPreferences.getInstance();

  Future<void> saveData(String key, String value) async {
    final SharedPreferences prefs = await _instance;
    log('save $key : $value');
    prefs.setString(key, value);
  }

  Future<String?> loadData(String key) async {
    final SharedPreferences prefs = await _instance;
    return prefs.getString(key);
  }
}
