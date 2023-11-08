import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/todo_controller.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';

import '../../../theme/icons.dart';
import '../../test.dart';

class PeepCheckButton extends StatelessWidget {
  final Color color;
  final int index;

  const PeepCheckButton({
    Key? key,
    required this.color,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TodoController controller = Get.find();

    return Obx(
      () => Material(
          color: Colors.transparent,
          child: InkWell(
              onTap: () {
                controller.toggleMainTodoChecked(index);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppValues.innerMargin,
                    vertical: AppValues.verticalMargin),
                child: controller.todoList[index].isChecked.value
                    ? PeepIcon(Iconsax.checkTrue, color: color, size: 24.w)
                    : PeepIcon(Iconsax.checkFalse,
                        color: Palette.peepGray400, size: 24.w),
              ))),
    );
  }
}

class PeepSubCheckButton extends StatelessWidget {
  final Color color;
  final int mainIndex;
  final int index;

  const PeepSubCheckButton({
    Key? key,
    required this.color,
    required this.index,
    required this.mainIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TodoController controller = Get.find();

    return Obx(
      () => Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              controller.toggleSubTodoChecked(mainIndex, index);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppValues.innerMargin,
                  vertical: AppValues.verticalMargin),
              child:
                  controller.todoList[mainIndex].subTodo![index].isChecked.value
                      ? PeepIcon(Iconsax.checkTrue, color: color, size: 20.w)
                      : PeepIcon(Iconsax.checkFalse,
                          color: Palette.peepGray400, size: 20.w),
            ),
          )),
    );
  }
}
