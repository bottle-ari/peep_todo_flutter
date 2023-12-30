import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/bindings/main/peep_main_toggle_button_binding.dart';
import 'package:peep_todo_flutter/app/bindings/page/diary_binding.dart';
import 'package:peep_todo_flutter/app/bindings/page/scheduled_todo_binding.dart';

import '../../controllers/main/main_controller.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() {
      return MainController();
    });

    PeepMainToggleButtonBinding().dependencies();
    ScheduledTodoBinding().dependencies();
    DiaryBinding().dependencies();
  }
}