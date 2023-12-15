import 'dart:developer';

import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/data/model/category/category_model.dart';
import 'package:peep_todo_flutter/app/data/provider/database/category_provider.dart';

class CategoryService extends GetxService {
  final CategoryProvider _provider = CategoryProvider();

  /*
    CREATE DATA
   */
  Future<void> insertCategory({required CategoryModel category}) async {
    Map<String, Object?> categoryMap = category.toMap();
    await _provider.insertCategory(categoryMap);
  }

  /*
    READ DATA
   */
  Future<List<CategoryModel>> getCategoryAll() async {
    final List<Map<String, dynamic>> categoryMaps =
        await _provider.getCategoryAll();

    return categoryMaps.map((e) => CategoryModel.fromMap(e)).toList();
  }

  Future<CategoryModel> getCategoryById({required String categoryId}) async {
    final Map<String, dynamic> category = await _provider.getCategoryById(categoryId: categoryId);

    return CategoryModel.fromMap(category);
  }

  /*
    UPDATE DATA
   */
  Future<void> updateCategory(CategoryModel category) async {
    var row = await _provider.updateCategory(category.toMap());

    log("delete $row rows.");
  }

  Future<void> updateCategories(List<CategoryModel> categoryList) async {
    var row = await _provider.updateCategories(categoryList.map((e) => e.toMap()).toList());

    log("delete $row rows.");
  }

  /*
    DELETE DATA
   */
  Future<void> deleteCategory(String categoryId) async {
    var row = await _provider.deleteCategory(categoryId);

    log("delete $row rows.");
  }
}
