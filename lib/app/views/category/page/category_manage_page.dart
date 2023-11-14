import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/category_manage_page_controller.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/views/category/widget/peep_category_manage_list_item.dart';
import 'package:peep_todo_flutter/app/views/common/peep_subpage_appbar.dart';
import 'package:reorderables/reorderables.dart';
import '../../../core/base/base_view.dart';

class CategoryManagePage extends BaseView<CategoryManagePageController> {
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
            PeepIcon(
              Iconsax.addcircle,
              size: AppValues.baseIconSize,
              color: Palette.peepGray500,
            ),
          ],
          onTapButtons: [
            () {
              print("add category");
            }
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
                delegate: ReorderableSliverChildListDelegate(
                  [
                    for (int index = 0;
                        index < controller.categoryList.length;
                        index++)
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: AppValues.innerMargin),
                        child: PeepCategoryManageListItem(
                          name: controller.categoryList[index].name,
                          emoji: controller.categoryList[index].emoji,
                          color: controller.categoryList[index].color,
                          onTapEmojiPicker: () {},
                          onTapColorPicker: () {},
                          onTap: () {},
                          onDelete: () {},
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
