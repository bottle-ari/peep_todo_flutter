import 'package:flutter/material.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';

class PeepWeekDayPickerItem extends StatelessWidget {
  final int dayInt;
  final String dayText;
  final Function(int) onTap;
  final bool dayPicked;
  final Color color;
  final Color textColor;

  const PeepWeekDayPickerItem({
    super.key,
    required this.dayInt,
    required this.onTap,
    required this.dayPicked,
    required this.color,
    required this.dayText,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(dayInt);
      },
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: AppValues.verticalMargin,
              horizontal: AppValues.horizontalMargin * 1.2),
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (dayPicked)
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color.withOpacity(AppValues.halfOpacity),
                  ),
                  width: AppValues.smallIconSize,
                  height: AppValues.smallIconSize,
                )
              else
                Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.transparent),
                  width: AppValues.smallIconSize,
                  height: AppValues.smallIconSize,
                ),
              Text(
                dayText,
                style: PeepTextStyle.boldXS(color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
