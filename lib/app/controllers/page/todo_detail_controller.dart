import 'dart:ui';

import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/data/category_controller.dart';
import 'package:peep_todo_flutter/app/controllers/data/todo_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_controller.dart';

import '../../data/model/category/category_model.dart';
import '../../data/model/todo/todo_model.dart';

class TodoDetailController extends BaseController {
  final TodoController todoController = Get.find();
  final CategoryController categoryController = Get.find();

  late final Rx<TodoModel> todo;

  TodoDetailController() {
    TodoModel todoModel = Get.arguments['todo'] as TodoModel;
    todo = todoModel.obs;
  }

  void updatePriority(int index) {
    TodoModel newTodo = TodoModel(
        id: todo.value.id,
        categoryId: todo.value.categoryId,
        reminderId: todo.value.reminderId,
        name: todo.value.name,
        date: todo.value.date,
        priority: index,
        memo: todo.value.memo,
        isChecked: todo.value.isChecked,
        pos: todo.value.pos,
        checkTime: todo.value.checkTime);

    todoController.updateTodos(todoList: [newTodo]);

    todo.value = newTodo;
  }

  bool isOverdue() {
    final now = DateTime.now();
    return todo.value.date?.isBefore(DateTime(now.year, now.month, now.day)) ??
        false;
  }

  CategoryModel getCategory() {
    return categoryController.getCategoryById(
        categoryId: todo.value.categoryId);
  }

  Color getColor() {
    var category = categoryController.getCategoryById(categoryId: todo.value.categoryId);

    return category.color;
  }
}
