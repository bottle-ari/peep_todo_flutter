import 'package:flutter/material.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';

class PeepWeekOfMonthPickerItem extends StatelessWidget {
  final int weekValue;
  final bool isCurrentWeek;
  final VoidCallback onTap;

  const PeepWeekOfMonthPickerItem({
    Key? key,
    required this.weekValue,
    required this.isCurrentWeek,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Palette.peepWhite,
          borderRadius: BorderRadius.all(
            Radius.circular(AppValues.baseRadius),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: AppValues.horizontalMargin,
            bottom: AppValues.horizontalMargin,
            left: AppValues.screenPadding / 2,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (isCurrentWeek)
                Padding(
                  padding: EdgeInsets.only(right: AppValues.horizontalMargin),
                  child: PeepIcon(
                    Iconsax.checkBold,
                    size: AppValues.smallIconSize,
                    color: Palette.peepGray500,
                  ),
                )
              else
                Padding(
                  padding: EdgeInsets.only(right: AppValues.horizontalMargin),
                  child: PeepIcon(
                    Iconsax.checkTrue,
                    size: AppValues.smallIconSize,
                    color: Palette.peepGray500,
                  ),
                ),
              Text(
                weekValue != 6 ? "$weekValue 번째 주" : "마지막 주",
                style: PeepTextStyle.regularM(color: Palette.peepGray500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
