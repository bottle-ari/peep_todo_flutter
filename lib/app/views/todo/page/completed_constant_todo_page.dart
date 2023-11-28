import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/completed_constant_todo_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_view.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:reorderables/reorderables.dart';

import '../../../theme/app_values.dart';
import '../../common/peep_subpage_appbar.dart';
import '../widget/peep_category_item.dart';
import '../widget/peep_todo_item.dart';

class CompletedConstantTodoPage
    extends BaseView<CompletedConstantTodoController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(AppValues.appbarHeight),
        child: SafeArea(
          child: PeepSubpageAppbar(
            title: '완료된 Todo',
            onTapBackArrow: () {
              Get.back();
            },
            onTapButtons: [
              () {}
            ],
            buttons: [
              PeepIcon(
                Iconsax.clipboardDelete,
                size: AppValues.baseIconSize,
                color: Palette.peepRed,
              )
            ],
          ),
        ));
  }

  @override
  Widget body(BuildContext context) {
    return Container();
    // return Obx(
    //       () {
    //     const date = 'constant';
    //     return SizedBox(
    //       height: double.infinity,
    //       child: Padding(
    //         padding: EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
    //         child: Column(
    //           children: [
    //             Expanded(
    //               child: CustomScrollView(
    //                 slivers: [
    //                   ReorderableSliverList(
    //                     delegate: ReorderableSliverChildListDelegate(
    //                       [
    //                         for (int index = 0;
    //                         index <
    //                             controller.getTodoList(date: date).length;
    //                         index++)
    //                           if (controller.isCategoryModel(date, index))
    //                             Padding(
    //                               padding: EdgeInsets.symmetric(
    //                                   vertical: AppValues.verticalMargin),
    //                               child: PeepCategoryItem(
    //                                   color: controller
    //                                       .getTodoList(date: date)[index]
    //                                       .color,
    //                                   name: controller
    //                                       .getTodoList(date: date)[index]
    //                                       .name,
    //                                   emoji: controller
    //                                       .getTodoList(date: date)[index]
    //                                       .emoji,
    //                                   onTapAddButton: () {
    //                                   },
    //                                   onTapArrowButton: () {
    //                                   },
    //                                   isFolded: false),
    //                             )
    //                           else
    //                             Padding(
    //                               padding: EdgeInsets.symmetric(
    //                                   vertical: AppValues.innerMargin),
    //                               child: PeepTodoItem(
    //                                 color: controller.todoColor(date, index),
    //                                 index: index,
    //                                 controller: controller,
    //                                 date: date,
    //                               ),
    //                             )
    //                       ],
    //                     ),
    //                     onReorder: (int oldIndex, int newIndex) {
    //                       controller.reorderTodoList(date, oldIndex, newIndex);
    //                     },
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}
