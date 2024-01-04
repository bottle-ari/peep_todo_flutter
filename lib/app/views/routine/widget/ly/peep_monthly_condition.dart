import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/views/routine/page/day_of_month_picker_modal.dart';
import 'package:peep_todo_flutter/app/views/routine/page/week_of_month_picker_modal.dart';
import 'package:peep_todo_flutter/app/views/routine/widget/peep_repeat_condition_item.dart';
import 'package:peep_todo_flutter/app/views/routine/widget/peep_repeat_condition_picker.dart';
import 'package:peep_todo_flutter/app/views/routine/widget/peep_repeat_condition_week_item.dart';

import '../../../../utils/routine_util.dart';
import '../../../common/peep_date_picker.dart';

class PeepMonthlyCondition extends StatelessWidget {
  final PeepRepeatConditionPickerController controller;
  final Color color;

  const PeepMonthlyCondition({
    super.key,
    required this.controller,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: AppValues.innerMargin),
            child: PeepRepeatConditionWeekItem(
              descriptionText: "요일로 반복하기",
              color: color,
              isChecked: controller.monthlyDayRepeatIsChecked.value,
              onCheckButtonTap: () {
                // 요일로 반복하기 혹은, 상세히 반복하기 둘중 하나만 켜지도록
                controller.monthlyDayRepeatIsChecked.value =
                    !controller.monthlyDayRepeatIsChecked.value;
              },
              dayPicked: controller.monthlyDayRepeatValue,
              boldText: controller.monthlyDayRepeatOrdinalValue.value != 6
                  ? controller.monthlyDayRepeatOrdinalValue.toString()
                  : '마지막',
              onBoldTextTap: () {
                Get.bottomSheet(
                  WeekOfMonthPickerModal(
                    onWeekPicked: (int weekValue) {
                      controller.monthlyDayRepeatOrdinalValue.value = weekValue;
                    },
                    currentWeekValue:
                        controller.monthlyDayRepeatOrdinalValue.value,
                  ),
                );
              },
              isMonthly: true,
              controller: controller,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: AppValues.innerMargin),
            child: PeepRepeatConditionItem(
              descriptionText: "상세히 반복하기",
              boldText: controller.monthlyDetailRepeatValue.value != 32
                  ? controller.monthlyDetailRepeatValue.value.toString()
                  : '마지막',
              postfixText: "일에",
              color: color,
              isChecked: !controller.monthlyDayRepeatIsChecked.value,
              onCheckButtonTap: () {
                // 요일로 반복하기 혹은, 상세히 반복하기 둘중 하나만 켜지도록
                controller.monthlyDayRepeatIsChecked.value =
                    !controller.monthlyDayRepeatIsChecked.value;
              },
              onBoldTextTap: () {
                // Todo : 날짜 picker 띄우기, 1일 ~ 31일 + 마지막 날
                // controller.monthlyDetailRepeatValue.value++;
                Get.bottomSheet(DayOfMonthPickerModal(
                    onDayPicked: (int value) {
                      controller.monthlyDetailRepeatValue.value = value;
                    },
                    currentDayValue: controller.monthlyDetailRepeatValue.value,
                    color: color));
              },
              prefixText: '매 월',
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: AppValues.innerMargin),
            child: PeepRepeatConditionItem(
              descriptionText: "반복 종료일 설정",
              boldText: controller.endDate.value,
              postfixText: "까지",
              color: color,
              isChecked: controller.endIsChecked.value,
              onCheckButtonTap: () {
                controller.endIsChecked.value = !controller.endIsChecked.value;
              },
              onBoldTextTap: () {
                Get.bottomSheet(
                  PeepDatePicker(
                    date: convertToDateTime(controller.endDate.value),
                    color: color,
                    onConfirm: (DateTime date) {
                      controller.endDate.value =
                          DateFormat("yyyy/MM/dd").format(date);
                    },
                  ),
                );
              },
              prefixText: '',
            ),
          ),
        ],
      ),
    );
  }
}
