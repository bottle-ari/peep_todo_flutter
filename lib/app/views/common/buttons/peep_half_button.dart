import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';

class PeepHalfButton extends StatelessWidget {
  final Color color;
  final VoidCallback onTap;
  final VoidCallback onTapCancel;
  final String text;
  final Color textColor;
  final PeepIcon icon;
  final bool isDate;

  const PeepHalfButton({
    Key? key,
    required this.color,
    required this.onTap,
    required this.onTapCancel,
    required this.text,
    required this.textColor,
    required this.icon,
    required this.isDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppValues.baseItemHeight,
        width: 172.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppValues.baseRadius), // 48.w / 2
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
                padding: EdgeInsets.only(left: 2 * AppValues.horizontalMargin),
                    child:
                        Text(text, style: PeepTextStyle.boldM(color: textColor))
              ),
            ),
            Padding(
                padding: EdgeInsets.only(right: 1.5 * AppValues.horizontalMargin),
                child: isDate
                    ? GestureDetector(
                        onTap: onTapCancel,
                        child: PeepIcon(Iconsax.cancel,
                            size: AppValues.smallRadius, color: Palette.peepWhite))
                    : null),
          ],
        ),
      ),
    );
  }
}
