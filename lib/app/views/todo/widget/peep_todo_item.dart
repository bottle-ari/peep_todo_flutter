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
                Get.snackbar('', '',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.transparent,
                    duration: const Duration(days: 9999999),
                    isDismissible: true,
                    titleText: PeepRollbackSnackbar(
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
              child: Stack(
                children: [
                  Container(
                    height: 100.h, //AppValues.baseItemHeight,
                    color: Palette.peepWhite,
                  ),
                  SizedBox(
                    height: AppValues.baseItemHeight,
                    child: Container(
                      color: Palette.peepWhite,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppValues.innerMargin),
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                PeepPriorityFoldingButton(
                                  index: index,
                                ),
                                Text(
                                  controller.todoList[index].name,
                                  style: PeepTextStyle.regularM(
                                      color: controller
                                              .todoList[index].isChecked.value
                                          ? Palette.peepGray400
                                          : Palette.peepBlack),
                                ),
                                Expanded(
                                    child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AppValues.horizontalMargin),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: PeepCheckButton(
                                      color: color,
                                      index: index,
                                    ),
                                  ),
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: AppValues.baseItemHeight,
                      left: AppValues.horizontalMargin,
                      child: Align(
                        child: Container(
                          width: AppValues.screenWidth - AppValues.screenPadding * 2 - AppValues.horizontalMargin * 2,
                          height: 1.h,
                          color: Palette.peepGray200,
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
