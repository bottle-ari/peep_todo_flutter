import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/todo_controller.dart';
import 'package:peep_todo_flutter/app/controllers/week_calendar_controller.dart';
import 'package:peep_todo_flutter/app/data/mock_data.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/views/common/peep_dropdown_menu.dart';
import 'package:peep_todo_flutter/app/views/main/widget/peep_scheduled_todo_app_bar.dart';
import 'package:peep_todo_flutter/app/views/main/widget/peep_week_calendar_bar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'common/todo/peep_todo_list.dart';

class TestController extends GetxController {
  // 위젯 구현 및 테스트 중, 상위 컨트롤러가 필요하다면 여기에서 간단하게 구현하여 사용하세요.
  Rx<Color> color = Palette.peepGreen.obs;
}

class Test extends StatelessWidget {
  Test({super.key});

  final TestController controller = Get.put(TestController());
  final TodoController todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return PeepWeekCalendarBar(
      dropdownMenuItems: [
        DropdownMenuItemData(
            'popup_action_1',
            PeepIcon(Iconsax.addcircle,
                size: AppValues.smallIconSize, color: Palette.peepBlack),
            '카테고리 추가'),
        DropdownMenuItemData(
            'popup_action_2',
            PeepIcon(Iconsax.categorybox,
                size: AppValues.smallIconSize, color: Palette.peepBlack),
            '카테고리 관리'),
        DropdownMenuItemData(
            'popup_action_3',
            PeepIcon(Iconsax.reminder,
                size: AppValues.smallIconSize, color: Palette.peepBlack),
            '리마인더 관리'),
        DropdownMenuItemData(
            'popup_action_4',
            PeepIcon(Iconsax.routine,
                size: AppValues.smallIconSize, color: Palette.peepBlack),
            '루틴 추가'),
      ],
      onMenuItemSelected: (popupNum) {
        if (popupNum == 'popup_action_1') {
          onTapFunc() => print('1');
        } else if (popupNum == 'popup_action_2') {
          onTapSecondFunc() => print('2');
        } else if (popupNum == 'popup_action_3') {
          o3() => print('3');
        } else {
          o4() => print('4');
        }
      },
      onTapClock: () => print('123'),
    );
  }
}
