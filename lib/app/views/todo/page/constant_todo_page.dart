import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/constant_todo_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_view.dart';
import 'package:reorderables/reorderables.dart';

import '../../../theme/app_values.dart';
import '../widget/peep_category_item.dart';
import '../widget/peep_todo_item.dart';

class ConstantTodoPage extends BaseView<ConstantTodoController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return Obx(
          () {
            const date = 'constant';
        return SizedBox(
          height: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
            child: Column(
              children: [
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
                                      },
                                      isFolded: false),
                                )
                              else
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