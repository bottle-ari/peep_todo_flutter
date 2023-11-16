import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/core/base/base_controller.dart';
import 'package:peep_todo_flutter/app/data/mock_data.dart';
import 'package:peep_todo_flutter/app/views/category/page/category_add_modal.dart';
import 'package:peep_todo_flutter/app/views/category/page/category_color_picker_modal.dart';
import '../../data/model/category_model.dart';

class CategoryManagePageController extends BaseController {
  // TODO : 현재는 Mock 데이터가 들어가 있으므로, 추후 변경 필요
  final RxList<CategoryModel> categoryList = mockCategories.obs;

  /*
    카테고리 아이템 추가
  */
  void addCategoryItem(String date, String emoji, String name, Color color) {
    // 카테고리 모델 생성
    CategoryModel categoryModel =
        CategoryModel(id: 5, name: name, color: color, emoji: emoji);
    // mockCategories 에 category 추가 (mock_data.dart 의 함수)
    addCategoryModel(categoryModel);
    // categoryList 의 value 새로 세팅
    categoryList.value = mockCategories;
    update();
  }

  /*
    카테고리 순서 변경
  */
  void reorderCategoryList(oldIndex, newIndex) {
    // mockCategories 의 순서 변경 (mock_data.dart 의 함수)
    reorderCategoryModel(oldIndex, newIndex);
    // categoryList 의 value 새로 세팅
    categoryList.value = mockCategories;
    update();
  }

  /*
    change Category Color
  */
  void changeCategoryColor(int index, Color newColor) {
    // mockCategories 의 Category Color 변경 (mock_data.dart 의 함수)
    changeCategoryModelColor(index, newColor);

    // RxList<CategoryModel> 에서, CategoryModel 의 속성만 변경 시, ui update 이루어지지 않음
    // 따라서, 해당 항목을 새로운 객체로 교체, color 만 변경
    categoryList[index] = CategoryModel(
      id: categoryList[index].id,
      emoji: categoryList[index].emoji,
      name: categoryList[index].name,
      color: newColor,
    );
    update();
  }

  /*
    Show Category Color Picker Modal
  */
  void showCategoryColorPickerModal(BuildContext context, int index) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return CategoryColorPickerModal(
          onColorSelected: (Color selectedColor) {
            changeCategoryColor(index, selectedColor);
          },
        );
      },
    );
  }

  /*
    Show Category Add Modal
  */
  void showCategoryAddModal(BuildContext context) {
    Color initColor =
        Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: CategoryAddModal(
              initColor: initColor,
            ),
          );
        });
  }
}
