import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/data/model/category_model.dart';
import 'package:peep_todo_flutter/app/data/services/category_service.dart';

class CategoryController extends GetxController {
  final CategoryService _service = CategoryService();

  // Data
  final RxList<CategoryModel> categoryList = <CategoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCategoryData();
  }

  /*
    Init Functions
   */
  void loadCategoryData() async {
    var data = await _service.getCategoryAll();
    categoryList.value = data;
  }
}