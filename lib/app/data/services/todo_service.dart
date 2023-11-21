import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/data/model/todo/sub_todo_model.dart';
import 'package:peep_todo_flutter/app/data/model/todo/todo_model.dart';
import 'package:peep_todo_flutter/app/data/provider/database/todo_provider.dart';

class TodoService extends GetxService {
  final TodoProvider _provider = TodoProvider();

  /*
    READ DATA
   */
  Future<TodoModel> getTodo({required int todoId}) async {
    Map<String, dynamic> todoMap = await _provider.getTodo(todoId: todoId);
    TodoModel todo = TodoModel.fromMap(todoMap);

    final List<Map<String, dynamic>> subTodoMaps =
        await _provider.getSubTodos(todo.id);

    todo.subTodo = subTodoMaps.map((e) => SubTodoModel.fromMap(e)).toList();

    return todo;
  }

  Future<List<TodoModel>> getScheduledTodoByDate(
      {required DateTime startDate, required DateTime endDate}) async {
    final List<Map<String, dynamic>> todoMaps =
        await _provider.getScheduledTodoByDate(
            startDate.millisecondsSinceEpoch, endDate.millisecondsSinceEpoch);

    List<TodoModel> todoList = [];

    for (var todoMap in todoMaps) {
      TodoModel todo = TodoModel.fromMap(todoMap);
      final List<Map<String, dynamic>> subTodoMaps =
          await _provider.getSubTodos(todo.id);
      todo.subTodo = subTodoMaps.map((e) => SubTodoModel.fromMap(e)).toList();

      todoList.add(todo);
    }

    return todoList;
  }

/*
    UPDATE DATA
   */
  Future<void> updateTodo(TodoModel todo) async {
    var row = await _provider.updateTodo(todo.toMap(), todo.id);

    debugPrint("update $row rows.");
  }
}
