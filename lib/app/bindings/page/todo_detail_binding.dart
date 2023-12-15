import 'package:get/get.dart';

import '../../controllers/data/todo_detail_controller.dart';


class TodoDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TodoDetailController>(() {
      return TodoDetailController();
    });
  }
}