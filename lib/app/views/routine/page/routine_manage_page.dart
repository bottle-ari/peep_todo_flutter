import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/routine_manage_controller.dart';
import 'package:peep_todo_flutter/app/data/model/category/category_model.dart';
import 'package:peep_todo_flutter/app/data/model/routine/routine_model.dart';
import 'package:peep_todo_flutter/app/routes/app_pages.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/views/common/peep_subpage_appbar.dart';
import 'package:peep_todo_flutter/app/views/routine/widget/peep_routine_manage_category_item.dart';
import 'package:peep_todo_flutter/app/views/routine/widget/peep_routine_manage_list_item.dart';
import 'package:reorderables/reorderables.dart';
import '../../../core/base/base_view.dart';

class RoutineManagePage extends BaseView<RoutineManageController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(AppValues.appbarHeight),
      child: SafeArea(
        child: PeepSubpageAppbar(
          title: "루틴 관리",
          onTapBackArrow: () {
            Get.back();
          },
          buttons: const [],
        ),
      ),
    );
  }

  @override
  Widget body(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
          child: CustomScrollView(
            slivers: [
              ReorderableSliverList(
                buildDraggableFeedback: (BuildContext context,
                    BoxConstraints constraints, Widget child) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.zero,
                    child: Material(
                      type: MaterialType.transparency,
                      child: ConstrainedBox(
                        constraints: constraints,
                        child: Transform.scale(scale: 1.05, child: child),
                      ),
                    ),
                  );
                },
                delegate: ReorderableSliverChildListDelegate(
                  [
                    for (var item in controller.routineList)
                      if (item is RoutineModel)
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: AppValues.innerMargin),
                          child: PeepRoutineManageListItem(
                            routine: item,
                            onTap: () {
                              // routine detail 로 넘어가기
                              Get.toNamed(
                                Routes.ROUTINE_DETAIL_PAGE,
                                arguments: {
                                  'category_id': item.categoryId,
                                  'routine_id': item.id,
                                },
                              );
                            },
                          ),
                        )
                      else if (item is CategoryModel)
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: AppValues.innerMargin),
                          child: PeepRoutineManageCategoryItem(
                            category: item,
                            onTapAddButton: () {
                              // Routine Add Page로 넘어가기
                              Get.toNamed(
                                Routes.ROUTINE_ADD_PAGE,
                                arguments: {
                                  'category_id': item.id,
                                  'last_pos':
                                      controller.categoryIndexMap[item.id]![1],
                                },
                              );
                            },
                            isFolded: false,
                          ),
                        )
                  ],
                ),
                onReorder: (int oldIndex, int newIndex) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
