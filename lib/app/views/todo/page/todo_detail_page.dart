import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/core/base/base_view.dart';
import 'package:peep_todo_flutter/app/data/enums/todo_enum.dart';
import 'package:peep_todo_flutter/app/routes/app_pages.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/utils/priority_util.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_animation_effect.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_category_picker_button.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_half_button.dart';
import 'package:peep_todo_flutter/app/views/common/peep_date_picker.dart';
import 'package:peep_todo_flutter/app/views/common/peep_subpage_appbar.dart';
import 'package:peep_todo_flutter/app/views/common/popup/peep_confirm_popup.dart';
import 'package:peep_todo_flutter/app/views/todo/widget/priority_picker_modal.dart';
import 'package:peep_todo_flutter/app/views/todo/widget/peep_todo_detail_main_item.dart';
import 'package:uuid/uuid.dart';

import '../../../controllers/data/todo_controller.dart';
import '../../../controllers/page/todo_detail_controller.dart';
import '../../../data/enums/priority.dart';
import '../../../data/model/category/category_model.dart';
import '../../../data/model/todo/backup_todo_model.dart';
import '../../../data/model/todo/todo_model.dart';
import '../../../theme/app_values.dart';
import '../../common/peep_dropdown_menu.dart';
import '../../common/peep_rollback_snackbar.dart';

class TodoDetailPage extends BaseView<TodoDetailController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    TodoModel todo = Get.arguments['todo'];
    final TodoController todoController = Get.find();

    void deleteTodo() {
      if (Get.isSnackbarOpen) {
        Get.back();
      }

      todoController.backup = BackupTodoModel(
        backupTodoItem: todo,
        backupIndex: todo.pos,
        backupDate: todo.date,
      );

      todoController.deleteTodo(todo: todo);

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
                todoController.rollbackTodo();
                Get.back();
              }));
    }

    return PreferredSize(
        preferredSize: Size.fromHeight(AppValues.appbarHeight),
        child: SafeArea(
          child: PeepSubpageAppbar(
            title: 'Todo 상세',
            onTapBackArrow: () {
              Get.back();
            },
            buttons: [
              PeepAnimationEffect(
                onTap: () {
                  Get.back();
                  // UUID 생성
                  var uuid = const Uuid();
                  String newUuid = uuid.v4();

                  controller.todoController.addTodo(
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
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppValues.innerMargin),
                  child: PeepIcon(
                    Iconsax.copy,
                    size: AppValues.baseIconSize,
                    color: Palette.peepGray500,
                  ),
                ),
              ),
              PeepAnimationEffect(
                onTap: () {
                  Get.dialog(PeepConfirmPopup(
                      icon: Iconsax.trashBold,
                      text: '삭제',
                      confirmText: '삭제',
                      color: Palette.peepRed,
                      func: () {
                        Get.back();
                        deleteTodo();
                      }));
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppValues.innerMargin),
                  child: PeepIcon(
                    Iconsax.trash,
                    size: AppValues.baseIconSize,
                    color: Palette.peepRed,
                  ),
                ),
              ),
              // PeepDropdownMenu(
              //   menuItems: [
              //     DropdownMenuItemData(
              //         'popup_action_1',
              //         PeepIcon(Iconsax.categoryboxAdd,
              //             size: AppValues.smallIconSize,
              //             color: Palette.peepBlack),
              //         'Todo 복사'),
              //     DropdownMenuItemData(
              //         'popup_action_2',
              //         PeepIcon(Iconsax.categorybox,
              //             size: AppValues.smallIconSize,
              //             color: Palette.peepBlack),
              //         'Todo 공유'),
              //   ],
              //   onMenuItemSelected: {
              //     'popup_action_1': () {
              //       debugPrint('1');
              //     },
              //     'popup_action_2': () {
              //       debugPrint('2');
              //     },
              //   },
              // ),
            ],
          ),
        ));
  }

  @override
  Widget body(BuildContext context) {
    if (Get.isSnackbarOpen) {
      Get.back();
    }

    return SizedBox(
      height: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: AppValues.verticalMargin),
                  child: SizedBox(
                    height: 48.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PeepHalfButton(
                          color: Palette.peepWhite,
                          onTap: () {
                            Get.bottomSheet(
                                PriorityPickerModal(controller: controller));
                          },
                          text: PriorityUtil.getPriority(
                                  controller.todo.value.priority)
                              .PriorityString,
                          textColor: PriorityUtil.getPriority(
                                      controller.todo.value.priority) ==
                                  Priority.unspecified
                              ? Palette.peepGray400
                              : PriorityUtil.getPriority(
                                      controller.todo.value.priority)
                                  .PriorityColor,
                          icon: PeepIcon(
                            Iconsax.priority,
                            size: AppValues.smallIconSize,
                            color: PriorityUtil.getPriority(
                                    controller.todo.value.priority)
                                .PriorityColor,
                          ),
                        ),
                        PeepHalfButton(
                          color: controller.isOverdue()
                              ? Palette.peepRed
                              : Palette.peepWhite,
                          onTap: () {
                            if (controller.todoType.value ==
                                TodoType.scheduled) {
                              Get.bottomSheet(PeepDatePicker(
                                date: controller.todo.value.date!,
                                color: controller.getColor(),
                                onConfirm: (DateTime date) {
                                  controller.updateDate(date);
                                },
                              ));
                            }
                          },
                          text: controller.getDateString(),
                          textColor: controller.isOverdue()
                              ? Palette.peepWhite
                              : Palette.peepGray500,
                          icon: PeepIcon(Iconsax.calendar,
                              size: AppValues.smallIconSize,
                              color: controller.isOverdue()
                                  ? Palette.peepWhite
                                  : Palette.peepGray500),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppValues.verticalMargin,
                      ),
                      child: PeepCategoryPickerButton(
                        onConfirm: (CategoryModel category) {
                          controller.updateCategory(category);
                        },
                        categoryModel: controller.category.value,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: AppValues.innerMargin,
                        ),
                        child: PeepTodoDetailMainItem(
                          controller: controller,
                        )),
                    SizedBox(
                      height: AppValues.verticalMargin * 2,
                    ),
                    SizedBox(
                      width:
                          AppValues.screenWidth - AppValues.screenPadding * 2,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppValues.horizontalMargin),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    PeepIcon(
                                      Iconsax.memo,
                                      color: Palette.peepGray500,
                                      size: AppValues.baseIconSize,
                                    ),
                                    SizedBox(
                                      width: AppValues.horizontalMargin,
                                    ),
                                    Text(
                                      '메모',
                                      style: PeepTextStyle.regularM(
                                          color: Palette.peepGray500),
                                    ),
                                  ],
                                ),
                                PeepAnimationEffect(
                                    onTap: () {
                                      log("페이지 이동");
                                      Get.toNamed(AppPages.TODOMEMO,
                                          arguments: {
                                            'text': controller.todo.value.memo,
                                            'color':
                                                controller.getColor(),
                                          });
                                    },
                                    child: Text(
                                      '메모입력',
                                      style: PeepTextStyle.boldM(
                                        color: controller.getColor(),
                                      ),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppValues.verticalMargin * 1.5,
                    ),
                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Palette.peepWhite,
                          border: Border.all(color: Palette.peepGray200),
                          borderRadius:
                              BorderRadius.circular(AppValues.baseRadius),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppValues.screenPadding,
                              vertical: AppValues.verticalMargin * 1.5),
                          child: Text(
                            (controller.todo.value.memo?.isNotEmpty ?? false)
                                ? controller.todo.value.memo!
                                : '메모를 입력하세요!',
                            style: PeepTextStyle.regularM(
                                color:
                                    (controller.todo.value.memo?.isNotEmpty ??
                                            false)
                                        ? Palette.peepBlack
                                        : Palette.peepGray400),
                          ),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
