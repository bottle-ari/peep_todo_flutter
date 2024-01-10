import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/data/palette_controller.dart';
import 'package:peep_todo_flutter/app/controllers/data/pref_controller.dart';
import 'package:peep_todo_flutter/app/controllers/main/main_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_controller.dart';
import 'package:peep_todo_flutter/app/theme/app_theme.dart';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';

class MyPageController extends BaseController with PrefController {
  final MainController mainController = Get.find();
  final PaletteController paletteController = Get.find();

  final keySelectedFont = 'selectedFont';
  final keyStartingDayOfWeek = 'startingDayOfWeek';
  final keySelectedColorInx = 'selectedPrimaryColorIndex';

  // 기본 요일
  late final RxString startingDayOfWeek;
  final Rx<StartingDayOfWeek> startingDayOfWeekValue =
      StartingDayOfWeek.monday.obs;

  MyPageController() {
    startingDayOfWeek = getString(keyStartingDayOfWeek)?.obs ?? "monday".obs;
  }

  // 피드백 페이지 텍스트 컨트롤러
  final TextEditingController textEditingController = TextEditingController();
  RxString feedbackText = ''.obs;

  @override
  void onInit() async {
    super.onInit();

    ever(mainController.selectedFont, (String font) {
      Get.changeTheme(Themes().getThemeByFont(font: font));
    });
  }

  Color getPrimaryColor() {
    return paletteController.getPriorityColor();
  }

  String getFont() {
    String getStr = getString(keySelectedFont) ?? 'Pretendard';
    log("getFont {$getStr}");
    mainController.selectedFont.value = getStr;
    return mainController.selectedFont.value;
  }

  // 사용자가 폰트를 선택하면 저장합니다.
  Future<void> setSelectedFont(String font) async {
    mainController.selectedFont.value = font;
    saveString(keySelectedFont, font);
    log(mainController.selectedFont.value);
  }

  // 피드백 텍스트 초기화
  void initFeedbackText() {
    textEditingController.clear();
  }

  // 피드백 전송
  Future<void> sendFeedbackText() async {
    const String feedbackApiUrl = 'https://peeptodo.com/api/feedback';

    final Map<String, String> feedbackData = {
      'contents': textEditingController.text,
      'date_time': DateTime.now().toString()
    };

    try {
      final response = await http.post(
        Uri.parse(feedbackApiUrl),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(feedbackData),
      );

      if (response.statusCode == 200) {
        // Successfully sent feedback
        log('Feedback sent successfully');
        Get.back();
        Get.snackbar('피드백 알림', '피드백을 전송했어요!');
      } else {
        // Handle the error response
        log('Error: ${response.statusCode} - ${response.body}');
        Get.snackbar('피드백 알림', '에러가 발생했습니다.');
      }
    } catch (e) {
      // Handle any exceptions that occurred during the request
      log('Error: $e');
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
    await paletteController.updatePriorityColor(0);
    Get.changeTheme(Themes().getThemeByFont(color: getPrimaryColor()));
  }

  // 사용자가 시작 요일을 선택하면 저장하고 적용합니다.
  Future<void> setStartingDayOfWeek(String day) async {
    startingDayOfWeek.value = day;
    saveString(keyStartingDayOfWeek, day);
    log("${startingDayOfWeek.value}");
  }

  StartingDayOfWeek getStartingDayOfWeek(String day) {
    switch (day.toLowerCase()) {
      case 'monday':
        return StartingDayOfWeek.monday;
      case 'tuesday':
        return StartingDayOfWeek.tuesday;
      case 'wednesday':
        return StartingDayOfWeek.wednesday;
      case 'thursday':
        return StartingDayOfWeek.thursday;
      case 'friday':
        return StartingDayOfWeek.friday;
      case 'saturday':
        return StartingDayOfWeek.saturday;
      case 'sunday':
        return StartingDayOfWeek.sunday;
      default:
        return StartingDayOfWeek.monday;
    }
  }
}
