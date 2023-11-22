import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/data/enums/todo_enum.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';

import '../../../controllers/todo_controller.dart';
import '../../../theme/icons.dart';
import '../../test.dart';

class PeepCheckButton extends StatelessWidget {
  final TodoController controller;
  final Color color;
  final TodoType todoType;
  final int todoId;

  const PeepCheckButton({
    Key? key,
    required this.color,
    required this.controller,
    required this.todoType,
    required this.todoId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Material(
          color: Colors.transparent,
          child: InkWell(
              onTap: () {
                controller.toggleMainTodoChecked(
                    type: todoType, todoId: todoId);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppValues.innerMargin,
                    vertical: AppValues.verticalMargin),
                child: controller
                        .getTodoById(type: todoType, todoId: todoId)
                        .isChecked
                    ? PeepIcon(Iconsax.checkTrue, color: color, size: 24.w)
                    : PeepIcon(Iconsax.checkFalse,
                        color: Palette.peepGray400, size: 24.w),
              ))),
    );
  }
}

class PeepSubCheckButton extends StatelessWidget {
  final Color color;
  final TodoController controller;
  final TodoType todoType;
  final int todoId;
  final int subTodoId;

  const PeepSubCheckButton({
    Key? key,
    required this.color,
    required this.controller,
    required this.todoType,
    required this.todoId,
    required this.subTodoId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              controller.toggleSubTodoChecked(
                  type: todoType, todoId: todoId, subTodoId: subTodoId);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppValues.innerMargin,
                  vertical: AppValues.verticalMargin),
              child: controller
                          .getSubTodoById(
                              type: todoType,
                              todoId: todoId,
                              subTodoId: subTodoId)
                          ?.isChecked ??
                      false
                  ? PeepIcon(Iconsax.checkTrue, color: color, size: 20.w)
                  : PeepIcon(Iconsax.checkFalse,
                      color: Palette.peepGray400, size: 20.w),
            ),
          )),
    );
  }
}
