import 'package:get/get.dart';

import '../../../core/database/database_init.dart';
class ReminderProvider extends GetxService {
  /*
    CREATE DATA
   */
    Future<void> insertReminder(Map<String, Object?> reminder) async {
      final db = await DatabaseInit().database;
      db.insert('reminder', reminder);
    }

  /*
  READ DATA
   */
  Future<List<Map<String, Object?>>> getReminderAll() async {
    final db = await DatabaseInit().database;

    final List<Map<String, dynamic>> result = await db.query(
      'reminder',
      orderBy: 'pos ASC',
    );

    return result;
  }

    Future<Map<String, Object?>> getReminderById({required String reminderId}) async {
      final db = await DatabaseInit().database;

      final List<Map<String, dynamic>> result = await db.query(
        'reminder',
        where: 'id = ?',
        whereArgs: [reminderId],
        orderBy: 'pos ASC',
      );

      return result[0];
    }

  /*
    UPDATE DATA
   */
  Future<int> updateReminder(Map<String, Object?> reminder) async {
    final db = await DatabaseInit().database;

    return await db.update('reminder', reminder, where: 'id = ?', whereArgs: [reminder['id']]);
  }

  Future<int> updateReminders(List<Map<String, Object?>> reminderList) async {
    final db = await DatabaseInit().database;

    return await db.transaction((txn) async {
      int totalUpdates = 0;

      for(var reminder in reminderList) {
        int updates = await txn.update('reminder', reminder, where: 'id = ?', whereArgs: [reminder['id']]);
        totalUpdates += updates;
      }

      return totalUpdates;
    });
  }

  /*
    DELETE DATA
   */
  Future<int> deleteReminder(String reminderId) async {
    final db = await DatabaseInit().database;

    return await db.delete('reminder', where: 'id = ?', whereArgs: [reminderId]);
  }
}