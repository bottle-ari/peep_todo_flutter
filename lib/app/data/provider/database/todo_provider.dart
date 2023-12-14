import 'dart:developer';

import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/data/model/todo/todo_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/database/database_init.dart';

class TodoProvider extends GetxService {
  /*
    CREATE DATA
   */
  Future<void> insertTodo(Map<String, Object?> todo) async {
    final db = await DatabaseInit().database;
    db.insert('todo', todo);
  }

  /*
    READ DATA
   */
  Future<Map<String, Object?>> getTodo({required int todoId}) async {
    final db = await DatabaseInit().database;

    return (await db.query('todo', where: 'id = ?', whereArgs: [todoId])).first;
  }

  Future<List<Map<String, Object?>>> getScheduledTodoByDate(
      int startDate, int endDate) async {
    final db = await DatabaseInit().database;

    final List<Map<String, dynamic>> result = await db.rawQuery(
        "SELECT * FROM todo WHERE date >= $startDate AND date < $endDate ORDER BY pos ASC, date ASC");

    return result;
  }

  Future<List<Map<String, Object?>>> getCheckedTodoByDate(
      int startDate, int endDate) async {
    final db = await DatabaseInit().database;

    final List<Map<String, dynamic>> result = await db.rawQuery(
        "SELECT * FROM todo WHERE check_time >= $startDate AND check_time < $endDate ORDER BY pos ASC, date ASC");

    return result;
  }

  /*
    UPDATE DATA
   */
  Future<int> updateTodo(Map<String, Object?> todo) async {
    final db = await DatabaseInit().database;

    return await db
        .update('todo', todo, where: 'id = ?', whereArgs: [todo['id']]);
  }

  Future<int> updateTodos(List<Map<String, Object?>> todoList) async {
    final db = await DatabaseInit().database;

    return await db.transaction((txn) async {
      int totalUpdates = 0;

      for (var todo in todoList) {
        int updates = await txn
            .update('todo', todo, where: 'id = ?', whereArgs: [todo['id']]);
        totalUpdates += updates;
      }

      return totalUpdates;
    });
  }

  /*
    DELETE DATA
   */
  Future<int> deleteTodo(String todoId) async {
    final db = await DatabaseInit().database;

    return await db.delete('todo', where: 'id = ?', whereArgs: [todoId]);
  }
}
