import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/data/model/category_model.dart';
import 'package:peep_todo_flutter/app/data/provider/database/category_provider.dart';

class CategoryService extends GetxService {
  final CategoryProvider _provider = CategoryProvider();

  /*
    READ DATA
   */
  Future<List<CategoryModel>> getCategoryAll() async {
    final List<Map<String, dynamic>> categoryMaps =
        await _provider.getCategoryAll();

    return categoryMaps.map((e) => CategoryModel.fromMap(e)).toList();
  }
}
