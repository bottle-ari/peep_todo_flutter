import 'package:get/get.dart';

import '../../../core/database/database_init.dart';

class PaletteProvider extends GetxService {
  /*
    READ DATA
   */
  Future<List<Map<String, Object?>>> getAllPalette() async {
    final db = await DatabaseInit().database;

    final List<Map<String, dynamic>> result = await db.rawQuery(
        "SELECT * FROM palette ORDER BY id");

    return result;
  }

  Future<Map<String, Object?>> getPalette({required String paletteId}) async {
    final db = await DatabaseInit().database;

    return (await db.query('palette', where: 'id = ?', whereArgs: [paletteId])).first;
  }

  Future<List<Map<String, Object?>>> getColors(String paletteId) async {
    final db = await DatabaseInit().database;

    return await db.query(
      'color',
      where: 'palette_id = ?',
      whereArgs: [paletteId],
    );
  }

  /*
    UPDATE DATA
   */
  Future<int> updatePalette(Map<String, Object?> palette) async {
    final db = await DatabaseInit().database;

    return await db
        .update('palette', palette, where: 'id = ?', whereArgs: [palette['id']]);
  }
}
