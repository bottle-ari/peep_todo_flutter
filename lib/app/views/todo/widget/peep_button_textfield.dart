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
                  hintText: '이름을 입력해 주세요',
                  hintStyle: PeepTextStyle.regularL(color: Palette.peepGray300),
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
  final VoidCallback onLongPressAddButton;
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final VoidCallback onTapTextField;

  const PeepCategoryTextfield({
    Key? key,
    required this.emoji,
    required this.color,
    required this.onTapEmoji,
    required this.onTapAddButton,
    required this.onLongPressAddButton,
    required this.textEditingController,
    required this.focusNode,
    required this.onTapTextField,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // handle submit(TextField) & onTap(AddButton) event
    void handleAddButtonTap(String text) {
      if (text.trim().isNotEmpty) {
        onTapAddButton(text);
      } else {
        textEditingController.text = "";
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
            PeepEmojiPickerButton(
              emoji: emoji,
              onTap: onTapEmoji,
            ),
            // PeepEmojiPickerButton
            SizedBox(
              width: 230.w,
              child: TextField(
                onTap: onTapTextField,
                focusNode: focusNode,
                controller: textEditingController,
                onSubmitted: handleAddButtonTap,
                autofocus: true,
                style: PeepTextStyle.regularL(color: Palette.peepBlack),
                cursorColor: color,
                decoration: InputDecoration(
                  border: InputBorder.none, // 밑줄 제거
                  hintText: '이름을 입력해 주세요',
                  hintStyle: PeepTextStyle.regularL(color: Palette.peepGray300),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                handleAddButtonTap(textEditingController.text);
              },
              onLongPress: onLongPressAddButton,
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
