import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper{
  static late SharedPreferences prefs;
  static const String keySelectedFont = 'selectedFont';


  static Future<void> init() async{
    prefs = await SharedPreferences.getInstance();
  }

  // 사용자가 선택한 폰트를 가져옵니다.
  static String getSelectedFont() {
    return prefs.getString(keySelectedFont) ?? "pretender";
  }

  // 사용자가 폰트를 선택하면 저장합니다.
  static Future<void> setSelectedFont(String font) async {
    await prefs.setString(keySelectedFont, font);
  }
}