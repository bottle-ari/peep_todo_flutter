import 'dart:developer';

import 'package:get/get.dart';

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
  Future<Map<String, Object?>> getTodo({required String todoId}) async {
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

  Future<List<Map<String, Object?>>> getConstantTodo() async {
    final db = await DatabaseInit().database;

    final List<Map<String, dynamic>> result = await db.rawQuery(
        "SELECT * FROM todo WHERE date is NULL ORDER BY pos ASC");

    return result;
  }

  Future<List<Map<String, Object?>>> getUncheckedTodoByDate({required String categoryId}) async {
    final db = await DatabaseInit().database;

    final List<Map<String, dynamic>> result = await db.rawQuery(
        "SELECT * FROM todo WHERE is_checked == 0 AND category_id == '$categoryId' ORDER BY pos ASC, date ASC");

    return result;
  }

  Future<List<Map<String, Object?>>> getTodoWithSearch(
      String inputString) async {
    final db = await DatabaseInit().database;

    final List<Map<String, dynamic>> result = await db.rawQuery(
        "SELECT * FROM todo WHERE name LIKE ? ORDER BY date DESC",
        ["%$inputString%"]);

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
