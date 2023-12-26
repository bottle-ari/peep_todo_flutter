import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/data/enums/todo_enum.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';

import '../../../controllers/data/todo_controller.dart';
import '../../../data/model/todo/todo_model.dart';
import '../../../theme/icons.dart';

class PeepCheckButton extends StatelessWidget {
  final TodoController controller;
  final Color color;
  final TodoType todoType;
  final TodoModel todo;

  const PeepCheckButton({
    Key? key,
    required this.color,
    required this.controller,
    required this.todoType,
    required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: () {
              controller.toggleMainTodoChecked(
                  type: todoType, todoId: todo.id);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppValues.innerMargin,
                  vertical: AppValues.verticalMargin),
              child: todo.isChecked
                  ? PeepIcon(Iconsax.checkTrue, color: color, size: 24.w)
                  : PeepIcon(Iconsax.checkFalse,
                      color: Palette.peepGray400, size: 24.w),
            )));
  }
}
