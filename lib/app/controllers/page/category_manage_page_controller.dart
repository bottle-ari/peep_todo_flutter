import 'dart:ui';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/core/base/base_controller.dart';
import 'package:peep_todo_flutter/app/data/mock_data.dart';
import '../../data/model/category_model.dart';

class CategoryManagePageController extends BaseController {
  // TODO : 현재는 Mock 데이터가 들어가 있으므로, 추후 변경 필요
  final RxList<CategoryModel> categoryList = mockCategories.obs;

  void addCategoryItem(String date, String emoji, String name, Color color) {
    // 카테고리 모델 생성
    CategoryModel categoryModel = CategoryModel(id: 5, name: name, color: color, emoji: emoji);

    // mockCategories 에 category 추가 (mock_data.dart 의 함수)
    addCategoryModel(categoryModel);

    // categoryList 의 value 새로 세팅
    categoryList.value = mockCategories;
    update();
  }

  void reorderCategoryList(oldIndex, newIndex){
    // mockCategories 의 순서 변경 (mock_data.dart 의 함수)
    reorderCategoryModel(oldIndex, newIndex);

    // categoryList 의 value 새로 세팅
    categoryList.value = mockCategories;
    update();
  }
}
