import 'package:get/get.dart';

import '../../controllers/page/selected_todo_controller.dart';

class SelectedTodoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectedTodoController>(() {
      return SelectedTodoController();
    });
  }
}