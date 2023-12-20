import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_animation_effect.dart';

class PeepHalfButton extends StatelessWidget {
  final Color color;
  final VoidCallback onTap;
  final String text;
  final Color textColor;
  final PeepIcon icon;

  const PeepHalfButton({
    Key? key,
    required this.color,
    required this.onTap,
    required this.text,
    required this.textColor,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PeepAnimationEffect(
      onTap: onTap,
      child: Container(
        height: AppValues.baseItemHeight,
        width: 172.w,
        decoration: BoxDecoration(
          border: Border.all(color: Palette.peepGray200),
          borderRadius: BorderRadius.circular(AppValues.baseRadius),
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 1.5 * AppValues.horizontalMargin),
                child: icon,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: AppValues.horizontalMargin),
                    child:
                        Text(text, style: text.length > 8 ? PeepTextStyle.regularXS(color: textColor) : PeepTextStyle.regularM(color: textColor))
              ),
            ),
          ],
        ),
      ),
    );
  }
}
