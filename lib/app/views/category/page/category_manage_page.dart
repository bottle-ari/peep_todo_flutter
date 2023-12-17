import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/data/category_controller.dart';
import 'package:peep_todo_flutter/app/routes/app_pages.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/views/category/widget/peep_category_manage_list_item.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_animation_effect.dart';
import 'package:peep_todo_flutter/app/views/common/peep_subpage_appbar.dart';
import 'package:reorderables/reorderables.dart';
import '../../../core/base/base_view.dart';

class CategoryManagePage extends BaseView<CategoryController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(AppValues.appbarHeight),
      child: SafeArea(
        child: PeepSubpageAppbar(
          title: "카테고리 관리",
          onTapBackArrow: () {
            Get.back();
          },
          buttons: [
            PeepAnimationEffect(
              onTap: () {
                log('add category');
                //TODO : add category;
              },
              child: PeepIcon(
                Iconsax.addSquareOutline,
                size: AppValues.baseIconSize,
                color: Palette.peepGray500,
              ),
            ),
          ],
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
                        child: Transform.scale(
                            scale: 1.05, child: child),
                      ),
                    ),
                  );
                },
                delegate: ReorderableSliverChildListDelegate(
                  [
                    for (var category in controller.categoryList)
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: AppValues.innerMargin),
                        child: PeepCategoryManageListItem(
                          category: category,
                          onTap: () {
                            Get.toNamed(AppPages.CATEGORY_DETAIL, arguments: {'category_id': category.id});
                          },
                        ),
                      )
                  ],
                ),
                onReorder: (int oldIndex, int newIndex) {
                  controller.reorderCategoryList(oldIndex, newIndex);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
