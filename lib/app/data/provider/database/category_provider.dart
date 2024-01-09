import 'package:get/get.dart';

import '../../../core/database/database_init.dart';

class CategoryProvider extends GetxService {
  /*
    CREATE DATA
   */
    Future<void> insertCategory(Map<String, Object?> category) async {
      final db = await DatabaseInit().database;
      db.insert('category', category);
    }

  /*
  READ DATA
   */
  Future<List<Map<String, Object?>>> getCategoryAll() async {
    final db = await DatabaseInit().database;

    final List<Map<String, dynamic>> result = await db.query(
      'category',
      orderBy: 'pos ASC',
    );

    return result;
  }

    Future<Map<String, Object?>> getCategoryById({required String categoryId}) async {
      final db = await DatabaseInit().database;

      final List<Map<String, dynamic>> result = await db.query(
        'category',
        where: 'id = ?',
        whereArgs: [categoryId],
        orderBy: 'pos ASC',
      );

      return result[0];
    }

  /*
    UPDATE DATA
   */
  Future<int> updateCategory(Map<String, Object?> category) async {
    final db = await DatabaseInit().database;

    return await db.update('category', category, where: 'id = ?', whereArgs: [category['id']]);
  }

  Future<int> updateCategories(List<Map<String, Object?>> categoryList) async {
    final db = await DatabaseInit().database;

    return await db.transaction((txn) async {
      int totalUpdates = 0;

      for(var category in categoryList) {
        int updates = await txn.update('category', category, where: 'id = ?', whereArgs: [category['id']]);
        totalUpdates += updates;
      }

      return totalUpdates;
    });
  }

  /*
    DELETE DATA
   */
  Future<int> deleteCategory(String categoryId) async {
    final db = await DatabaseInit().database;

    return await db.delete('category', where: 'id = ?', whereArgs: [categoryId]);
  }
}