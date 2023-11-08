import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/views/todo/widget/peep_category_item.dart';
import 'package:reorderables/reorderables.dart';

import '../../../controllers/page/scheduled_todo_controller.dart';
import '../../../core/base/base_view.dart';
import '../widget/peep_todo_item.dart';

class ScheduledTodoPage extends BaseView<ScheduledTodoController> {
  final date = '20231109';

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return Obx(
          () =>
          SizedBox(
            height: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppValues.screenPadding),
              child: CustomScrollView(
                slivers: [
                  ReorderableSliverList(
                      delegate: ReorderableSliverChildListDelegate([
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: AppValues.verticalMargin),
                          child: PeepCategoryItem(color: Palette.peepBlue,
                              name: '할 일',
                              emoji: '😎',
                              onTapAddButton: () {},
                              onTapArrowButton: () {},
                              isFolded: false),
                        ),
                        for (int index = 0;
                        index < controller
                            .getTodoList(date: date)
                            .length;
                        index++)
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: AppValues.innerMargin),
                            child: PeepTodoItem(
                              color: Palette.peepBlue,
                              index: index,
                              controller: controller,
                              date: date,
                            ),
                          )
                      ],),
                      onReorder: (int oldIndex, int newIndex) {
                        controller.reorderTodoList(date, oldIndex, newIndex);
                      },
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
