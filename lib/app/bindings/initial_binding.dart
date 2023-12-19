//앱 시작시 필요한 의존성
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/data/category_controller.dart';
import 'package:peep_todo_flutter/app/controllers/data/routine_controller.dart';

import '../controllers/data/pref_controller.dart';
import '../controllers/data/todo_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryController>(() => CategoryController(), fenix: true);
    Get.lazyPut<TodoController>(() => TodoController(), fenix: true);
    Get.lazyPut<PrefController>(() => PrefController(), fenix: true);
    Get.lazyPut<RoutineController>(() => RoutineController(), fenix: true);
  }
}
