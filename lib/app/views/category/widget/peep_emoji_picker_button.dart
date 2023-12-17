import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_animation_effect.dart';

import '../../../theme/app_values.dart';

class PeepEmojiPickerButton extends StatelessWidget {
  final String emoji;
  final VoidCallback onTap;

  const PeepEmojiPickerButton({
    Key? key,
    required this.emoji,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PeepAnimationEffect(
      onTap: onTap,
      child: emoji == ""
          ? PeepIcon(
              Iconsax.emoji,
              color: Palette.peepYellow400,
              size: 30.w,
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: AppValues.innerMargin),
              child: Text(
                emoji,
                style: PeepTextStyle.regularXL(color: null),
              ),
            ),
    );
  }
}
