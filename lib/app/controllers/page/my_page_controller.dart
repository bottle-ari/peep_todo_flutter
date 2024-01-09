import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/data/pref_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_controller.dart';
import 'package:peep_todo_flutter/app/theme/app_theme.dart';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';

class MyPageController extends BaseController with PrefController {
  final keySelectedFont = 'selectedFont';
  final keyStartingDayOfWeek = 'startingDayOfWeek';
  // 기본 폰트
  late final RxString selectedFont;
  // 기본 요일
  late final RxString startingDayOfWeek;
  final Rx<StartingDayOfWeek> startingDayOfWeekValue = StartingDayOfWeek.monday.obs;

  MyPageController(){
    selectedFont = getString(keySelectedFont)?.obs ?? "Pretendard".obs;
    log("conductor selectedFont {${selectedFont.value}}");
    startingDayOfWeek = getString(keyStartingDayOfWeek)?.obs ?? "monday".obs;
  }


  // 피드백 페이지 텍스트 컨트롤러
  final TextEditingController textEditingController = TextEditingController();
  RxString feedbackText = ''.obs;

  @override
  void onInit() async {
    super.onInit();

    selectedFont.value = getString(keySelectedFont) ?? 'Pretendard';
    ever(selectedFont, (String font) {
      Get.changeTheme(Themes().getThemeByFont(font));
    });
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
          'Authorization': 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJtb2Rlc3R5NjY2QGcuaG9uZ2lrLmFjLmtyIiwiaWF0IjoxNzA0MzUwMTg1LCJleHAiOjE3MDQ1MjI5ODV9.87o7NNNKOLEM7adkt_gBQ1loZH62NbzvrjW-ZHcZ1zhFytQen2RCPVIjJOeAXZ_TZIE6gYl4E5-yd90bzqoBQQ',
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


