import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/data/category_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_controller.dart';
import 'package:peep_todo_flutter/app/data/enums/todo_enum.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';

import '../../data/model/category/category_model.dart';
import '../../utils/device_util.dart';

class CategoryDetailController extends BaseController {
  final CategoryController _categoryController = Get.find();
  final String categoryId = Get.arguments['category_id'];
  final Rx<CategoryModel> category = CategoryModel(
          id: 'default',
          name: '',
          color: Palette.peepBlack,
          emoji: '',
          type: TodoType.scheduled,
          isActive: true,
          pos: -1)
      .obs;

  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();

    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        onEditingDone();
      }
    });

    loadCategory();
    textEditingController.text = category.value.name;
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

  void loadCategory() {
    category.value =
        _categoryController.getCategoryById(categoryId: categoryId);
  }

  /*
    Update Functions
   */

  void toggleTodoType() {
    _categoryController.toggleTodoType(categoryId);
    loadCategory();
  }

  Future<bool> toggleCategoryActiveState() async {
    var value = await _categoryController.toggleCategoryActiveState(categoryId);
    loadCategory();

    return value;
  }

  void updateEmoji(String emoji) {
    _categoryController.updateEmoji(categoryId, emoji);
    loadCategory();
  }

  void updateColor(Color color) {
    _categoryController.changeCategoryColor(categoryId, color);
    loadCategory();
  }

  void onEditingDone() {
    if(textEditingController.text != '') {
      _categoryController.updateText(categoryId, textEditingController.text);
    }
    loadCategory();
  }

  void deleteCategory() {
    _categoryController.deleteCategory(category: category.value);
  }
}
