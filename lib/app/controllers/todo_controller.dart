import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:peep_todo_flutter/app/data/enums/todo_enum.dart';
import 'package:peep_todo_flutter/app/data/services/todo_service.dart';
import 'package:table_calendar/table_calendar.dart';

import '../data/model/todo/backup_todo_model.dart';
import '../data/model/todo/sub_todo_model.dart';
import '../data/model/todo/todo_model.dart';

class TodoController extends GetxController {
  final TodoService _service = TodoService();

  // Data
  final RxList<TodoModel> scheduledTodoList = <TodoModel>[].obs;
  final RxMap<String, List<TodoModel>> calendarTodoList =
      <String, List<TodoModel>>{}.obs;

  final RxMap<String, Map<String, double>> calendarItemCounts =
      <String, Map<String, double>>{}.obs;

  // Variables
  BackupTodoModel? backup;
  final Rx<DateTime> focusedDate = DateTime
      .now()
      .obs;
  final Rx<DateTime> selectedDate = DateTime
      .now()
      .obs;
  final Rx<DateTime> selectedCalendarDate = DateTime
      .now()
      .obs;

  @override
  void onInit() {
    super.onInit();

    ever(selectedDate, (callback) => loadScheduledData());

    loadAllData();
  }

  /*
    Init Functions
   */
  void loadAllData() {
    loadScheduledData();
    loadCalendarData();
  }

  void loadData(TodoType type) {
    switch (type) {
      case TodoType.scheduled:
        loadScheduledData();
        break;
      default:
        break;
    }
  }

  void loadScheduledData() async {
    final DateTime startDate = DateTime(selectedDate.value.year,
        selectedDate.value.month, selectedDate.value.day);
    final DateTime endDate = startDate.add(const Duration(days: 1));

    var data = await _service.getScheduledTodoByDate(
        startDate: startDate, endDate: endDate);
    scheduledTodoList.value = data;
  }

  void loadCalendarData() async {
    final DateTime startDate =
    selectedCalendarDate.value.subtract(const Duration(days: 60));
    final DateTime endDate =
    selectedCalendarDate.value.add(const Duration(days: 60));

    var data = await _service.getScheduledTodoByDate(
        startDate: startDate, endDate: endDate);

    calendarTodoList.value = groupByDate(data);

    initCalendarItemCounts();
  }

  /*
    CREATE Functions
   */
  void addTodo({required TodoModel todo}) async {
    await _service.insertTodo(todo: todo);

    if(todo.date != null) {
      loadData(TodoType.scheduled);

      updateCalendarItemCounts(todo.date);
    }
  }

  void rollbackTodo() async {
    if(backup == null) return;

    await _service.insertTodo(todo: backup!.backupTodoItem);

    loadData(backup!.backupType);

    if(backup!.backupTodoItem.date != null) {
      updateCalendarItemCounts(backup!.backupTodoItem.date);
    }
  }

  /*
    READ Functions
   */
  TodoModel getTodoById({required TodoType type, required String todoId}) {
    switch (type) {
      case TodoType.scheduled:
        return scheduledTodoList.firstWhere((e) => e.id == todoId);
      default:
        throw Exception('An unexpected error occurred at getTodoById');
    }
  }

  SubTodoModel? getSubTodoById({required TodoType type,
    required String todoId,
    required String subTodoId}) {
    switch (type) {
      case TodoType.scheduled:
        return scheduledTodoList
            .firstWhere((e) => e.id == todoId)
            .subTodo
            .firstWhere((e) => e.id == subTodoId);
      default:
        throw Exception('An unexpected error occurred at getSubTodoById');
    }
  }

  /*
    UPDATE Functions
   */
  void toggleMainTodoChecked(
      {required TodoType type, required String todoId}) async {
    TodoModel todo = getTodoById(todoId: todoId, type: type);
    todo.isChecked = !todo.isChecked;

    await _service.updateTodo(todo);

    updateCalendarItemCounts(todo.date);
    loadData(type);
  }

  void toggleSubTodoChecked({required TodoType type,
    required String todoId,
    required String subTodoId}) async {
    TodoModel todo = getTodoById(todoId: todoId, type: type);
    todo.subTodo
        .firstWhere((e) => e.id == subTodoId)
        .isChecked =
    !todo.subTodo
        .firstWhere((e) => e.id == subTodoId)
        .isChecked;

    await _service.updateTodo(todo);

    switch (type) {
      case TodoType.scheduled:
        loadScheduledData();
      default:
        break;
    }
  }

  void toggleIsFold({required TodoType type, required String todoId}) async {
    TodoModel todo = getTodoById(todoId: todoId, type: type);

    todo.isFold = !todo.isFold;

    await _service.updateTodo(todo);
  }

  void updateTodos(
      {required TodoType type, required List<TodoModel> todoList}) async {
    await _service.updateTodos(todoList);
  }

  /*
    Delete Functions
   */
  Future<void> deleteTodo({required TodoType type, required TodoModel todo}) async {
    await _service.deleteTodo(todo.id);

    loadData(type);

    if(todo.date != null) {
      updateCalendarItemCounts(todo.date);
    }
  }

  /*
    Util Function
   */
  // 날짜별로 데이터를 분류하는 함수
  Map<String, List<TodoModel>> groupByDate(List<TodoModel> todoList) {
    Map<String, List<TodoModel>> dateMap = {};

    for (var todo in todoList) {
      if(todo.date == null) continue;
      String formattedDate = DateFormat('yyyyMMdd').format(todo.date!);
      if (!dateMap.containsKey(formattedDate)) {
        dateMap[formattedDate] = [];
      }
      dateMap[formattedDate]?.add(todo);
    }

    return dateMap;
  }

  /*
    Calendar
   */
  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(selectedDate.value, selectedDay)) {
      selectedDate.value = selectedDay;
      focusedDate.value = focusedDay;
    }
  }

  void onMoveToday() {
    DateTime today = DateTime.now();

    // 오늘 선택 예외 처리
    if (focusedDate.value == today && selectedDate.value == today) {
      focusedDate.update((val) {
        val = null;
      });
    }
    focusedDate.value = today;
    selectedDate.value = today;
  }

  void onPageChanged(DateTime newFocusedDay) {
    focusedDate.value = newFocusedDay;
    selectedDate.value = newFocusedDay;

    update();
  }

  void initCalendarItemCounts() {
    for (var date in calendarTodoList.keys) {
      if (calendarTodoList[date] == null) continue;

      calendarItemCounts[date] = {};

      int sum = 0;
      for (int i = 0; i < calendarTodoList[date]!.length; i++) {
        var categoryId = calendarTodoList[date]![i].categoryId;

        if (calendarItemCounts[date]![categoryId] == null) {
          calendarItemCounts[date]![categoryId] = 0;
        }

        if (calendarTodoList[date]![i].isChecked) {
            calendarItemCounts[date]![categoryId] =
                calendarItemCounts[date]![categoryId]! + 1;
        }
        sum++;
      }

      if (sum != 0) {
        for (var key in calendarItemCounts[date]!.keys) {
          if (calendarItemCounts[date]![key] == null) continue;

          calendarItemCounts[date]![key] =
              calendarItemCounts[date]![key]! / sum;
        }
      }
    }
  }

  void updateCalendarItemCounts(DateTime? dateTime) {
    if(dateTime == null) return;

    loadCalendarData();

    String date = DateFormat('yyyyMMdd').format(dateTime);
    if (calendarTodoList[date] == null) return;

    calendarItemCounts[date] = {};

    int sum = 0;
    for (int i = 0; i < calendarTodoList[date]!.length; i++) {
      var categoryId = calendarTodoList[date]![i].categoryId;

      if (calendarItemCounts[date]![categoryId] == null) {
        calendarItemCounts[date]![categoryId] = 0;
      }

      if (calendarTodoList[date]![i].isChecked) {
        calendarItemCounts[date]![categoryId] =
            calendarItemCounts[date]![categoryId]! + 1;
      }
      sum++;
    }

    if (sum != 0) {
      for (var key in calendarItemCounts[date]!.keys) {
        if (calendarItemCounts[date]![key] == null) continue;

        calendarItemCounts[date]![key] =
            calendarItemCounts[date]![key]! / sum;
      }
    }

    for(var values in calendarItemCounts[date]!.values) {
      log(values.toString());
    }
  }
}
