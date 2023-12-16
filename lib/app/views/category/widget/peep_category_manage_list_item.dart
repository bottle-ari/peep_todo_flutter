import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/data/category_controller.dart';
import 'package:peep_todo_flutter/app/data/model/category/category_model.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/category/widget/peep_category_toggle_button.dart';
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
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Palette.peepGray200),
        borderRadius: BorderRadius.circular(AppValues.baseRadius),
      ),
      child: ClipRRect(
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
          child: InkWell(
            onTap: onTap,
            child: Container(
              width: AppValues.screenWidth - AppValues.screenPadding * 2,
              height: AppValues.largeItemHeight,
              color:
                  category.isActive ? Palette.peepWhite : Palette.peepGray100,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: AppValues.horizontalMargin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: AppValues.innerMargin,
                        ),
                        if (category.isActive)
                          Text(
                            category.emoji,
                            style: PeepTextStyle.regularL(),
                          )
                        else
                          ColorFiltered(
                            colorFilter: const ColorFilter.matrix([
                              0.2126, 0.7152, 0.0722, 0, 0,
                              0.2126, 0.7152, 0.0722, 0, 0,
                              0.2126, 0.7152, 0.0722, 0, 0,
                              0,      0,      0,      1, 0,
                            ]),
                            child: Text(
                              category.emoji,
                              style: PeepTextStyle.regularL(),
                            ),
                          ),
                        // PeepEmojiPickerButton
                        SizedBox(
                          width: AppValues.horizontalMargin,
                        ),
                        if(category.isActive)
                          Text(
                            category.name.length > 9
                                ? "${category.name.substring(0, 9)}..."
                                : category.name,
                            style: PeepTextStyle.boldL(color: category.color),
                          )
                        else
                          ColorFiltered(
                            colorFilter: const ColorFilter.matrix([
                              0.2126, 0.7152, 0.0722, 0, 0,
                              0.2126, 0.7152, 0.0722, 0, 0,
                              0.2126, 0.7152, 0.0722, 0, 0,
                              0,      0,      0,      1, 0,
                            ]),
                            child: Text(
                              category.name.length > 9
                                  ? "${category.name.substring(0, 9)}..."
                                  : category.name,
                              style: PeepTextStyle.boldL(color: category.color),
                            ),
                          ),
                      ],
                    ),
                    PeepCategoryToggleButton(
                      category: category,
                      controller: controller,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
