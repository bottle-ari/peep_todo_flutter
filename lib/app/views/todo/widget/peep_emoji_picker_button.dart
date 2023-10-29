import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';

class PeepEmojiPickerButton extends StatelessWidget {
  final String? emoji;
  final VoidCallback onTap;

  const PeepEmojiPickerButton({
    Key? key,
    required this.emoji,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      highlightColor: Palette.peepGray300, // 클릭 시 배경 어둡게
      child: emoji == null
          ? PeepIcon(
              Iconsax.emoji,
              color: Palette.peepYellow400,
              size: 30.w,
            )
          : Text(
              emoji!,
              style: PeepTextStyle.regularXL(null),
            ),
    );
  }
}
