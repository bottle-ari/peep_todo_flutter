import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/todo_detail_controller.dart';


class TodoDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TodoDetailController>(() {
      return TodoDetailController();
    });
  }
}