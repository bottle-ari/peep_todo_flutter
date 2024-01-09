import 'package:get/get.dart';

import '../../../core/database/database_init.dart';

class RoutineProvider extends GetxService {
  /*
    CREATE DATA
   */
  Future<void> insertRoutine(Map<String, Object?> routine) async {
    final db = await DatabaseInit().database;
    db.insert('routine', routine);
  }

  /*
  READ DATA
   */
  Future<List<Map<String, Object?>>> getRoutineAll() async {
    final db = await DatabaseInit().database;

    final List<Map<String, dynamic>> result = await db.query(
      'routine',
      orderBy: 'pos ASC',
    );

    return result;
  }

  Future<Map<String, Object?>> getRoutineById({required String routineId}) async {
    final db = await DatabaseInit().database;

    final List<Map<String, dynamic>> result = await db.query(
      'routine',
      where: 'id = ?',
      whereArgs: [routineId],
      orderBy: 'pos ASC',
    );

    return result[0];
  }

  /*
    UPDATE DATA
   */
  Future<int> updateRoutine(Map<String, Object?> routine) async {
    final db = await DatabaseInit().database;

    return await db.update('routine', routine, where: 'id = ?', whereArgs: [routine['id']]);
  }

  Future<int> updateRoutines(List<Map<String, Object?>> routineList) async {
    final db = await DatabaseInit().database;

    return await db.transaction((txn) async {
      int totalUpdates = 0;

      for(var routine in routineList) {
        int updates = await txn.update('routine', routine, where: 'id = ?', whereArgs: [routine['id']]);
        totalUpdates += updates;
      }

      return totalUpdates;
    });
  }

  /*
    DELETE DATA
   */
  Future<int> deleteRoutine(String routineId) async {
    final db = await DatabaseInit().database;

    return await db.delete('routine', where: 'id = ?', whereArgs: [routineId]);
  }
}