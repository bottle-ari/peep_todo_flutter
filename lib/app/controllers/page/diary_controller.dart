import 'dart:developer';

import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/data/category_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_controller.dart';
import 'package:peep_todo_flutter/app/data/model/todo/todo_model.dart';

import '../../data/model/diary/diary_model.dart';
import '../../data/model/diary/diary_todo_model.dart';
import '../data/todo_controller.dart';

class DiaryController extends BaseController {
  final TodoController _todoController = Get.find();
  final CategoryController _categoryController = Get.find();

  final RxList<DiaryTodoModel> checkedTodo = <DiaryTodoModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    ever(_todoController.selectedTodoList, (callback) {
      updateCheckedTodoList();
    });

    updateCheckedTodoList();
  }

  /* Init Functions */
  void updateCheckedTodoList() async {
    List<DiaryTodoModel> newCheckTodo = [];

    log('start');

    for (var todo in _todoController.selectedTodoList) {
      if(todo.isChecked) {
        newCheckTodo.add(DiaryTodoModel(
            name: todo.name,
            color: _categoryController
                .getCategoryById(categoryId: todo.categoryId)
                .color));
      }
    }

    log('${newCheckTodo.length}');

    checkedTodo.value = newCheckTodo;
  }

  DateTime getSelectedDate() {
    return _todoController.selectedDate.value;
  }

  void onMoveToday() {
    _todoController.onMoveToday();
  }
}
