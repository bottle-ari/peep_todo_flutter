import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/overdue_todo_controller.dart';

class OverdueTodoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OverdueTodoController>(() {
      return OverdueTodoController();
    });
  }
}