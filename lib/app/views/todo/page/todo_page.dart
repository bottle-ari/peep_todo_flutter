import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:peep_todo_flutter/app/data/enums/todo_enum.dart';
import 'package:peep_todo_flutter/app/data/model/category/category_model.dart';
import 'package:peep_todo_flutter/app/data/model/todo/todo_model.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_animation_effect.dart';
import 'package:peep_todo_flutter/app/views/todo/page/todo_add_modal.dart';
import 'package:peep_todo_flutter/app/views/todo/widget/peep_mini_calendar.dart';
import 'package:peep_todo_flutter/app/views/todo/widget/peep_category_item.dart';
import 'package:reorderables/reorderables.dart';

import '../../../controllers/page/scheduled_todo_controller.dart';
import '../../../core/base/base_view.dart';
import '../widget/peep_todo_item.dart';

class TodoPage extends BaseView<ScheduledTodoController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return Obx(
      () {
        return SizedBox(
          height: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
            child: Column(
              children: [
                Center(
                    child: PeepAnimationEffect(
                  onTap: () {},
                  child: Text(
                    DateFormat('MM월 dd일').format(controller.getSelectedDate()),
                    style: PeepTextStyle.boldM(color: Palette.peepGray500),
                  ),
                )),
                Padding(
                  padding: EdgeInsets.only(bottom: AppValues.verticalMargin),
                  child: SizedBox(
                    height: 90.h,
                    child: PeepMiniCalendar(),
                  ),
                ),
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      ReorderableSliverList(
                        delegate: ReorderableSliverChildListDelegate(
                          [
                            for (var item in controller.scheduledTodoList)
                              if (item is TodoModel)
                                if (!(controller
                                        .categoryFoldMap[item.categoryId] ??
                                    false))
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: AppValues.innerMargin),
                                      child: PeepTodoItem(
                                        todoId: item.id,
                                        color: controller.getColor(
                                            todoId: item.id),
                                        todoType: TodoType.scheduled,
                                      ))
                                else
                                  const SizedBox.shrink()
                              else if (item is CategoryModel)
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: AppValues.innerMargin),
                                  child: PeepCategoryItem(
                                      color: item.color,
                                      name: item.name,
                                      emoji: item.emoji,
                                      onTapAddButton: () {
                                        int pos = controller
                                            .categoryIndexMap[item.id]![1];
                                        Get.bottomSheet(TodoAddModal(
                                          category: item,
                                          pos: pos,
                                          type: TodoType.scheduled,
                                        ));
                                        controller.initCategoryIndexMap(null);
                                        //controller.addTodo(item.id);
                                      },
                                      onTapArrowButton: () {
                                        controller.isCategoryFold(item.id);
                                      },
                                      isFolded:
                                          controller.categoryFoldMap[item.id] ??
                                              false),
                                )
                          ],
                        ),
                        onReorder: (int oldIndex, int newIndex) {
                          controller.reorderTodoList(oldIndex, newIndex);
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
