import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';

import '../../../controllers/todo_controller.dart';
import '../../../theme/icons.dart';
import '../../test.dart';

class PeepCheckButton extends StatelessWidget {
  final TodoController controller;
  final Color color;
  final String date;
  final int index;

  const PeepCheckButton({
    Key? key,
    required this.color,
    required this.index,
    required this.controller,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Material(
          color: Colors.transparent,
          child: InkWell(
              onTap: () {
                //Todo : controller.toggleMainTodoChecked(date, index);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppValues.innerMargin,
                    vertical: AppValues.verticalMargin),
                child: true
                    ? PeepIcon(Iconsax.checkTrue, color: color, size: 24.w)
                    : PeepIcon(Iconsax.checkFalse,
                        color: Palette.peepGray400, size: 24.w),
              ))),
    );
  }
}

class PeepSubCheckButton extends StatelessWidget {
  final Color color;
  final String date;
  final int mainIndex;
  final int index;
  final TodoController controller;

  const PeepSubCheckButton({
    Key? key,
    required this.color,
    required this.index,
    required this.mainIndex,
    required this.date, required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              //controller.toggleSubTodoChecked(date, mainIndex, index);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppValues.innerMargin,
                  vertical: AppValues.verticalMargin),
              child: false
                  ? PeepIcon(Iconsax.checkTrue, color: color, size: 20.w)
                  : PeepIcon(Iconsax.checkFalse,
                      color: Palette.peepGray400, size: 20.w),
            ),
          )),
    );
  }
}
