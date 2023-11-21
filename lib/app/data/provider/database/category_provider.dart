import 'package:get/get.dart';

import '../../../core/database/database_init.dart';

class CategoryProvider extends GetxService {
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
}