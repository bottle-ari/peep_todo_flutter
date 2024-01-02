import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:peep_todo_flutter/app/controllers/data/category_controller.dart';
import 'package:peep_todo_flutter/app/controllers/data/todo_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_controller.dart';

import '../../data/enums/todo_enum.dart';
import '../../data/model/category/category_model.dart';
import '../../data/model/todo/todo_model.dart';

class TodoDetailController extends BaseController {
  final TodoController todoController = Get.find();
  final CategoryController categoryController = Get.find();

  late final Rx<TodoModel> todo;
  late final Rx<TodoType> todoType;
  late final Rx<CategoryModel> category;

  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  TodoDetailController() {
    TodoModel todoModel = Get.arguments['todo'] as TodoModel;
    todo = todoModel.obs;
    TodoType todoTypeData = Get.arguments['type'] as TodoType;
    todoType = todoTypeData.obs;
    category = categoryController
        .getCategoryById(categoryId: todo.value.categoryId)
        .obs;
  }

  @override
  void onInit() {
    textEditingController.text = todo.value.name;

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

  void updateDate(DateTime date) {
    TodoModel newTodo = TodoModel(
        id: todo.value.id,
        categoryId: todo.value.categoryId,
        reminderId: todo.value.reminderId,
        name: todo.value.name,
        date: date,
        priority: todo.value.priority,
        memo: todo.value.memo,
        isChecked: todo.value.isChecked,
        pos: todo.value.pos,
        checkTime: todo.value.checkTime);

    todoController.updateTodos(todoList: [newTodo]);

    todo.value = newTodo;
  }

  void updateCategory(CategoryModel newCategory) {
    TodoModel newTodo;
    if (newCategory.type != todoType.value) {
      if(newCategory.type == TodoType.scheduled) {
        newTodo = TodoModel(
            id: todo.value.id,
            categoryId: newCategory.id,
            reminderId: todo.value.reminderId,
            name: todo.value.name,
            date: DateTime.now(),
            priority: todo.value.priority,
            memo: todo.value.memo,
            isChecked: todo.value.isChecked,
            pos: 0,
            checkTime: todo.value.checkTime);

        todoType.value = TodoType.scheduled;
      } else {
        newTodo = TodoModel(
            id: todo.value.id,
            categoryId: newCategory.id,
            reminderId: todo.value.reminderId,
            name: todo.value.name,
            date: null,
            priority: todo.value.priority,
            memo: todo.value.memo,
            isChecked: todo.value.isChecked,
            pos: 0,
            checkTime: todo.value.checkTime);

        todoType.value = TodoType.constant;
      }
    } else {
      newTodo = TodoModel(
          id: todo.value.id,
          categoryId: newCategory.id,
          reminderId: todo.value.reminderId,
          name: todo.value.name,
          date: todo.value.date,
          priority: todo.value.priority,
          memo: todo.value.memo,
          isChecked: todo.value.isChecked,
          pos: 0,
          checkTime: todo.value.checkTime);
    }

    todoController.updateTodos(todoList: [newTodo]);
    todo.value = newTodo;
    loadCategory();
  }

  void toggleMainTodoChecked({required TodoType type, required String todoId}) {
    todoController.toggleMainTodoChecked(type: type, todoId: todoId);

    TodoModel newTodo = TodoModel(
        id: todo.value.id,
        categoryId: todo.value.categoryId,
        reminderId: todo.value.reminderId,
        name: todo.value.name,
        date: todo.value.date,
        priority: todo.value.priority,
        memo: todo.value.memo,
        isChecked: !todo.value.isChecked,
        pos: todo.value.pos,
        checkTime: todo.value.checkTime);

    todo.value = newTodo;
  }

  bool isOverdue() {
    final now = DateTime.now();
    return todo.value.date?.isBefore(DateTime(now.year, now.month, now.day)) ??
        false;
  }

  void loadCategory() {
    category.value =
        categoryController.getCategoryById(categoryId: todo.value.categoryId);
  }

  String getDateString() {
    if (todoType.value == TodoType.constant) {
      return '상시 Todo';
    } else {
      if (todo.value.date!.year != DateTime.now().year) {
        return DateFormat('yyyy년 MM월 dd일').format(todo.value.date!);
      } else {
        return DateFormat('MM월 dd일').format(todo.value.date!);
      }
    }
  }

  void onEditingDone() {
    if (textEditingController.text != '') {
      TodoModel newTodo = TodoModel(
          id: todo.value.id,
          categoryId: todo.value.categoryId,
          reminderId: todo.value.reminderId,
          name: textEditingController.text,
          date: todo.value.date,
          priority: todo.value.priority,
          memo: todo.value.memo,
          isChecked: todo.value.isChecked,
          pos: todo.value.pos,
          checkTime: todo.value.checkTime);

      todoController.updateTodos(todoList: [newTodo]);

      todo.value = newTodo;
    }
  }

  void updateMemo(String memo) {
    TodoModel newTodo = TodoModel(
        id: todo.value.id,
        categoryId: todo.value.categoryId,
        reminderId: todo.value.reminderId,
        name: todo.value.name,
        date: todo.value.date,
        priority: todo.value.priority,
        memo: memo,
        isChecked: todo.value.isChecked,
        pos: todo.value.pos,
        checkTime: todo.value.checkTime);

    todoController.updateTodos(todoList: [newTodo]);

    todo.value = newTodo;
  }
}
