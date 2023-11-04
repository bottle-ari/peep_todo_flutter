import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';

class PeepSquareButton extends StatelessWidget {
  final PeepIcon icon;
  final String text;
  final Function() onTap;

  const PeepSquareButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: (AppValues.screenWidth -
                AppValues.screenPadding * 2 -
                AppValues.horizontalMargin * 2) /
            3,
        height: 80.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppValues.baseRadius),
          color: Palette.peepWhite,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(
              height: AppValues.verticalMargin / 2,
            ),
            Text(
              text,
              style: PeepTextStyle.regularS(),
            ),
          ],
        ),
      ),
    );
  }
}
