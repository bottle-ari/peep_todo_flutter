import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/data/palette_controller.dart';
import 'package:peep_todo_flutter/app/controllers/data/pref_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_controller.dart';
import 'package:peep_todo_flutter/app/theme/app_theme.dart';
import 'package:http/http.dart' as http;

class MyPageController extends BaseController with PrefController {
  final PaletteController paletteController = Get.find();
  final keySelectedFont = 'selectedFont';
  final keySelectedColorInx = 'selectedPrimaryColorIndex';

  // 기본 폰트
  //RxString selectedFont = "LeeSeoyun".obs;
  late final RxString selectedFont;

  MyPageController() {
    selectedFont = getString(keySelectedFont)?.obs ?? "Pretendard".obs;
    log("conductor selectedFont {${selectedFont.value}}");
  }

  // 피드백 페이지 텍스트 컨트롤러
  final TextEditingController textEditingController = TextEditingController();
  RxString feedbackText = ''.obs;

  @override
  void onInit() async {
    super.onInit();

    selectedFont.value = getString(keySelectedFont) ?? 'Pretendard';
    ever(selectedFont, (String font) {
      Get.changeTheme(Themes().getThemeByFont(font: font));
    });
  }

  Color getPrimaryColor() {
    return paletteController.getPriorityColor();
  }

  String getFont() {
    String getStr = getString(keySelectedFont) ?? 'Pretendard';
    log("getFont {$getStr}");
    selectedFont.value = getStr;
    return selectedFont.value;
  }

  // 사용자가 폰트를 선택하면 저장합니다.
  Future<void> setSelectedFont(String font) async {
    selectedFont.value = font;
    saveString(keySelectedFont, font);
    log("${selectedFont.value}");
  }

  // 피드백 텍스트 초기화
  void initFeedbackText() {
    textEditingController.clear();
  }

  // 피드백 전송
  Future<void> sendFeedbackText() async {
    final String feedbackApiUrl = 'https://peeptodo.com/api/feedback';

    final Map<String, String> feedbackData = {
      'contents': textEditingController.text,
      'date_time': DateTime.now().toString()
    };

    try {
      final response = await http.post(
        Uri.parse(feedbackApiUrl),
        headers: {
          'Authorization':
              'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJtb2Rlc3R5NjY2QGcuaG9uZ2lrLmFjLmtyIiwiaWF0IjoxNzA0MzUwMTg1LCJleHAiOjE3MDQ1MjI5ODV9.87o7NNNKOLEM7adkt_gBQ1loZH62NbzvrjW-ZHcZ1zhFytQen2RCPVIjJOeAXZ_TZIE6gYl4E5-yd90bzqoBQQ',
        },
        body: feedbackData,
      );

      if (response.statusCode == 200) {
        // Successfully sent feedback
        print('Feedback sent successfully');
      } else {
        // Handle the error response
        print('Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      // Handle any exceptions that occurred during the request
      print('Error: $e');
    }
  }

  /*
    Palette Theme Functions
   */
  int getPrimaryColorIndex() {
    return paletteController.selectedPrimaryColor.value;
  }

  int getPaletteIndex() {
    return paletteController.getSelectedPaletteIndex();
  }

  void updatePrimaryColor(int inx) async {
    await paletteController.updatePriorityColor(inx);
    Get.changeTheme(Themes().getThemeByFont(color: getPrimaryColor()));
  }

  void updatePalette(String name) async {
    await paletteController.updatePalette(name);
    Get.changeTheme(Themes().getThemeByFont(color: getPrimaryColor()));
  }
}

class ThemeChanger extends InheritedWidget {
  final MyPageController myPageController;

  ThemeChanger(
      {Key? key, required this.myPageController, required Widget child})
      : super(key: key, child: child);

  static ThemeChanger of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeChanger>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false; // We don't need to rebuild when the data changes
  }
}
