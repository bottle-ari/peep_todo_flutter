import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/data/category_controller.dart';
import 'package:peep_todo_flutter/app/controllers/data/routine_controller.dart';
import 'package:peep_todo_flutter/app/controllers/page/routine_manage_controller.dart';
import 'package:peep_todo_flutter/app/data/enums/todo_enum.dart';
import 'package:peep_todo_flutter/app/data/model/routine/routine_model.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/views/common/popup/peep_warning_popup.dart';

import '../../../controllers/animation/peep_category_toggle_button_controller.dart';
import '../../../data/model/category/category_model.dart';
import '../../../theme/app_values.dart';

class PeepRoutineToggleButton extends StatelessWidget {
  final RoutineModel routine;
  final RoutineController controller;
  final double? height;

  const PeepRoutineToggleButton({
    super.key,
    required this.routine,
    this.height,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final PeepCategoryToggleButtonController animationController = Get.put(
        PeepCategoryToggleButtonController(
            routine.isActive, height ?? AppValues.baseIconSize),
        tag: routine.id);
    final RoutineManageController routineManageController = Get.find();

    return InkWell(
      onTap: () async {
        await controller.toggleActiveState(routine.id);
        animationController.toggleAnimation();
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
                    color: routine.isActive
                        ? routineManageController.getColorByCategory(
                            item: routine)
                        : Palette.peepGray300,
                    borderRadius: BorderRadius.circular(AppValues.baseRadius),
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
        ),
      ),
    );
  }
}
