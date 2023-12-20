import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/data/category_controller.dart';
import 'package:peep_todo_flutter/app/controllers/data/todo_controller.dart';
import 'package:peep_todo_flutter/app/data/model/category/category_model.dart';

class PeepCategoryPickerController extends GetxController {
  final CategoryController _categoryController = Get.find();

  final CategoryModel categoryModel;
  late final Rx<CategoryModel> category;

  PeepCategoryPickerController({required this.categoryModel}) {
    category = categoryModel.obs;
  }

  List<CategoryModel> getCategoryList() {
    return _categoryController.categoryList.where((element) => element.isActive).toList();
  }

  void updateCategory(CategoryModel newCategory) {
    category.value = newCategory;
  }
}