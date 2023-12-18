import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/data/category_controller.dart';
import 'package:peep_todo_flutter/app/data/enums/todo_enum.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/views/common/popup/peep_warning_popup.dart';

import '../../../controllers/animation/peep_category_toggle_button_controller.dart';
import '../../../data/model/category/category_model.dart';
import '../../../theme/app_values.dart';

class PeepCategoryToggleButton extends StatelessWidget {
  final CategoryModel category;
  final CategoryController controller;
  final double? height;

  const PeepCategoryToggleButton(
      {super.key,
      required this.category,
      this.height,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    final PeepCategoryToggleButtonController animationController = Get.put(
        PeepCategoryToggleButtonController(
            category.isActive, height ?? AppValues.baseIconSize),
        tag: category.id);

    return InkWell(
        onTap: () async {
          final isSuccess =
              await controller.toggleCategoryActiveState(category.id);

          if (isSuccess) {
            animationController.toggleAnimation();
          } else {
            Get.dialog(PeepWarningPopup(
                icon: Iconsax.emptyBox,
                text: '적어도 한 개 이상의 카테고리가\n활성화 되어야 해요',
                confirmText: '확인',
                color: Palette.peepRed.withOpacity(AppValues.baseOpacity)));
          }
        },
        child: AnimatedBuilder(
            animation: animationController.animation,
            builder: (context, child) => Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppValues.horizontalMargin,
                      vertical: AppValues.innerMargin),
                  child: SizedBox(
                    width: (height ?? AppValues.baseIconSize) * 1.8,
                    height: (height ?? AppValues.baseIconSize),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: category.isActive
                                ? category.color
                                : Palette.peepGray300,
                            borderRadius:
                                BorderRadius.circular(AppValues.baseRadius),
                          ),
                        ),
                        if (category.type == TodoType.constant)
                          Positioned(
                            top: (height ?? AppValues.baseIconSize) * 0.25,
                            left: (height ?? AppValues.baseIconSize) * 0.25,
                            child: PeepIcon(
                              Iconsax.constantTodo,
                              size: AppValues.baseIconSize * 0.5,
                              color: Palette.peepWhite
                                  .withOpacity(AppValues.highOpacity),
                            ),
                          ),
                        Positioned(
                          top: (height ?? AppValues.baseIconSize) * 0.15,
                          left: (height ?? AppValues.baseIconSize) * 0.15 +
                              animationController.animation.value,
                          child: Container(
                            width: (height ?? AppValues.baseIconSize) * 0.7,
                            height: (height ?? AppValues.baseIconSize) * 0.7,
                            decoration: const BoxDecoration(
                              color: Palette.peepWhite,
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )));
  }
}
