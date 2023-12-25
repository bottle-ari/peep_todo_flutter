import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:peep_todo_flutter/app/core/base/base_controller.dart';
import 'package:uuid/uuid.dart';

import '../../data/model/diary/diary_model.dart';
import '../data/diary_controller.dart';
import '../data/todo_controller.dart';

class DiaryEditController extends BaseController {
  final TodoController _todoController = Get.find();
  final DiaryController _controller = Get.find();

  late final RxString date;

  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  DiaryEditController() {
    date = DateFormat('yyyy년 MM월 dd일')
        .format(_todoController.selectedDate.value)
        .obs;
  }

  @override
  void onInit() {
    textEditingController.text = _controller.diaryData.value.memo;

    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        onEditingDone();
      }
    });

    super.onInit();
  }

  @override
  void onClose() {
    textEditingController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  void clearText() {
    textEditingController.text = '';

    var diary = _controller.diaryData.value;

    diary.memo = '';

    _controller.updateDiary(diary: diary);
  }

  void onEditingDone() {
    var diary = _controller.diaryData.value;

    diary.memo = textEditingController.text;

    _controller.updateDiary(diary: diary);
  }
}
