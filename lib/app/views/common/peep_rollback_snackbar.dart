import 'package:flutter/material.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';

class PeepRollbackSnackbar extends StatelessWidget {
  final PeepIcon icon;
  final String boldText;
  final String regularText;
  final VoidCallback onTapRollback;

  const PeepRollbackSnackbar({
    Key? key,
    required this.icon,
    required this.boldText,
    required this.regularText,
    required this.onTapRollback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppValues.screenWidth - AppValues.screenPadding * 2,
      height: AppValues.baseItemHeight,
      decoration: BoxDecoration(
        color: Palette.peepBlack.withOpacity(AppValues.baseOpacity),
        borderRadius: BorderRadius.circular(AppValues.baseRadius),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppValues.horizontalMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                icon,
                SizedBox(
                  width: AppValues.horizontalMargin,
                ),
                Text(
                  boldText.length > 10
                      ? "${boldText.substring(0, 10)}..."
                      : boldText,
                  style: PeepTextStyle.boldL(color: Palette.peepWhite),
                ),
                SizedBox(
                  width: AppValues.innerMargin,
                ),
                Text(
                  regularText,
                  style: PeepTextStyle.regularL(color: Palette.peepWhite),
                ),
              ],
            ),
            GestureDetector(
              onTap: onTapRollback,
              child: PeepIcon(
                Iconsax.rollback,
                size: AppValues.largeIconSize,
                color: Palette.peepYellow300,
              ),
            )
          ],
        ),
      ),
    );
  }
}
