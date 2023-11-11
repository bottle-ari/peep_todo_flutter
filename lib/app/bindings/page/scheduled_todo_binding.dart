import 'package:get/get.dart';

import '../../controllers/page/scheduled_todo_controller.dart';

class ScheduledTodoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScheduledTodoController>(() {
      return ScheduledTodoController();
    });
  }
}