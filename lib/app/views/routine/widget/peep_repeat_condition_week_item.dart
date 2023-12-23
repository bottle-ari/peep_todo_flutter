import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/common/popup/peep_warning_popup.dart';
import 'package:peep_todo_flutter/app/views/routine/widget/peep_repeat_condition_check_button.dart';
import 'package:peep_todo_flutter/app/views/routine/widget/peep_repeat_condition_picker.dart';
import 'package:peep_todo_flutter/app/views/routine/widget/peep_week_day_picker_item.dart';

class PeepRepeatConditionWeekItem extends StatelessWidget {
  final String descriptionText;
  final Color color;
  final bool isChecked;
  final Function onCheckButtonTap;
  final List<bool> dayPicked;
  final String boldText;
  final Function onBoldTextTap;
  final bool isMonthly;
  final PeepRepeatConditionPickerController controller;

  const PeepRepeatConditionWeekItem({
    super.key,
    required this.descriptionText,
    required this.color,
    required this.isChecked,
    required this.onCheckButtonTap,
    required this.dayPicked,
    required this.boldText,
    required this.onBoldTextTap,
    required this.isMonthly,
    required this.controller,
  });

  void onDayPicked(int dayInt) {
    if (isMonthly) {
      controller.monthlyDayRepeatIsChecked.value = true;
      List<bool> weekDays = controller.monthlyDayRepeatValue;

      int selectedCount = 0;
      for(int i=0;i<7;i++){
        if(weekDays[i]){
          selectedCount++;
        }
      }
      // 하나 이상의 요일을 선택하도록 예외처리
      if(selectedCount == 1 && weekDays[dayInt]){
        Get.dialog(PeepWarningPopup(
            icon: Iconsax.emptyBox,
            text: '하나 이상의 요일을 선택해주세요!',
            confirmText: '확인',
            color: Palette.peepRed
                .withOpacity(AppValues.baseOpacity)));
      }
      else{
        controller.monthlyDayRepeatValue[dayInt] =
        !controller.monthlyDayRepeatValue[dayInt];
      }
    } else {
      List<bool> weekDays = controller.weeklyDayRepeatValue;

      int selectedCount = 0;
      for(int i=0;i<7;i++){
        if(weekDays[i]){
          selectedCount++;
        }
      }
      // 하나 이상의 요일을 선택하도록 예외처리
      if(selectedCount == 1 && weekDays[dayInt]){
        Get.dialog(PeepWarningPopup(
            icon: Iconsax.emptyBox,
            text: '하나 이상의 요일을 선택해주세요!',
            confirmText: '확인',
            color: Palette.peepRed
                .withOpacity(AppValues.baseOpacity)));
      }
      else{
        controller.weeklyDayRepeatValue[dayInt] =
        !controller.weeklyDayRepeatValue[dayInt];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: AppValues.screenWidth - AppValues.screenPadding * 2,
        height: 88.h,
        decoration: BoxDecoration(
          border: Border.all(color: Palette.peepGray200),
          borderRadius: BorderRadius.circular(AppValues.baseRadius),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: AppValues.innerMargin,
                  right: AppValues.innerMargin * 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      PeepRepeatConditionCheckButton(
                        color: color,
                        isChecked: isChecked,
                        onTap: onCheckButtonTap,
                      ),
                      Text(
                        descriptionText,
                        style: PeepTextStyle.regularS(color: Palette.peepBlack),
                      ),
                    ],
                  ),
                  if (isMonthly)
                    GestureDetector(
                      onTap: () {
                        onBoldTextTap();
                      },
                      child: Row(
                        children: [
                          Text(
                            "매 월",
                            style: PeepTextStyle.regularM(
                                color: Palette.peepBlack),
                          ),
                          SizedBox(width: AppValues.innerMargin),
                          Text(
                            boldText,
                            style:
                                PeepTextStyle.boldL(color: Palette.peepGray500),
                          ),
                          SizedBox(width: AppValues.innerMargin),
                          Text(
                            "번째",
                            style: PeepTextStyle.regularM(
                                color: Palette.peepBlack),
                          ),
                        ],
                      ),
                    )
                  else
                    Container(color: Colors.transparent),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppValues.screenPadding,
                  vertical: AppValues.innerMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PeepWeekDayPickerItem(
                    dayText: '일',
                    dayInt: 6,
                    onTap: onDayPicked,
                    dayPicked: isMonthly
                        ? controller.monthlyDayRepeatValue[6]
                        : controller.weeklyDayRepeatValue[6],
                    color: color,
                    textColor: Palette.peepRed,
                  ),
                  PeepWeekDayPickerItem(
                    dayText: '월',
                    dayInt: 0,
                    onTap: onDayPicked,
                    dayPicked: isMonthly
                        ? controller.monthlyDayRepeatValue[0]
                        : controller.weeklyDayRepeatValue[0],
                    color: color,
                    textColor: Palette.peepGray500,
                  ),
                  PeepWeekDayPickerItem(
                    dayText: '화',
                    dayInt: 1,
                    onTap: onDayPicked,
                    dayPicked: isMonthly
                        ? controller.monthlyDayRepeatValue[1]
                        : controller.weeklyDayRepeatValue[1],
                    color: color,
                    textColor: Palette.peepGray500,
                  ),
                  PeepWeekDayPickerItem(
                    dayText: '수',
                    dayInt: 2,
                    onTap: onDayPicked,
                    dayPicked: isMonthly
                        ? controller.monthlyDayRepeatValue[2]
                        : controller.weeklyDayRepeatValue[2],
                    color: color,
                    textColor: Palette.peepGray500,
                  ),
                  PeepWeekDayPickerItem(
                    dayText: '목',
                    dayInt: 3,
                    onTap: onDayPicked,
                    dayPicked: isMonthly
                        ? controller.monthlyDayRepeatValue[3]
                        : controller.weeklyDayRepeatValue[3],
                    color: color,
                    textColor: Palette.peepGray500,
                  ),
                  PeepWeekDayPickerItem(
                    dayText: '금',
                    dayInt: 4,
                    onTap: onDayPicked,
                    dayPicked: isMonthly
                        ? controller.monthlyDayRepeatValue[4]
                        : controller.weeklyDayRepeatValue[4],
                    color: color,
                    textColor: Palette.peepGray500,
                  ),
                  PeepWeekDayPickerItem(
                    dayText: '토',
                    dayInt: 5,
                    onTap: onDayPicked,
                    dayPicked: isMonthly
                        ? controller.monthlyDayRepeatValue[5]
                        : controller.weeklyDayRepeatValue[5],
                    color: color,
                    textColor: Palette.peepBlue,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
