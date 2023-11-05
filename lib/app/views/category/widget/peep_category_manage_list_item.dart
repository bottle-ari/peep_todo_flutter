import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
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
  final VoidCallback onTapName;

  const PeepCategoryManageListItem({
    Key? key,
    required this.name,
    required this.emoji,
    required this.color,
    required this.onTapEmojiPicker,
    required this.onTapColorPicker,
    required this.onTapName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppValues.screenWidth - AppValues.screenPadding * 2,
      height: 64.h,
      decoration: BoxDecoration(
        color: Palette.peepWhite,
        borderRadius: BorderRadius.circular(AppValues.baseRadius),
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
                  name,
                  style: PeepTextStyle.boldXL(color: color),
                ),
              ],
            ),
            PeepColorPickerButton(color: color, onTap: onTapColorPicker),
            // PeepColorPickerButton
          ],
        ),
      ),
    );
  }
}
