import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/routes/app_pages.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/utils/priority_util.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_check_button.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_priority_folding_button.dart';
import 'package:peep_todo_flutter/app/views/common/peep_rollback_snackbar.dart';
import '../../../controllers/todo_controller.dart';

class PeepTodoItem extends StatelessWidget {
  final TodoController controller;
  final Color color;
  final String date;
  final int index;

  const PeepTodoItem(
      {super.key,
      required this.color,
      required this.index,
      required this.controller,
      required this.date});

  @override
  Widget build(BuildContext context) {

    return Obx(
      () => Center(
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
                controller.deleteTodoItem(date, index);

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
                        boldText:
                            controller.getTodoList(date: date)[index].name,
                        regularText: '삭제!',
                        onTapRollback: () {
                          controller.rollbackTodoItem();
                          Get.back();
                        }));
                return true;
              } else {
                controller.toggleMainTodoChecked(date, index);
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
                            if ((controller
                                        .getTodoList(date: date)[index]
                                        .subTodo
                                        ?.length ??
                                    0) ==
                                0)
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppValues.horizontalMargin,
                                ),
                                child: PeepIcon(
                                  Iconsax.egg,
                                  size: AppValues.baseIconSize,
                                  color: PriorityUtil.getPriority(controller.getTodoList(date: date)[index].priority).PriorityColor,
                                ),
                              )
                            else
                              PeepPriorityFoldingButton(
                                date: date,
                                index: index,
                                color:  PriorityUtil.getPriority(controller.getTodoList(date: date)[index].priority).PriorityColor,
                                controller: controller,
                              ),
                            InkWell(
                              onTap: () {
                                //Todo 페이지 이동
                                log("페이지 이동");
                                Get.toNamed(AppPages.TODODETAIL, arguments: {
                                  'mainTodo': controller
                                      .getTodoList(date: date)[index],
                                  'priority': controller.getTodoList(date: date)[index].priority,
                                  'subTodo' : controller.getSubTodoList(date: date, mainIndex: index),
                                  'color' : color,
                                  'date' : date,
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: AppValues.verticalMargin),
                                child: SizedBox(
                                  width: 230.w,
                                  child: Text(
                                    controller
                                        .getTodoList(date: date)[index]
                                        .name,
                                    style: PeepTextStyle.regularM(
                                        color: controller
                                                .getTodoList(date: date)[index]
                                                .isChecked
                                                .value
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
                                      date: date,
                                      index: index,
                                      controller: controller,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        (controller
                                    .getTodoList(date: date)[index]
                                    .isFold
                                    .value ||
                                controller
                                        .getTodoList(date: date)[index]
                                        .subTodo ==
                                    null)
                            ? const SizedBox.shrink()
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppValues.screenPadding),
                                child: const Divider(
                                  color: Palette.peepGray200,
                                ),
                              ),
                        controller.getTodoList(date: date)[index].isFold.value
                            ? const SizedBox.shrink()
                            : Column(
                                children: [
                                  for (int subIndex = 0;
                                      subIndex <
                                          controller
                                              .getSubTodoList(
                                                  date: date, mainIndex: index)
                                              .length;
                                      subIndex++)
                                    PeepSubTodoItem(
                                        date: date,
                                        controller: controller,
                                        mainIndex: index,
                                        index: subIndex,
                                        color: color)
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
      ),
    );
  }
}

class PeepSubTodoItem extends StatelessWidget {
  final TodoController controller;
  final Color color;
  final String date;
  final int mainIndex;
  final int index;

  const PeepSubTodoItem(
      {super.key,
      required this.controller,
      required this.mainIndex,
      required this.index,
      required this.color,
      required this.date});

  @override
  Widget build(BuildContext context) {
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
                  controller.toggleSubTodoChecked(date, mainIndex, index);
                },
                child: SizedBox(
                  width: 230.w,
                  child: Text(
                    controller
                        .getSubTodoList(date: date, mainIndex: mainIndex)[index]
                        .text
                        .value,
                    style: PeepTextStyle.regularM(
                        color: controller
                                .getSubTodoList(
                                    date: date, mainIndex: mainIndex)[index]
                                .isChecked
                                .value
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
                  mainIndex: mainIndex,
                  date: date,
                  index: index,
                  controller: controller,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
