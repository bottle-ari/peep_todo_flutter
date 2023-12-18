import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/data/category_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_controller.dart';
import 'package:peep_todo_flutter/app/data/enums/todo_enum.dart';
import 'package:peep_todo_flutter/app/data/model/palette/palette_model.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:uuid/uuid.dart';

import '../../data/model/category/category_model.dart';
import '../../utils/device_util.dart';

class CategoryAddController extends BaseController {
  final CategoryController _categoryController = Get.find();
  final int lastPos = Get.arguments['lastPos'];

  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  final Rx<TodoType> todoType = TodoType.scheduled.obs;
  final RxBool isActive = true.obs;
  final RxString emoji = '🤔'.obs;
  final Rx<Color> color = defaultPalette.primaryColor.color.obs;

  @override
  void onInit() {
    super.onInit();

    initRandomColor();
  }

  @override
  void onClose() {
    focusNode.dispose();
    textEditingController.dispose();
    super.onClose();
  }

  /*
    Init Functions
   */
  void initRandomColor() {
    color.value = defaultPalette
        .colors[Random().nextInt(defaultPalette.colors.length)].color;
  }

  /*
    Update Functions
   */

  void toggleTodoType() {
    switch (todoType.value) {
      case TodoType.scheduled:
        todoType.value = TodoType.constant;
        break;
      case TodoType.constant:
        todoType.value = TodoType.scheduled;
        break;
    }
  }

  void toggleCategoryActiveState() {
    isActive.value = !isActive.value;
  }

  void updateEmoji(String newEmoji) {
    emoji.value = newEmoji;
  }

  void updateColor(Color newColor) {
    color.value = newColor;
  }

  bool onConfirm() {
    if(textEditingController.text == '') {
      return false;
    }

    var uuid = const Uuid();
    String newUuid = uuid.v4();

    _categoryController.addCategory(
        category: CategoryModel(
            id: newUuid,
            name: textEditingController.text,
            color: color.value,
            emoji: emoji.value,
            type: todoType.value,
            isActive: isActive.value,
            pos: lastPos));

    return true;
  }
}
