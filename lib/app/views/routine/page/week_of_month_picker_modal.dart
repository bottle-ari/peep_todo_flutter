import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import '../widget/peep_week_of_month_picker_item.dart';

class WeekOfMonthPickerModal extends StatelessWidget {
  final int currentWeekValue;
  final Function(int) onWeekPicked;

  const WeekOfMonthPickerModal({
    super.key,
    required this.onWeekPicked,
    required this.currentWeekValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.peepWhite,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(AppValues.baseRadius),
            topLeft: Radius.circular(AppValues.baseRadius)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: AppValues.verticalMargin,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: AppValues.verticalMargin,
              bottom: AppValues.verticalMargin,
              left: AppValues.screenPadding,
            ),
            child: Text(
              '주차 선택',
              style: PeepTextStyle.boldL(color: Palette.peepGray500),
            ),
          ),
          for (int i = 1; i <= 6; i++)
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppValues.screenPadding / 2),
              child: PeepWeekOfMonthPickerItem(
                weekValue: i,
                onTap: () {
                  onWeekPicked(i);
                  Get.back();
                },
                isCurrentWeek: i == currentWeekValue,
              ),
            ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}
