import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/routine_add_controller.dart';

class RoutineAddBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoutineAddController>(() {
      return RoutineAddController();
    });
  }
}