import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:peep_todo_flutter/app/data/enums/todo_enum.dart';
import 'package:peep_todo_flutter/app/data/services/todo_service.dart';
import 'package:peep_todo_flutter/app/utils/peep_calendar_util.dart';
import 'package:peep_todo_flutter/app/data/enums/crud.dart';

import '../../data/model/todo/backup_todo_model.dart';
import '../../data/model/todo/todo_model.dart';

class TodoController extends GetxController {
  final TodoService _service = Get.put(TodoService());

  // Data
  final RxMap<String, List<TodoModel>> todoMap =
      <String, List<TodoModel>>{}.obs;

  // Variables
  BackupTodoModel? backup;
  final Rx<DateTime> focusedDate = DateTime.now().obs;
  final Rx<DateTime> selectedDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();

    loadAllData();
  }

  /*
    Init Functions
   */
  Future<void> loadAllData() async {
    final DateTime startDate = getPreviousMonthEnd(selectedDate.value)
        .subtract(const Duration(days: 7));
    final DateTime endDate =
        getNextMonthStart(selectedDate.value).add(const Duration(days: 7));

    final scheduledData = await _service.getScheduledTodoByDate(
        startDate: startDate, endDate: endDate);

    final constantData = await _service.getConstantTodo();

    var data = [...constantData, ...scheduledData];

    todoMap.value = groupByDate(data);
  }

  /*
    CRUD 공통 함수
   */
  void _updateTodoMap({required CRUD operation, required List<TodoModel> newTodoList}) async {
    Map<String, List<TodoModel>> newTodoMap = Map.from(todoMap);

    if(operation == CRUD.create) {
      // CREATE
      for(var newTodo in newTodoList) {
        final formattedDate = getTodoKey(newTodo.date);
        if (!newTodoMap.containsKey(formattedDate)) {
          newTodoMap[formattedDate] = [];
        }

        // 실제 데이터 저장
        await _service.insertTodo(todo: newTodo);

        // 옵저버 변수에 값 추가
        newTodoMap[formattedDate]?.add(newTodo);
      }
    } else if(operation == CRUD.update) {
      // UPDATE
      for(var newTodo in newTodoList) {
        final oldFormattedDate = await getTodoKeyById(newTodo.id);
        final newFormattedDate = getTodoKey(newTodo.date);

        if(newTodoMap[oldFormattedDate] == null) {
          log("ERROR : update fail(NULL)");
        } else {
          var oldIndex = newTodoMap[oldFormattedDate]!.indexWhere((element) {
            log("${element.id}\n\t  ${newTodo.id}");
            return element.id == newTodo.id;
          });

          // Map의 key(date or constant)가 변하지 않았는지 확인
          if(oldFormattedDate == newFormattedDate) {
            // 옵저버 변수에 값 추가
            newTodoMap[oldFormattedDate]?[oldIndex] = newTodo;
          } else {
            // 옵저버 변수에 값 추가
            newTodoMap[oldFormattedDate]?.removeAt(oldIndex);

            if(!newTodoMap.containsKey(newFormattedDate)) {
              newTodoMap[newFormattedDate] = [];
            }
            newTodoMap[newFormattedDate]?.add(newTodo);
          }
        }
      }

      // 실제 데이터 저장
      await _service.updateTodos(newTodoList);
    } else if(operation == CRUD.delete) {
      // DELETE
      for(var newTodo in newTodoList) {
        final formattedDate = getTodoKey(newTodo.date);

        final index = newTodoMap[formattedDate]
            ?.indexWhere((element) => element.id == newTodo.id);
        if(index == null) {
          log("ERROR : todoMap's index is not exist.");
        } else {
          // 실제 데이터 저장
          await _service.deleteTodo(newTodo.id);

          // 옵저버 변수에 값 추가
          newTodoMap[formattedDate]?.removeAt(index);
        }
      }
    }

    todoMap.value = newTodoMap;
  }

  /*
    CREATE Functions
   */
  void addTodo({required TodoModel todo}) async {
    _updateTodoMap(operation: CRUD.create, newTodoList: [todo]);
  }

  void rollbackTodo() async {
    if (backup == null) return;
    _updateTodoMap(operation: CRUD.create, newTodoList: [backup!.backupTodoItem]);
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

    // 투두 check 변경
    todo.isChecked = !todo.isChecked;

    // 투두 date 속성 변경
    if(type == TodoType.constant) {
      if(todo.isChecked) {
        todo.date = selectedDate.value;
      } else {
        todo.date = null;
      }
    }

    // 투두의 체크 시간 기록
    if (todo.checkTime == null) {
      todo.checkTime = DateTime.now();
    } else {
      todo.checkTime = null;
    }
    // 옵저버 변수 값 변경
    _updateTodoMap(operation: CRUD.update, newTodoList: [todo]);
  }

  void toggleTodoType({required String categoryId}) async {
    List<TodoModel> todoList =
        await _service.getUncheckedTodo(categoryId: categoryId);

    List<TodoModel> newTodoList = [];
    for (var todo in todoList) {
      if (todo.date == null) {
        todo.date = DateTime.now();
        newTodoList.add(todo);
      } else {
        todo.date = null;
        newTodoList.add(todo);
      }
    }

    _updateTodoMap(operation: CRUD.update, newTodoList: newTodoList);
  }

  void updateTodos({required List<TodoModel> todoList}) async {
    _updateTodoMap(operation: CRUD.update, newTodoList: todoList);
  }

  /*
    Delete Functions
   */
  Future<void> deleteTodo({required TodoModel todo}) async {
    _updateTodoMap(operation: CRUD.delete, newTodoList: [todo]);
  }

  /*
    Util Function
   */
  String getSelectedTodoKey() {
    return getTodoKey(selectedDate.value);
  }

  String getTodoKey(DateTime? date) {
    if (date == null) {
      return 'constant';
    } else {
      return DateFormat('yyyyMMdd').format(date);
    }
  }

  Future<String> getTodoKeyById(String todoId) async {
    TodoModel todo = await _service.getTodo(todoId: todoId);

    return getTodoKey(todo.date);
  }

  // 날짜별로 데이터를 분류하는 함수
  Map<String, List<TodoModel>> groupByDate(List<TodoModel> todoList) {
    Map<String, List<TodoModel>> dateMap = {};

    for (var todo in todoList) {
      final formattedDate = getTodoKey(todo.date);
      if (!dateMap.containsKey(formattedDate)) {
        dateMap[formattedDate] = [];
      }
      dateMap[formattedDate]?.add(todo);

      log('$formattedDate ${dateMap[formattedDate]![0].name}');
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

}
