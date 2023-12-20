import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/data/model/category/category_model.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_animation_effect.dart';

import '../../../controllers/widget/peep_category_picker_controller.dart';
import '../../../theme/palette.dart';

class PeepCategoryPickerButton extends StatelessWidget {
  final CategoryModel categoryModel;
  final Function(CategoryModel) onConfirm;

  const PeepCategoryPickerButton({
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
              style: PeepTextStyle.boldL(color: categoryModel.color),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryPickerPopup extends StatelessWidget {
  final CategoryModel categoryModel;
  final Function(CategoryModel) onConfirm;

  const _CategoryPickerPopup(
      {required this.categoryModel, required this.onConfirm});

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
                      Container(
                        decoration: BoxDecoration(
                          color: controller.category.value.id == category.id
                              ? category.color
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
                                      color: category.color),
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
