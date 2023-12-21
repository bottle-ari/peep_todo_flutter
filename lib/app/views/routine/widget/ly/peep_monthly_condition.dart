import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/views/routine/widget/peep_repeat_condition_item.dart';
import 'package:peep_todo_flutter/app/views/routine/widget/peep_repeat_condition_picker.dart';
import 'package:peep_todo_flutter/app/views/routine/widget/peep_repeat_condition_week_item.dart';

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
              boldText: controller.monthlyDayRepeatOrdinalValue.toString(),
              onBoldTextTap: () {},
              isMonthly: true,
              controller: controller,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: AppValues.innerMargin),
            child: PeepRepeatConditionItem(
              descriptionText: "상세히 반복하기",
              boldText: controller.monthlyDetailRepeatValue.value.toString(),
              postfixText: "일에",
              color: color,
              isChecked: !controller.monthlyDayRepeatIsChecked.value,
              onCheckButtonTap: () {
                // 요일로 반복하기 혹은, 상세히 반복하기 둘중 하나만 켜지도록
                controller.monthlyDayRepeatIsChecked.value =
                    !controller.monthlyDayRepeatIsChecked.value;
              },
              onBoldTextTap: () {
                // Todo : number picker 띄우기
                controller.monthlyDetailRepeatValue.value++;
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
                controller.endIsChecked.value =
                    !controller.endIsChecked.value;
              },
              onBoldTextTap: () {
                // Todo : date picker 띄우기
              },
              prefixText: '',
            ),
          ),
        ],
      ),
    );
  }
}
