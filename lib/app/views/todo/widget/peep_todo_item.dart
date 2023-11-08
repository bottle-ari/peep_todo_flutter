import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
  final int index;

  const PeepTodoItem({super.key, required this.color, required this.index});

  @override
  Widget build(BuildContext context) {
    final TodoController controller = Get.find();
    Color priorityColor = Palette.peepGray400;

    switch (controller.todoList[index].priority) {
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

    return Obx(
          () =>
          Center(
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
                    Get.snackbar('', '',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.transparent,
                        duration: const Duration(days: 9999999),
                        isDismissible: true,
                        reverseAnimationCurve: Curves.easeOutQuad,
                        messageText: PeepRollbackSnackbar(
                            icon: PeepIcon(
                              Iconsax.trash,
                              size: AppValues.baseIconSize,
                              color: Palette.peepRed,
                            ),
                            boldText: controller.todoList[index].name,
                            regularText: '삭제!',
                            onTapRollback: () {
                              Get.back();
                            }));
                    //Todo : 여기 true로 변경해야 함
                    return false;
                  } else {
                    Get.snackbar('체크!', '체크했습니다');
                    controller.toggleMainTodoChecked(index);
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if((controller.todoList[index].subTodo
                                    ?.length ?? 0) == 0)
                                  Padding(
                                    padding: EdgeInsets.only(left: AppValues.horizontalMargin, right: AppValues.innerMargin),
                                    child: PeepIcon(
                                      Iconsax.egg, size: AppValues.baseIconSize,
                                      color: priorityColor,),
                                  )
                                else
                                PeepPriorityFoldingButton(
                                  index: index,
                                  color: priorityColor,
                                ),
                                Flexible(
                                  child: InkWell(
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
                                          controller.todoList[index].name,
                                          style: PeepTextStyle.regularM(
                                              color: controller
                                                  .todoList[index].isChecked.value
                                                  ? Palette.peepGray400
                                                  : Palette.peepBlack),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AppValues.innerMargin),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: PeepCheckButton(
                                      color: color,
                                      index: index,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            controller.todoList[index].isFold.value
                                ? const SizedBox.shrink()
                                : ConstrainedBox(
                              constraints:
                              controller.todoList[index].isFold.value
                                  ? const BoxConstraints(maxHeight: 0)
                                  : const BoxConstraints(),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: controller.todoList[index]
                                      .subTodo?.length ??
                                      0,
                                  itemBuilder:
                                      (BuildContext context, int subIndex) {
                                    return PeepSubTodoItem(
                                        controller: controller,
                                        mainIndex: index,
                                        index: subIndex,
                                        color: color);
                                  }),
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
  final int mainIndex;
  final int index;

  const PeepSubTodoItem({super.key,
    required this.controller,
    required this.mainIndex,
    required this.index,
    required this.color});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () =>
          SizedBox(
            height: AppValues.baseItemHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: AppValues.baseIconSize,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: AppValues.verticalMargin),
                  child: InkWell(
                    onTap: () {
                      controller.toggleSubTodoChecked(mainIndex, index);
                    },
                    child: SizedBox(
                      width: 230.w,
                      child: Text(
                        controller.todoList[mainIndex].subTodo?[index].text
                            .value ??
                            '',
                        style: PeepTextStyle.regularM(
                            color: controller.todoList[mainIndex].subTodo?[index]
                                .isChecked.value ??
                                true
                                ? Palette.peepGray400
                                : Palette.peepBlack),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppValues.innerMargin),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: PeepSubCheckButton(
                      color: color,
                      mainIndex: mainIndex,
                      index: index,
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
