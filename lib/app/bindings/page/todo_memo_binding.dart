import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/todo_memo_controller.dart';

class TodoMemoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TodoMemoController>(() {
      return TodoMemoController();
    });
  }
}