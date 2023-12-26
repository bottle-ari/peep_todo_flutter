import 'package:get/get.dart';

import '../../controllers/page/todo_detail_controller.dart';


class TodoDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TodoDetailController>(() {
      return TodoDetailController();
    });
  }
}