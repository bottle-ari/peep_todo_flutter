import 'package:flutter/material.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/category/widget/peep_color_picker_button.dart';
import 'package:peep_todo_flutter/app/views/category/widget/peep_emoji_picker_button.dart';

class PeepCategoryManageListItem extends StatelessWidget {
  final String name;
  final String emoji;
  final Color color;
  final VoidCallback onTapEmojiPicker;
  final VoidCallback onTapColorPicker;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const PeepCategoryManageListItem({
    Key? key,
    required this.name,
    required this.emoji,
    required this.color,
    required this.onTapEmojiPicker,
    required this.onTapColorPicker,
    required this.onTap,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppValues.baseRadius),
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        background: Container(
          color: Palette.peepRed,
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: AppValues.horizontalMargin),
            child: PeepIcon(
              Iconsax.trash,
              color: Palette.peepWhite,
              size: AppValues.baseIconSize,
            ),
          ),
        ),
        confirmDismiss: (DismissDirection direction) async {
          onDelete();
          //Todo : 여기 true로 변경해야 함
          return false;
        },
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: AppValues.screenWidth - AppValues.screenPadding * 2,
            height: AppValues.largeItemHeight,
            decoration: const BoxDecoration(
              color: Palette.peepWhite,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      PeepEmojiPickerButton(
                          emoji: emoji, onTap: onTapEmojiPicker),
                      // PeepEmojiPickerButton
                      SizedBox(
                        width: AppValues.horizontalMargin*2,
                      ),
                      Text(
                        name.length > 9
                            ? "${name.substring(0, 9)}..."
                            : name,
                        style: PeepTextStyle.boldXL(color: color),
                      ),
                    ],
                  ),
                  PeepColorPickerButton(color: color, onTap: onTapColorPicker),
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
