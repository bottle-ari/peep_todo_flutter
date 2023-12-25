import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/core/database/database_init.dart';

class DiaryProvider extends GetxService {
  /*
    CREATE DATA
   */
  Future<void> insertDiary(Map<String, Object?> diary) async {
    final db = await DatabaseInit().database;
    db.insert('diary', diary);
  }

  /*
    READ DATA
   */
  Future<List<Map<String, Object?>>> getDiaryAll() async {
    final db = await DatabaseInit().database;

    final List<Map<String, dynamic>> result = await db.query(
      'diary',
    );

    return result;
  }

  Future<List<Map<String, Object?>>> getDiary(
      int startDate, int endDate) async {
    final db = await DatabaseInit().database;

    final List<Map<String, dynamic>> result = await db.rawQuery(
        "SELECT * FROM diary WHERE date >= $startDate AND date < $endDate ORDER BY date ASC");

    return result;
  }

  /*
    UPDATE DATA
    */
  Future<int> updateDiary(Map<String, Object?> diary) async {
    final db = await DatabaseInit().database;

    return await db
        .update('diary', diary, where: 'id = ?', whereArgs: [diary['id']]);
  }

  /*
    DELETE DATA
   */
  Future<int> deleteDiary(String diaryId) async {
    final db = await DatabaseInit().database;

    return await db.delete('diary', where: 'id = ?', whereArgs: [diaryId]);
  }
}
