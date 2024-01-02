import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/core/base/base_controller.dart';
import 'package:peep_todo_flutter/app/data/provider/database/sharedpref_helper.dart';
import 'package:peep_todo_flutter/app/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPageController extends BaseController {
  String keySelectedFont = 'selectedFont';

  // 기본 폰트
  final RxString defaultFont = 'Pretendard'.obs;

  @override
  void onInint() async {
    super.onInit();
    final savedFont = SharedPrefHelper.getSelectedFont();
    Get.changeTheme(Themes().getThemeByFont(savedFont as String));
  }

  // 사용자가 선택한 폰트를 가져옵니다.
  static String getSelectedFont()  {
    return SharedPrefHelper.getSelectedFont() ;
  }

  // 사용자가 폰트를 선택하면 저장합니다.
  Future<void> setSelectedFont(String font) async {
    await SharedPrefHelper.setSelectedFont(font);
    update();
  }
}
