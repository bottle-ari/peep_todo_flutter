import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/data/model/todo/todo_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/database/database_init.dart';

class TodoProvider extends GetxService {
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

    final List<Map<String, dynamic>> result = await db.query(
      'todo',
      where: 'date >= ? AND date <= ?',
      whereArgs: [startDate, endDate],
      orderBy: 'date ASC, pos ASC',
    );

    return result;
  }

  Future<List<Map<String, Object?>>> getSubTodos(int todoId) async {
    final db = await DatabaseInit().database;

    return await db.query(
      'subtodo',
      where: 'todo_id = ?',
      whereArgs: [todoId],
    );
  }

  /*
    UPDATE DATA
   */
  Future<int> updateTodo(Map<String, Object?> todo, int todoId) async {
    final db = await DatabaseInit().database;

    return await db.update('todo', todo, where: 'id = ?', whereArgs: [todoId]);
  }
}
