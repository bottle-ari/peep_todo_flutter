import 'dart:developer';

import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/data/enums/todo_enum.dart';
import 'package:peep_todo_flutter/app/data/services/todo_service.dart';

import '../data/model/todo/sub_todo_model.dart';
import '../data/model/todo/todo_model.dart';

class TodoController extends GetxController {
  final TodoService _service = TodoService();

  // Data
  final RxList<TodoModel> scheduledTodoList = <TodoModel>[].obs;
  final RxList<TodoModel> calendarTodoList = <TodoModel>[].obs;

  // Variables
  final Rx<DateTime> selectedDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();

    loadScheduledData();
    loadCalendarData();
  }

  /*
    Init Functions
   */
  void loadScheduledData() async {
    final DateTime startDate = DateTime(selectedDate.value.year, selectedDate.value.month, selectedDate.value.day);
    final DateTime endDate = startDate.add(const Duration(days: 1));

    var data = await _service.getScheduledTodoByDate(
        startDate: startDate, endDate: endDate);
    scheduledTodoList.value = data;
  }

  void loadCalendarData() async {
    final DateTime startDate =
        selectedDate.value.subtract(const Duration(days: 60));
    final DateTime endDate = selectedDate.value.add(const Duration(days: 60));

    var data = await _service.getScheduledTodoByDate(
        startDate: startDate, endDate: endDate);
    scheduledTodoList.value = data;
  }

  /*
    READ Functions
   */
  TodoModel getTodoById({required TodoType type, required int todoId}) {
    switch (type) {
      case TodoType.scheduled:
        return scheduledTodoList.firstWhere((e) => e.id == todoId);
      default:
        throw Exception('An unexpected error occurred at getTodoById');
    }
  }

  SubTodoModel? getSubTodoById(
      {required TodoType type, required int todoId, required int subTodoId}) {
    switch (type) {
      case TodoType.scheduled:
        return scheduledTodoList
            .firstWhere((e) => e.id == todoId)
            .subTodo.firstWhere((e) => e.id == subTodoId);
      default:
        throw Exception('An unexpected error occurred at getSubTodoById');
    }
  }

  /*
    UPDATE Functions
   */
  void toggleMainTodoChecked(
      {required TodoType type, required int todoId}) async {
    TodoModel todo = getTodoById(todoId: todoId, type: type);
    todo.isChecked = !todo.isChecked;

    await _service.updateTodo(todo);

    switch (type) {
      case TodoType.scheduled:
        loadScheduledData();
        break;
      default:
        break;
    }
  }

  void toggleSubTodoChecked(
      {required TodoType type,
      required int todoId,
      required int subTodoId}) async {
    TodoModel todo = getTodoById(todoId: todoId, type: type);
    todo.subTodo.firstWhere((e) => e.id == subTodoId).isChecked =
        !todo.subTodo.firstWhere((e) => e.id == subTodoId).isChecked;

    await _service.updateTodo(todo);

    switch (type) {
      case TodoType.scheduled:
        loadScheduledData();
      default:
        break;
    }
  }

  void toggleIsFold({required TodoType type, required int todoId}) async {
    TodoModel todo = getTodoById(todoId: todoId, type: type);

    todo.isFold = !todo.isFold;

    await _service.updateTodo(todo);
  }

  void addTodo({required TodoModel todo, required int pos}) async {
    await _service.insertTodo(todo: todo, pos: pos);
    loadScheduledData();
  }
}
