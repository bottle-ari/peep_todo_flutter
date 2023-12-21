import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/views/routine/widget/peep_repeat_condition_item.dart';
import 'package:peep_todo_flutter/app/views/routine/widget/peep_repeat_condition_picker.dart';

class PeepDailyCondition extends StatelessWidget {
  final PeepRepeatConditionPickerController controller;
  final Color color;

  const PeepDailyCondition({
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
            child: PeepRepeatConditionItem(
              descriptionText: "상세히 반복하기",
              boldText: controller.dailyDetailRepeatValue.value.toString(),
              postfixText: "일 간격으로",
              color: color,
              isChecked: controller.dailyDetailRepeatIsChecked.value,
              onCheckButtonTap: () {
                controller.dailyDetailRepeatIsChecked.value =
                    !controller.dailyDetailRepeatIsChecked.value;

                if (controller.dailyDetailRepeatIsChecked.value == false) {
                  controller.dailyDetailRepeatValue.value = 1;
                }
              },
              onBoldTextTap: () {
                // Todo : number picker 띄우기
                controller.dailyDetailRepeatValue.value++;
              },
              prefixText: '',
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
