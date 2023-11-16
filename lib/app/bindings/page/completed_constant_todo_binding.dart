import 'package:get/get.dart';

import '../../controllers/page/completed_constant_todo_controller.dart';

class CompletedConstantTodoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompletedConstantTodoController>(() {
      return CompletedConstantTodoController();
    });
  }
}