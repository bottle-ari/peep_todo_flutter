import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/data/model/category/backup_category_model.dart';
import 'package:peep_todo_flutter/app/data/model/category/category_model.dart';
import 'package:peep_todo_flutter/app/data/services/category_service.dart';

import '../../core/base/base_controller.dart';
import '../../data/enums/todo_enum.dart';

class CategoryController extends BaseController {
  final CategoryService _service = Get.put(CategoryService());

  // Data
  final RxList<CategoryModel> categoryList = <CategoryModel>[].obs;

  // Variables
  BackupCategoryModel? backup;

  @override
  void onInit() {
    super.onInit();
    loadCategoryData();
  }

  /*
    Init Functions
   */
  void loadCategoryData() async {
    var data = await _service.getCategoryAll();
    categoryList.value = data;
  }

  /*
    Create Functions
   */
  void addCategory({required CategoryModel category}) async {
    await _service.insertCategory(category: category);

    loadCategoryData();
  }

  void rollbackCategory() async {
    if (backup == null) return;

    await _service.insertCategory(category: backup!.backupCategoryItem);

    loadCategoryData();
  }

  /*
    Read Functions
   */
  CategoryModel getCategoryById({required String categoryId}) {
    return categoryList.firstWhere((element) => element.id == categoryId);
  }

  Future<CategoryModel> getCategoryByIdAsync({required String categoryId}) async {
    return await _service.getCategoryById(categoryId: categoryId);
  }

  /*
    Update Functions
   */
  void reorderCategoryList(int oldIndex, int newIndex) async {
    if (oldIndex == newIndex) return;

    var list = categoryList;
    final CategoryModel categoryItem = list.removeAt(oldIndex);

    list.insert(newIndex, categoryItem);
    categoryList.value = List.from(list);

    int newPos = 0;
    for (var category in categoryList) {
      category.pos = newPos;
      newPos++;
    }

    await _service.updateCategories(categoryList);

    update();
  }

  void changeCategoryColor(String categoryId, Color newColor) async {
    CategoryModel category = categoryList.firstWhere((e) => e.id == categoryId);

    category.color = newColor;

    await _service.updateCategory(category);

    loadCategoryData();
  }

  Future<bool> toggleCategoryActiveState(String categoryId) async {
    CategoryModel category = categoryList.firstWhere((e) => e.id == categoryId);

    if (category.isActive &&
        categoryList.where((e) => e.isActive).length <= 1) {
      return false;
    }

    category.isActive = !category.isActive;

    await _service.updateCategory(category);

    loadCategoryData();

    return true;
  }

  void toggleTodoType(String categoryId) async {
    CategoryModel category = categoryList.firstWhere((e) => e.id == categoryId);

    switch (category.type) {
      case TodoType.scheduled:
        category.type = TodoType.constant;

        break;
      case TodoType.constant:
        category.type = TodoType.scheduled;
        break;
    }

    await _service.updateCategory(category);

    loadCategoryData();
  }

  void updateEmoji(String categoryId, String newEmoji) async {
    CategoryModel category = categoryList.firstWhere((e) => e.id == categoryId);

    category.emoji = newEmoji;
    await _service.updateCategory(category);

    loadCategoryData();
  }

  void updateText(String categoryId, String text) async {
    CategoryModel category = categoryList.firstWhere((e) => e.id == categoryId);

    category.name = text;
    await _service.updateCategory(category);

    loadCategoryData();
  }

  /*
    Delete Functions
   */
  Future<void> deleteCategory({required CategoryModel category}) async {
    //TODO : 모든 todo를 함께 삭제해야 합니다.
    await _service.deleteCategory(category.id);

    backup = BackupCategoryModel(
        backupCategoryItem: category, backupIndex: category.pos);

    loadCategoryData();
  }
}
