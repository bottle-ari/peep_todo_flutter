import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:peep_todo_flutter/app/data/enums/todo_enum.dart';
import 'package:peep_todo_flutter/app/data/services/todo_service.dart';
import 'package:peep_todo_flutter/app/utils/peep_calendar_util.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../data/model/todo/backup_todo_model.dart';
import '../../data/model/todo/todo_model.dart';

class TodoController extends GetxController {
  final TodoService _service = Get.put(TodoService());

  // Data
  final RxList<TodoModel> selectedTodoList = <TodoModel>[].obs;
  final RxMap<String, List<TodoModel>> calendarTodoList =
      <String, List<TodoModel>>{}.obs;

  final RxMap<String, Map<String, double>> calendarItemCounts =
      <String, Map<String, double>>{}.obs;

  final Rx<CalendarFormat> calendarFormat = CalendarFormat.week.obs;

  // Variables
  BackupTodoModel? backup;
  final Rx<DateTime> focusedDate = DateTime.now().obs;
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final Rx<DateTime> selectedCalendarDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();

    ever(selectedDate, (callback) => loadSelectedData());

    loadAllData();
  }

  /*
    Init Functions
   */
  void loadAllData() {
    loadSelectedData();
    loadCalendarData();
  }

  Future<void> loadSelectedData() async {
    final DateTime startDate = DateTime(selectedDate.value.year,
        selectedDate.value.month, selectedDate.value.day);
    final DateTime endDate = startDate.add(const Duration(days: 1));

    final scheduledData = await _service.getScheduledTodoByDate(
        startDate: startDate, endDate: endDate);

    final constantData = await _service.getConstantTodo();

    var data = [...constantData, ...scheduledData];

    selectedTodoList.value = data;
  }

  Future<void> loadCalendarData() async {
    final DateTime startDate = getPreviousMonthEnd(selectedCalendarDate.value)
        .subtract(const Duration(days: 7));
    final DateTime endDate = getNextMonthStart(selectedCalendarDate.value)
        .add(const Duration(days: 7));

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

    loadSelectedData();
    if (todo.date != null) {
      updateCalendarItemCounts(todo.date);
    }
  }

  void rollbackTodo() async {
    if (backup == null) return;

    await _service.insertTodo(todo: backup!.backupTodoItem);

    loadSelectedData();

    if (backup!.backupTodoItem.date != null) {
      updateCalendarItemCounts(backup!.backupTodoItem.date);
    }
  }

  /*
    READ Functions
   */
  Future<TodoModel> getTodoById({required String todoId}) {
    return _service.getTodo(todoId: todoId);
  }

  /*
    UPDATE Functions
   */
  void toggleMainTodoChecked(
      {required TodoType type, required String todoId}) async {
    TodoModel todo = await getTodoById(todoId: todoId);
    todo.isChecked = !todo.isChecked;

    DateTime? todoDate = selectedDate.value;
    if(type == TodoType.constant) {
      if(todo.isChecked) {
        todo.date = selectedDate.value;
        todoDate = todo.date;
      } else {
        todoDate = todo.date;
        todo.date = null;
      }
    }

    if (todo.checkTime == null) {
      todo.checkTime = DateTime.now();
    } else {
      todo.checkTime = null;
    }

    await _service.updateTodo(todo);

    updateCalendarItemCounts(todoDate);
    loadSelectedData();
  }

  void toggleTodoType({required String categoryId}) async {
    List<TodoModel> todoList = await _service.getUncheckedTodo(categoryId: categoryId);

    List<TodoModel> newTodoList = [];
    for(var todo in todoList) {
      if(todo.date == null) {
        todo.date = DateTime.now();
        newTodoList.add(todo);
      } else {
        todo.date = null;
        newTodoList.add(todo);
      }
      updateCalendarItemCounts(todo.date);
    }

    await _service.updateTodos(newTodoList);
    loadSelectedData();
  }

  void updateTodos(
      {required List<TodoModel> todoList}) async {
    await _service.updateTodos(todoList);
    loadAllData();
  }

  /*
    Delete Functions
   */
  Future<void> deleteTodo(
      {required TodoModel todo}) async {
    await _service.deleteTodo(todo.id);

    loadSelectedData();
    updateCalendarItemCounts(todo.date);
  }

  /*
    Util Function
   */
  // 날짜별로 데이터를 분류하는 함수
  Map<String, List<TodoModel>> groupByDate(List<TodoModel> todoList) {
    Map<String, List<TodoModel>> dateMap = {};

    for (var todo in todoList) {
      if (todo.date == null) continue;
      String formattedDate = DateFormat('yyyyMMdd').format(todo.date!);
      if (!dateMap.containsKey(formattedDate)) {
        dateMap[formattedDate] = [];
      }
      dateMap[formattedDate]?.add(todo);
    }

    return dateMap;
  }

  Map<String, List<TodoModel>> groupByCheckTime(List<TodoModel> todoList) {
    Map<String, List<TodoModel>> dateMap = {};

    for (var todo in todoList) {
      if (todo.checkTime == null) continue;
      String formattedDate = DateFormat('yyyyMMdd').format(todo.checkTime!);
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
  bool isToday() {
    return isSameDay(selectedDate.value, DateTime.now());
  }

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

  // TODO : 추후 ringPainter 변경과 함께 바꿔야 함.
  void loadOldDates({required List<DateTime> dateList}) {
    for(var date in dateList) {
      calendarItemCounts[ DateFormat('yyyyMMdd').format(date)] = {};
    }
  }

  // TODO : 코드 성능 안좋음, 추후 수정 필요
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

  void updateCalendarItemCounts(DateTime? dateTime) async {
    if (dateTime == null) return;

    await loadCalendarData();

    String date = DateFormat('yyyyMMdd').format(dateTime);
    calendarItemCounts[date] = {};

    if (calendarTodoList[date] == null) return;

    log(calendarTodoList[date].toString());

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

        calendarItemCounts[date]![key] = calendarItemCounts[date]![key]! / sum;
      }
    }

    for (var keys in calendarItemCounts[date]!.keys) {
      log("$keys ${calendarItemCounts[date]![keys]}");
    }
  }
}
