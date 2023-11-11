import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/bindings/page/scheduled_todo_binding.dart';

import '../controllers/main/main_controller.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() {
      return MainController();
    });

    ScheduledTodoBinding().dependencies();
  }
}