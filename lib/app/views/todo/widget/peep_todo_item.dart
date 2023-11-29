import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/data/enums/todo_enum.dart';
import 'package:peep_todo_flutter/app/data/model/todo/backup_todo_model.dart';
import 'package:peep_todo_flutter/app/data/model/todo/sub_todo_model.dart';
import 'package:peep_todo_flutter/app/data/model/todo/todo_model.dart';
import 'package:peep_todo_flutter/app/routes/app_pages.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/utils/priority_util.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_check_button.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_priority_folding_button.dart';
import 'package:peep_todo_flutter/app/views/common/peep_rollback_snackbar.dart';
import 'package:uuid/uuid.dart';

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

    void deleteTodo() {
      if (Get.isSnackbarOpen) {
        Get.back();
      }

      controller.backup = BackupTodoModel(
          backupTodoItem: todo,
          backupIndex: todo.pos,
          backupDate: todo.date,
          backupType: todoType);

      controller.deleteTodo(todo: todo, type: todoType);

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
                controller.rollbackTodo();
                Get.back();
              }));
    }

    void copyTodo() {
      // UUID 생성
      var uuid = const Uuid();
      String newUuid = uuid.v4();

      controller.addTodo(
          todo: TodoModel(
              id: newUuid,
              categoryId: todo.categoryId,
              reminderId: todo.reminderId,
              name: "${todo.name}*",
              subTodo: todo.subTodo,
              date: todo.date,
              priority: todo.priority,
              memo: todo.memo,
              isFold: todo.isFold,
              isChecked: todo.isChecked,
              pos: todo.pos));
    }

    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppValues.baseRadius),
        child: Slidable(
          key: UniqueKey(),
          startActionPane: ActionPane(
            motion: const StretchMotion(),
            dismissible: DismissiblePane(
              onDismissed: () {
                deleteTodo();
              },
            ),
            children: [
              SlidableAction(
                onPressed: (BuildContext context) {
                  deleteTodo();
                },
                backgroundColor: Palette.peepRed,
                foregroundColor: Colors.white,
                label: '삭제',
              ),
              SlidableAction(
                onPressed: (BuildContext context) {
                  copyTodo();
                },
                backgroundColor: Palette.peepBlue,
                foregroundColor: Colors.white,
                label: '복사',
              ),
            ],
          ),
          child: SizedBox(
            width: AppValues.screenWidth - AppValues.screenPadding * 2,
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: AppValues.baseItemHeight),
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
                          if (todo.subTodo.isEmpty)
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppValues.horizontalMargin,
                              ),
                              child: PeepIcon(
                                Iconsax.egg,
                                size: AppValues.baseIconSize,
                                color: PriorityUtil.getPriority(todo.priority).PriorityColor,
                              ),
                            )
                          else
                            PeepPriorityFoldingButton(
                              color: PriorityUtil.getPriority(todo.priority).PriorityColor,
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
                                for (SubTodoModel subTodo in todo.subTodo ?? [])
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
