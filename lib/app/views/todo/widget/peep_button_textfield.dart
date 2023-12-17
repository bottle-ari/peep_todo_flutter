import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/category_detail_controller.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/utils/custom_color_selection_handle.dart';
import 'package:peep_todo_flutter/app/views/category/widget/peep_color_picker_button.dart';
import 'package:peep_todo_flutter/app/views/category/widget/peep_emoji_picker_button.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_animation_effect.dart';

/*
   PeepTodoTextfield
*/
class PeepTodoTextfield extends StatelessWidget {
  final PeepIcon icon;
  final Color color;
  final VoidCallback onTapPriority;
  final Function(String) onTapAddButton;

  const PeepTodoTextfield({
    Key? key,
    required this.icon,
    required this.color,
    required this.onTapPriority,
    required this.onTapAddButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // define TextEditingController
    TextEditingController controller = TextEditingController();

    // handle submit(TextField) & onTap(AddButton) event
    void handleAddButtonTap(String text) {
      if (text.trim().isNotEmpty) {
        onTapAddButton(text);
      } else {
        controller.text = "";
      }
    }

    return Container(
      width: AppValues.screenWidth - AppValues.screenPadding * 2,
      height: AppValues.largeItemHeight,
      decoration: BoxDecoration(
        color: Palette.peepGray50,
        borderRadius: BorderRadius.circular(AppValues.baseRadius),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppValues.horizontalMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: onTapPriority,
              child: icon,
            ),
            // PeepEmojiPickerButton
            SizedBox(
              width: 230.w,
              child: TextField(
                controller: controller,
                onSubmitted: handleAddButtonTap,
                autofocus: true,
                style: PeepTextStyle.regularL(color: Palette.peepBlack),
                cursorColor: color,
                decoration: InputDecoration(
                  border: InputBorder.none, // 밑줄 제거
                  hintText: '할 일을 입력해 주세요',
                  hintStyle: PeepTextStyle.regularL(color: Palette.peepGray300),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                handleAddButtonTap(controller.text);
                controller.text = '';
              },
              child: PeepIcon(
                Iconsax.addSquare,
                size: AppValues.largeIconSize,
                color: color,
              ),
            ),
            // PeepColorPickerButton
          ],
        ),
      ),
    );
  }
}

/*
   PeepCategoryTextfield
*/
class PeepCategoryTextfield extends StatelessWidget {
  final CategoryDetailController controller;

  const PeepCategoryTextfield({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppValues.screenWidth - AppValues.screenPadding * 2,
      height: AppValues.largeItemHeight,
      decoration: BoxDecoration(
        color: Palette.peepWhite,
        border: Border.all(color: Palette.peepGray200),
        borderRadius: BorderRadius.circular(AppValues.baseRadius),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppValues.horizontalMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PeepEmojiPickerButton(
              emoji: controller.category.value.emoji,
              onTap: () {
                controller.focusNode.unfocus();
              },
              color: controller.category.value.color,
              onSelected: (String emoji) {
                controller.updateEmoji(emoji);
                Get.back();
              },
            ),
            SizedBox(
              width: 230.w,
              child: Theme(
                data: ThemeData.light().copyWith(
                  textSelectionTheme: TextSelectionThemeData(
                    cursorColor: controller.category.value.color, // works on iOS
                    selectionColor: controller.category.value.color, // works on iOS
                    selectionHandleColor: controller.category.value.color, // not working on iOS
                  ),
                  cupertinoOverrideTheme: CupertinoThemeData(
                    primaryColor: controller.category.value.color, // alternative on iOS for "selectionHandleColor"
                  ),
                ),
                child: TextField(
                  focusNode: controller.focusNode,
                  controller: controller.textEditingController,
                  autofocus: true,
                  selectionControls: CustomColorSelectionHandle(controller.category.value.color),
                  onSubmitted: (String str) => controller.onEditingDone(),
                  style: PeepTextStyle.regularL(color: Palette.peepBlack),
                  cursorColor: controller.category.value.color,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '이름을 입력해 주세요',
                    hintStyle: PeepTextStyle.regularL(color: Palette.peepGray300),
                  ),
                ),
              ),
            ),
            PeepColorPickerButton(
              color: controller.category.value.color,
              onTap: () {
                controller.focusNode.unfocus();
              },
              onSelected: (Color color) {
                controller.updateColor(color);
                Get.back();
              },
            ),
            // PeepColorPickerButton
          ],
        ),
      ),
    );
  }
}
