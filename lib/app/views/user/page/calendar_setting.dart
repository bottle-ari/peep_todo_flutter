import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/my_page_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_view.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/common/peep_subpage_appbar.dart';

class CalendarSetting extends BaseView<MyPageController> {
  // 사용 가능한 폰트 리스트
  static const List<String> availableDay = [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday',
  ];

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(AppValues.appbarHeight),
        child: SafeArea(
          child: PeepSubpageAppbar(
              title: '시작 요일 설정',
              onTapBackArrow: () {
                Get.back();
              }),
        ));
  }

  @override
  Widget body(BuildContext context) {
    return ListView.builder(
      itemCount: availableDay.length,
      itemBuilder: (context, index) {
        String day = availableDay[index];
        return ListTile(
          title: Text(day, style: PeepTextStyle.boldM()),
          onTap: () {
            log("font setting {$day}");
            controller.setStartingDayOfWeek(day);
          },
        );
      },
    );
  }
}
