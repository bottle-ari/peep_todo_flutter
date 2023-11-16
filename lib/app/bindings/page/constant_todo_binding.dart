import 'package:get/get.dart';

import '../../controllers/page/constant_todo_controller.dart';

class ConstantTodoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConstantTodoController>(() {
      return ConstantTodoController();
    });
  }
}