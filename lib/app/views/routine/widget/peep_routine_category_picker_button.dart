import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/data/palette_controller.dart';
import 'package:peep_todo_flutter/app/data/model/category/category_model.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_animation_effect.dart';

import '../../../controllers/widget/peep_category_picker_controller.dart';
import '../../../data/enums/todo_enum.dart';
import '../../../theme/palette.dart';

class PeepRoutineCategoryPickerButton extends StatelessWidget {
  final PaletteController paletteController = Get.find();
  final CategoryModel categoryModel;
  final Function(CategoryModel) onConfirm;

  PeepRoutineCategoryPickerButton({
    Key? key,
    required this.onConfirm,
    required this.categoryModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PeepAnimationEffect(
      onTap: () {
        Get.dialog(_CategoryPickerPopup(
          categoryModel: categoryModel,
          onConfirm: onConfirm,
        ));
      },
      scale: 0.95,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppValues.horizontalMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              categoryModel.emoji,
              style: PeepTextStyle.boldL(),
            ),
            SizedBox(
              width: AppValues.horizontalMargin,
            ),
            Text(
              categoryModel.name.length > 10
                  ? "${categoryModel.name.substring(0, 10)}..."
                  : categoryModel.name,
              style: PeepTextStyle.boldL(
                  color: paletteController
                      .getDefaultPalette()[categoryModel.color]
                      .color),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryPickerPopup extends StatelessWidget {
  final PaletteController paletteController = Get.find();
  final CategoryModel categoryModel;
  final Function(CategoryModel) onConfirm;

  _CategoryPickerPopup({required this.categoryModel, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    final PeepCategoryPickerController controller =
        Get.put(PeepCategoryPickerController(categoryModel: categoryModel));

    return AlertDialog(
      surfaceTintColor: Palette.peepWhite,
      content: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: AppValues.verticalMargin,
            ),
            Text(
              '카테고리 선택',
              style: PeepTextStyle.boldL(color: Palette.peepGray500),
            ),
            SizedBox(
              height: AppValues.verticalMargin,
            ),
            SizedBox(
              height: 170.h,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (var category in controller.getCategoryList())
                      if (category.type == TodoType.scheduled)
                        Container(
                          decoration: BoxDecoration(
                            color: controller.category.value.id == category.id
                                ? paletteController
                                    .getDefaultPalette()[category.color]
                                    .color
                                    .withOpacity(AppValues.quarterOpacity)
                                : Colors.transparent,
                            borderRadius:
                                BorderRadius.circular(AppValues.baseRadius),
                          ),
                          child: PeepAnimationEffect(
                            onTap: () {
                              controller.updateCategory(category);
                              onConfirm(controller.category.value);
                              Get.back();
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AppValues.horizontalMargin,
                                  vertical: AppValues.innerMargin),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    category.emoji,
                                    style: PeepTextStyle.regularL(),
                                  ),
                                  SizedBox(
                                    width: AppValues.horizontalMargin,
                                  ),
                                  Text(
                                    category.name,
                                    style: PeepTextStyle.boldL(
                                        color: paletteController
                                            .getDefaultPalette()[category.color]
                                            .color),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: AppValues.verticalMargin,
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppValues.baseRadius)),
    );
  }
}
