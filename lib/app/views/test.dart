import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/todo_controller.dart';
import 'package:peep_todo_flutter/app/controllers/week_calendar_controller.dart';
import 'package:peep_todo_flutter/app/data/mock_data.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/views/common/peep_dropdown_menu.dart';
import 'package:peep_todo_flutter/app/views/main/widget/peep_scheduled_todo_app_bar.dart';
import 'package:peep_todo_flutter/app/views/todo/widget/peep_mini_calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'common/todo/peep_todo_list.dart';

class TestController extends GetxController {
  // 위젯 구현 및 테스트 중, 상위 컨트롤러가 필요하다면 여기에서 간단하게 구현하여 사용하세요.
  Rx<Color> color = Palette.peepYellow400.obs;
  RxBool isChecked = false.obs;
  RxBool isMain = true.obs;
  RxBool isOpen = false.obs;

  void toggleChecked() {
    isOpen.value = !isOpen.value;
  }
}

class Test extends StatelessWidget {
  Test({super.key});

  final TestController controller = Get.put(TestController());

  @override
  Widget build(BuildContext context) {
    return PeepMiniCalendar();
  }
}
