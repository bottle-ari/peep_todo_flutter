import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/todo/widget/peep_color_picker_button.dart';
import 'package:peep_todo_flutter/app/views/todo/widget/peep_emoji_picker_button.dart';

class PeepCategoryInputField extends StatelessWidget {
  final String name;
  final String emoji;
  final Color color;
  final VoidCallback onTapEmojiPicker;
  final VoidCallback onTapColorPicker;
  final ValueChanged<String> onNameChanged;

  const PeepCategoryInputField({
    Key? key,
    required this.name,
    required this.emoji,
    required this.color,
    required this.onTapEmojiPicker,
    required this.onTapColorPicker,
    required this.onNameChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PeepEmojiPickerButton(emoji: emoji, onTap: onTapEmojiPicker),
                // PeepEmojiPickerButton
                SizedBox(
                  width: 230.w,
                  child: TextField(
                    onChanged: (text) {
                      onNameChanged(text);
                    },
                    style: PeepTextStyle.boldXL(Palette.peepBlack),
                    cursorColor: Palette.peepYellow400,
                    decoration: InputDecoration(
                      border: InputBorder.none, // 밑줄 제거
                      hintText: '이름을 입력해 주세요',
                      hintStyle: PeepTextStyle.boldXL(Palette.peepGray300),
                    ),
                  ),
                ),
                PeepColorPickerButton(color: color, onTap: onTapColorPicker),
                // PeepColorPickerButton
              ],
            ),
          ),
          const Divider(
            height: 0,
            thickness: 1,
            color: Palette.peepYellow400,
          ),
        ],
      ),
    );
  }
}
