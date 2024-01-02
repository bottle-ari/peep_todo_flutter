import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/routine_manage_controller.dart';

class RoutineManageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoutineManageController>(() {
      return RoutineManageController();
    });
  }
}