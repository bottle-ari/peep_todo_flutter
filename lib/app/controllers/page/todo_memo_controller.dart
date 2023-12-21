import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/todo_detail_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_controller.dart';

class TodoMemoController extends BaseController {
  final TodoDetailController _todoDetailController = Get.find();

  String oldText = Get.arguments['text'] ?? '';
  final Color color = Get.arguments['color'];

  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();

    textEditingController.text = oldText;

    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        onEditingDone();
      }
    });
  }

  void clearText() {
    oldText = '';
    textEditingController.text = '';
  }

  void onEditingDone() {
    _todoDetailController.updateMemo(textEditingController.text);
  }
}