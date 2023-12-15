import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/data/category_controller.dart';
import 'package:peep_todo_flutter/app/data/model/category/category_model.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/category/widget/peep_color_picker_button.dart';
import 'package:peep_todo_flutter/app/views/category/widget/peep_emoji_picker_button.dart';
import 'package:peep_todo_flutter/app/views/common/popup/confirm_popup.dart';

import '../../../controllers/data/todo_controller.dart';

class PeepCategoryManageListItem extends StatelessWidget {
  final CategoryController controller = Get.find();
  final TodoController todoController = Get.find();
  final CategoryModel category;
  final VoidCallback onTapEmojiPicker;
  final VoidCallback onTapColorPicker;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  PeepCategoryManageListItem({
    Key? key,
    required this.category,
    required this.onTapEmojiPicker,
    required this.onTapColorPicker,
    required this.onTap,
    required this.onDelete,
  }) : super(key: key);

  void deleteCategory() {
    Get.dialog(ConfirmPopup(
      icon: Iconsax.trash,
      text: '삭제',
      hintText: '카테고리 내 모든 [할 일]이 삭제됩니다!',
      hintColor: Palette.peepRed,
      confirmText: '삭제',
      color: Palette.peepRed,
      func: () {
        controller.deleteCategory(category: category);
        todoController.loadAllData();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppValues.baseRadius),
      child: Slidable(
        key: UniqueKey(),
        startActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (BuildContext context) {
                deleteCategory();
              },
              backgroundColor: Palette.peepRed,
              foregroundColor: Colors.white,
              label: '삭제',
            ),
          ],
        ),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: AppValues.screenWidth - AppValues.screenPadding * 2,
            height: AppValues.largeItemHeight,
            decoration: const BoxDecoration(
              color: Palette.peepWhite,
            ),
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      PeepEmojiPickerButton(
                          emoji: category.emoji, onTap: onTapEmojiPicker),
                      // PeepEmojiPickerButton
                      SizedBox(
                        width: AppValues.horizontalMargin * 2,
                      ),
                      Text(
                        category.name.length > 9
                            ? "${category.name.substring(0, 9)}..."
                            : category.name,
                        style: PeepTextStyle.boldXL(color: category.color),
                      ),
                    ],
                  ),
                  PeepColorPickerButton(
                      color: category.color, onTap: onTapColorPicker),
                  // PeepColorPickerButton
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
