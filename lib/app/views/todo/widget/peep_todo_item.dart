import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/data/enums/todo_enum.dart';
import 'package:peep_todo_flutter/app/data/model/todo/sub_todo_model.dart';
import 'package:peep_todo_flutter/app/data/model/todo/todo_model.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_check_button.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_priority_folding_button.dart';
import 'package:peep_todo_flutter/app/views/common/peep_rollback_snackbar.dart';

import '../../../controllers/todo_controller.dart';

class PeepTodoItem extends StatelessWidget {
  final Color color;
  final TodoType todoType;
  final String todoId;

  const PeepTodoItem(
      {super.key,
      required this.todoId,
      required this.color,
      required this.todoType});

  @override
  Widget build(BuildContext context) {
    final TodoController controller = Get.find();
    TodoModel todo = controller.getTodoById(type: todoType, todoId: todoId);

    Color priorityColor = Palette.peepGray400;

    switch (todo.priority) {
      case 1:
        priorityColor = Palette.peepGreen;
        break;
      case 2:
        priorityColor = Palette.peepYellow400;
        break;
      case 3:
        priorityColor = Palette.peepRed;
        break;
      default:
        priorityColor = Palette.peepGray400;
        break;
    }

    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppValues.baseRadius),
        child: Dismissible(
          key: UniqueKey(),
          background: Container(
            color: color,
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: AppValues.horizontalMargin),
              child: PeepIcon(
                Iconsax.check,
                color: Palette.peepWhite,
                size: AppValues.baseIconSize,
              ),
            ),
          ),
          secondaryBackground: Container(
            color: Palette.peepRed,
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: AppValues.horizontalMargin),
              child: PeepIcon(
                Iconsax.trash,
                color: Palette.peepWhite,
                size: AppValues.baseIconSize,
              ),
            ),
          ),
          confirmDismiss: (DismissDirection direction) async {
            if (direction == DismissDirection.endToStart) {
              Get.back();
              //controller.deleteTodoItem(date, index);

              Get.snackbar('', '',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.transparent,
                  duration: const Duration(days: 9999999),
                  isDismissible: true,
                  reverseAnimationCurve: Curves.easeOutQuad,
                  barBlur: 0,
                  titleText: PeepRollbackSnackbar(
                      icon: PeepIcon(
                        Iconsax.trash,
                        size: AppValues.baseIconSize,
                        color: Palette.peepRed,
                      ),
                      boldText: todo.name,
                      regularText: '삭제!',
                      onTapRollback: () {
                        //controller.rollbackTodoItem();
                        Get.back();
                      }));
              return true;
            } else {
              controller.toggleMainTodoChecked(
                  type: todoType, todoId: todoId);
              return false;
            }
          },
          child: SizedBox(
            width: AppValues.screenWidth - AppValues.screenPadding * 2,
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: AppValues.baseItemHeight),
              child: Container(
                color: Palette.peepWhite,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppValues.innerMargin),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: [
                          if (todo.subTodo.length == 0)
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppValues.horizontalMargin,
                              ),
                              child: PeepIcon(
                                Iconsax.egg,
                                size: AppValues.baseIconSize,
                                color: priorityColor,
                              ),
                            )
                          else
                            PeepPriorityFoldingButton(
                              color: priorityColor,
                              controller: controller,
                              todoId: todo.id,
                              todoType: todoType,
                            ),
                          InkWell(
                            onTap: () {
                              //Todo 페이지 이동
                              log("페이지 이동");
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: AppValues.verticalMargin),
                              child: SizedBox(
                                width: 230.w,
                                child: Text(
                                  todo.name,
                                  style: PeepTextStyle.regularM(
                                      color: todo.isChecked
                                          ? Palette.peepGray400
                                          : Palette.peepBlack),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppValues.innerMargin),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: PeepCheckButton(
                                    color: color,
                                    controller: controller,
                                    todoType: todoType,
                                    todoId: todoId,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      (todo.isFold || todo.subTodo.isEmpty)
                          ? const SizedBox.shrink()
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AppValues.screenPadding),
                              child: const Divider(
                                color: Palette.peepGray200,
                              ),
                            ),
                      todo.isFold
                          ? const SizedBox.shrink()
                          : Column(
                              children: [
                                for (SubTodoModel subTodo
                                    in todo.subTodo ?? [])
                                  PeepSubTodoItem(
                                    controller: controller,
                                    color: color,
                                    todoType: todoType,
                                    todoId: todoId,
                                    subTodoId: subTodo.id,
                                  )
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PeepSubTodoItem extends StatelessWidget {
  final TodoController controller;
  final Color color;
  final TodoType todoType;
  final String todoId;
  final String subTodoId;

  const PeepSubTodoItem(
      {super.key,
      required this.controller,
      required this.color,
      required this.todoType,
      required this.todoId,
      required this.subTodoId});

  @override
  Widget build(BuildContext context) {
    SubTodoModel? subTodo = controller.getSubTodoById(
        type: todoType, todoId: todoId, subTodoId: subTodoId);

    if (subTodo == null) return Container();

    return Obx(
      () => SizedBox(
        height: 40.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: AppValues.baseIconSize + AppValues.horizontalMargin * 2,
                  top: AppValues.verticalMargin,
                  bottom: AppValues.verticalMargin),
              child: InkWell(
                onTap: () {
                  controller.toggleSubTodoChecked(
                      type: todoType, todoId: todoId, subTodoId: subTodoId);
                },
                child: SizedBox(
                  width: 230.w,
                  child: Text(
                    subTodo.name,
                    style: PeepTextStyle.regularM(
                        color: subTodo.isChecked
                            ? Palette.peepGray400
                            : Palette.peepBlack),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: AppValues.innerMargin + 2.w),
              child: Align(
                alignment: Alignment.centerRight,
                child: PeepSubCheckButton(
                  color: color,
                  controller: controller,
                  todoType: todoType,
                  todoId: todoId,
                  subTodoId: subTodoId,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
