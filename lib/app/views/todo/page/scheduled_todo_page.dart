import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:peep_todo_flutter/app/controllers/mini_calendar_controller.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/views/todo/page/todo_add_modal.dart';
import 'package:peep_todo_flutter/app/views/todo/widget/peep_mini_calendar.dart';
import 'package:peep_todo_flutter/app/views/todo/widget/peep_category_item.dart';
import 'package:reorderables/reorderables.dart';

import '../../../controllers/page/scheduled_todo_controller.dart';
import '../../../core/base/base_view.dart';
import '../widget/peep_todo_item.dart';

class ScheduledTodoPage extends BaseView<ScheduledTodoController> {
  final MiniCalendarController calendarController = Get.find();

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return Obx(
      () {
        var date =
            DateFormat('yyyyMMdd').format(calendarController.selectedDay.value);
        return SizedBox(
          height: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: AppValues.verticalMargin),
                  child: SizedBox(
                    height: 90.h,
                    child: PeepMiniCalendar(
                      controller: controller,
                    ),
                  ),
                ),
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      ReorderableSliverList(
                        delegate: ReorderableSliverChildListDelegate(
                          [
                            for (int index = 0;
                                index <
                                    controller.getTodoList(date: date).length;
                                index++)
                              if (controller.isCategoryModel(date, index))
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: AppValues.verticalMargin),
                                  child: PeepCategoryItem(
                                      color: controller
                                          .getTodoList(date: date)[index]
                                          .color,
                                      name: controller
                                          .getTodoList(date: date)[index]
                                          .name,
                                      emoji: controller
                                          .getTodoList(date: date)[index]
                                          .emoji,
                                      onTapAddButton: () {
                                      },
                                      onTapArrowButton: () {
                                        controller.toggleCategoryIsFold(
                                            date, index);
                                      },
                                      isFolded: controller.categoryFoldMap[
                                          controller.reverseCategoryFoldMap(
                                              date, index)]),
                                )
                              else if (!controller.categoryFoldMap[controller
                                  .reverseCategoryFoldMap(date, controller.getTodoCategory(
                                  date, index))])
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: AppValues.innerMargin),
                                  child: PeepTodoItem(
                                    color: controller.todoColor(date, index),
                                    index: index,
                                    controller: controller,
                                    date: date,
                                  ),
                                )
                          ],
                        ),
                        onReorder: (int oldIndex, int newIndex) {
                          controller.reorderTodoList(date, oldIndex, newIndex);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
