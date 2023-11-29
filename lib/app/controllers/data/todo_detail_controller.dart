import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/core/base/base_controller.dart';
import 'package:peep_todo_flutter/app/data/enums/priority.dart';

class TodoDetailController extends BaseController {
  final Rx<Priority> priority = Priority.unspecified.obs;
  final RxString text = "뭔가 적혀 있다".obs;

  void updatePriority(int index) {
    switch(index) {
      case 1:
        priority.value = Priority.low;
        break;
      case 2:
        priority.value = Priority.medium;
        break;
      case 3:
        priority.value = Priority.high;
        break;
      case 4:
        priority.value = Priority.show;
        break;
      default:
        priority.value = Priority.unspecified;
        break;
    }
  }
}