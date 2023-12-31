import 'package:get/get.dart';

import '../../controllers/page/selected_todo_controller.dart';

class ScheduledTodoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectedTodoController>(() {
      return SelectedTodoController();
    });
  }
}