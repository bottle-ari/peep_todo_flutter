import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/todo_detail_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_controller.dart';

class TodoMemoController extends BaseController {
  final RxString memo = "뭔가를 적어야 한다".obs;

  void onSubmitted( newText ) {
    memo.value = newText;
    update();
  }
}