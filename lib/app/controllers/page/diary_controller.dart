import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/core/base/base_controller.dart';

import '../data/todo_controller.dart';

class DiaryController extends BaseController {
  final TodoController _todoController = Get.find();

  DateTime getSelectedDate() {
    return _todoController.selectedDate.value;
  }

  void onMoveToday() {
    _todoController.onMoveToday();
  }
}
