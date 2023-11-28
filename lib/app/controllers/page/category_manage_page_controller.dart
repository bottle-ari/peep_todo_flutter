import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/category_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_controller.dart';
import 'package:peep_todo_flutter/app/data/mock_data.dart';
import 'package:peep_todo_flutter/app/views/category/page/category_add_modal.dart';
import 'package:peep_todo_flutter/app/views/category/page/category_color_picker_modal.dart';
import '../../data/model/category_model.dart';

//TODO : 이제 해당 컨트롤러는 사용하지 않습니다, 제거 필요.
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
    CategoryAddModalController categoryAddModalController = Get.put(CategoryAddModalController());
    categoryAddModalController.onInit();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: CategoryAddModal(
            categoryManagePageController: this, controller: categoryAddModalController,
          ),
        );
      },
    );
  }

  /*
    Add Category
  */
  void addCategory(String emoji, String name, Color color){
    // add category 연산 수행
    debugPrint("$emoji, $name, ${color.toString()}");
  }
}
