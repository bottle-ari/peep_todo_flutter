import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/category/widget/peep_emoji_picker_button.dart';

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

  void handleAddButtonTap(String text) {
    onTapAddButton(text);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

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
            icon,
            // PeepEmojiPickerButton
            SizedBox(
              width: 230.w,
              child: TextField(
                controller: controller,
                onSubmitted: handleAddButtonTap,
                style: PeepTextStyle.boldL(color: Palette.peepBlack),
                cursorColor: color,
                decoration: InputDecoration(
                  border: InputBorder.none, // 밑줄 제거
                  hintText: '이름을 입력해 주세요',
                  hintStyle: PeepTextStyle.boldL(color: Palette.peepGray300),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                handleAddButtonTap(controller.text);
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
  final String emoji;
  final Color color;
  final VoidCallback onTapEmoji;
  final Function(String) onTapAddButton;

  const PeepCategoryTextfield({
    Key? key,
    required this.emoji,
    required this.color,
    required this.onTapEmoji,
    required this.onTapAddButton,
  }) : super(key: key);

  void handleAddButtonTap(String text) {
    onTapAddButton(text);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

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
            PeepEmojiPickerButton(
              emoji: emoji,
              onTap: onTapEmoji,
            ),
            // PeepEmojiPickerButton
            SizedBox(
              width: 230.w,
              child: TextField(
                controller: controller,
                onSubmitted: handleAddButtonTap,
                style: PeepTextStyle.boldL(color: Palette.peepBlack),
                cursorColor: color,
                decoration: InputDecoration(
                  border: InputBorder.none, // 밑줄 제거
                  hintText: '이름을 입력해 주세요',
                  hintStyle: PeepTextStyle.boldL(color: Palette.peepGray300),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                handleAddButtonTap(controller.text);
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
