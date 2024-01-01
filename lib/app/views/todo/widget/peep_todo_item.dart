import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/selected_todo_controller.dart';
import 'package:peep_todo_flutter/app/data/enums/todo_enum.dart';
import 'package:peep_todo_flutter/app/data/model/todo/backup_todo_model.dart';
import 'package:peep_todo_flutter/app/data/model/todo/todo_model.dart';
import 'package:peep_todo_flutter/app/routes/app_pages.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_check_button.dart';
import 'package:peep_todo_flutter/app/views/common/peep_rollback_snackbar.dart';
import 'package:uuid/uuid.dart';

import '../../../controllers/data/todo_controller.dart';
import '../../../utils/priority_util.dart';
import '../../common/buttons/peep_animation_effect.dart';

class PeepTodoItem extends StatelessWidget {
  final Color color;
  final TodoType todoType;
  final TodoModel todo;

  const PeepTodoItem(
      {super.key,
      required this.todo,
      required this.color,
      required this.todoType});

  @override
  Widget build(BuildContext context) {
    final TodoController controller = Get.find();
    final SelectedTodoController scheduledTodoController = Get.find();

    void deleteTodo() {
      if (Get.isSnackbarOpen) {
        Get.back();
      }

      controller.backup = BackupTodoModel(
          backupTodoItem: todo, backupIndex: todo.pos, backupDate: todo.date);

      controller.deleteTodo(todo: todo);

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
              date: todo.date,
              priority: todo.priority,
              memo: todo.memo,
              isChecked: todo.isChecked,
              checkTime: null,
              pos: todo.pos));
    }

    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Palette.peepGray200),
          borderRadius: BorderRadius.circular(AppValues.baseRadius),
        ),
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
                  backgroundColor: Palette.peepPriorityHigh,
                  foregroundColor: Colors.white,
                  icon: PeepIconData.trash
                ),
                SlidableAction(
                  onPressed: (BuildContext context) {
                    copyTodo();
                  },
                  backgroundColor: Palette.peepPriorityLow,
                  foregroundColor: Colors.white,
                    icon: PeepIconData.copy
                ),
              ],
            ),
            child: InkWell(
              onTap: () {
                if (!scheduledTodoController.isInputMode.value) {
                  Get.toNamed(Routes.TODO_DETAIL_PAGE, arguments: {
                    'todo': todo,
                    'color': color,
                    'type': todoType
                  });
                }

                scheduledTodoController.addNewTodoConfirm();
              },
              child: SizedBox(
                width: AppValues.screenWidth - AppValues.screenPadding * 2,
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints(minHeight: AppValues.baseItemHeight),
                  child: Container(
                    color:
                        todo.isChecked ? Palette.peepGray50 : Palette.peepWhite,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppValues.innerMargin),
                      child: Row(
                        children: [
                          SizedBox(width: AppValues.textMargin),
                          SizedBox(
                            width: 280.w,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: AppValues.verticalMargin),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: todo.name.length > 55
                                            ? '${todo.name.substring(0, 54)}...'
                                            : todo.name,
                                        style: PeepTextStyle.regularM(
                                            color: todo.isChecked
                                                ? Palette.peepGray400
                                                : Palette.peepBlack)),
                                    if (todo.memo?.isNotEmpty ?? false)
                                    WidgetSpan(
                                        child: Padding(
                                      padding: EdgeInsets.only(left: 5.w),
                                      child: PeepIcon(Iconsax.document,
                                          size: AppValues.miniIconSize,
                                          color: Palette.peepGray300),
                                    )),
                                    if (todo.priority != 0)
                                      WidgetSpan(
                                          child: Padding(
                                        padding: EdgeInsets.only(left: 5.w),
                                        child: PeepIcon(
                                          Iconsax.priority,
                                          size: AppValues.miniIconSize,
                                          color: PriorityUtil.getPriority(
                                                  todo.priority)
                                              .PriorityColor,
                                        ),
                                      )),
                                  ],
                                ),
                                maxLines: 3,
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
                                  child: PeepAnimationEffect(
                                    child: PeepCheckButton(
                                      color: color,
                                      controller: controller,
                                      todoType: todoType,
                                      todo: todo,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
