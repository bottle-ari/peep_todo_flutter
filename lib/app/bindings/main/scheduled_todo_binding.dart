import 'package:get/get.dart';

import '../../controllers/todo_controller.dart';

class ScheduledTodoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TodoController>(() {
      return TodoController();
    });
  }
}