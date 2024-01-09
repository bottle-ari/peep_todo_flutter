import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/data/model/todo/todo_model.dart';
import 'package:peep_todo_flutter/app/data/provider/database/todo_provider.dart';

class TodoService extends GetxService {
  final TodoProvider _provider = TodoProvider();

  /*
    CREATE DATA
   */
  Future<void> insertTodo({required TodoModel todo}) async {
    Map<String, Object?> todoMap = todo.toMap();
    await _provider.insertTodo(todoMap);
  }


  /*
    READ DATA
   */
  Future<TodoModel> getTodo({required String todoId}) async {
    Map<String, dynamic> todoMap = await _provider.getTodo(todoId: todoId);
    TodoModel todo = TodoModel.fromMap(todoMap);

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
      todoList.add(todo);
    }

    return todoList;
  }

  Future<List<TodoModel>> getConstantTodo() async {
    final List<Map<String, dynamic>> todoMaps =
    await _provider.getConstantTodo();

    List<TodoModel> todoList = [];

    for (var todoMap in todoMaps) {
      TodoModel todo = TodoModel.fromMap(todoMap);
      todoList.add(todo);
    }

    return todoList;
  }

  Future<List<TodoModel>> getUncheckedTodo({required String categoryId}) async {
    final List<Map<String, dynamic>> todoMaps =
    await _provider.getUncheckedTodoByDate(categoryId: categoryId);

    List<TodoModel> todoList = [];

    for (var todoMap in todoMaps) {
      TodoModel todo = TodoModel.fromMap(todoMap);
      todoList.add(todo);
    }

    return todoList;
  }

  Future<List<TodoModel>> getTodoWithSearch({required String inputString}) async{
    final List<Map<String, dynamic>> todoMaps =
    await _provider.getTodoWithSearch(
        inputString);

    log('todoMaps_searched : ${todoMaps.length}');

    List<TodoModel> todoList = [];

    for (var todoMap in todoMaps) {
      TodoModel todo = TodoModel.fromMap(todoMap);
      todoList.add(todo);
    }

      return todoList;
  }

  /*
    UPDATE DATA
   */
  Future<void> updateTodo(TodoModel todo) async {
    var row = await _provider.updateTodo(todo.toMap());

    debugPrint("update $row rows.");
  }

  Future<void> updateTodos(List<TodoModel> todoList) async {
    var row = await _provider.updateTodos(todoList.map((e) => e.toMap()).toList());

    debugPrint("update $row rows.");
  }

  /*
    DELETE DATA
   */
  Future<void> deleteTodo(String todoId) async {
    var row = await _provider.deleteTodo(todoId);

    debugPrint("delete $row rows.");
  }
}
