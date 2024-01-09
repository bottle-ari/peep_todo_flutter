import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/animation/peep_category_toggle_button_controller.dart';
import 'package:peep_todo_flutter/app/controllers/data/category_controller.dart';
import 'package:peep_todo_flutter/app/controllers/data/palette_controller.dart';
import 'package:peep_todo_flutter/app/controllers/data/todo_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_controller.dart';
import 'package:peep_todo_flutter/app/data/enums/todo_enum.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';

import '../../data/model/category/category_model.dart';

class CategoryDetailController extends BaseController {
  final PaletteController _paletteController = Get.find();
  final CategoryController _categoryController = Get.find();
  final TodoController _todoController = Get.find();
  final PeepCategoryToggleButtonController _animationController =
      Get.find(tag: Get.arguments['category_id']);
  final String categoryId = Get.arguments['category_id'];
  final Rx<CategoryModel> category = CategoryModel(
          id: 'default',
          name: '',
          color: 0,
          emoji: '',
          type: TodoType.scheduled,
          isActive: true,
          pos: -1)
      .obs;

  final Rx<TodoType> todoType = TodoType.scheduled.obs;
  final RxBool isTypeChanged = false.obs;

  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  Future<void> onInit() async {
    super.onInit();

    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        onEditingDone();
      }
    });

    await loadCategory();
    todoType.value = category.value.type;
    textEditingController.text = category.value.name;
  }

  @override
  void onClose() {
    confirmToggleTodoType();
    focusNode.dispose();
    textEditingController.dispose();
    super.onClose();
  }

  /*
    Init Functions
   */

  Future<void> loadCategory() async {
    category.value =
        _categoryController.getCategoryById(categoryId: categoryId);
  }

  /*
    Read Functions
   */
  Color getColor() {
    return _paletteController.getDefaultPalette()[category.value.color].color;
  }

  /*
    Update Functions
   */

  void toggleTodoType() {
    isTypeChanged.value = !isTypeChanged.value;

    switch (todoType.value) {
      case TodoType.scheduled:
        todoType.value = TodoType.constant;
        break;
      case TodoType.constant:
        todoType.value = TodoType.scheduled;
        break;
    }
  }

  void confirmToggleTodoType() {
    if (isTypeChanged.value) {
      _categoryController.toggleTodoType(categoryId);
      loadCategory();
      _todoController.toggleTodoType(categoryId: categoryId);
    }
  }

  Future<bool> toggleCategoryActiveState() async {
    var value = await _categoryController.toggleCategoryActiveState(categoryId);
    loadCategory();

    if (value) {
      _animationController.toggleAnimation();
    }

    return value;
  }

  void updateEmoji(String emoji) {
    _categoryController.updateEmoji(categoryId, emoji);
    loadCategory();
  }

  void updateColor(int color) {
    _categoryController.changeCategoryColor(categoryId, color);
    loadCategory();
  }

  void onEditingDone() {
    if (textEditingController.text != '') {
      _categoryController.updateText(categoryId, textEditingController.text);
    }
    loadCategory();
  }

  Future<bool> deleteCategory() async {
    return await _categoryController.deleteCategory(category: category.value);
  }
}
