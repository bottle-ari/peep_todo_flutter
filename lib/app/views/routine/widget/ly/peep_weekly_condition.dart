import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/views/routine/widget/peep_repeat_condition_item.dart';
import 'package:peep_todo_flutter/app/views/routine/widget/peep_repeat_condition_picker.dart';
import 'package:peep_todo_flutter/app/views/routine/widget/peep_repeat_condition_week_item.dart';

import '../../../../utils/routine_util.dart';
import '../../../common/peep_date_picker.dart';
import '../../page/modal/routine_interval_picker_modal.dart';

class PeepWeeklyCondition extends StatelessWidget {
  final PeepRepeatConditionPickerController controller;
  final Color color;

  const PeepWeeklyCondition({
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
              isChecked: controller.weeklyDayRepeatIsChecked.value,
              onCheckButtonTap: () {
                // 요일로 반복하기 끄지 못하도록 (항상 켜져있어야함)
                // controller.weeklyDayRepeatIsChecked.value =
                //     !controller.weeklyDayRepeatIsChecked.value;
              },
              dayPicked: controller.weeklyDayRepeatValue,
              boldText: '',
              onBoldTextTap: () {},
              isMonthly: false,
              controller: controller,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: AppValues.innerMargin),
            child: PeepRepeatConditionItem(
              descriptionText: "상세히 반복하기",
              boldText: controller.weeklyDetailRepeatValue.value.toString(),
              postfixText: "주 간격으로",
              color: color,
              isChecked: controller.weeklyDetailRepeatIsChecked.value,
              onCheckButtonTap: () {
                controller.weeklyDetailRepeatIsChecked.value =
                    !controller.weeklyDetailRepeatIsChecked.value;

                if (controller.weeklyDetailRepeatIsChecked.value == false) {
                  controller.weeklyDetailRepeatValue.value = 1;
                }
              },
              onBoldTextTap: () {
                Get.bottomSheet(
                  RoutineIntervalPickerModal(
                    color: color,
                    initValue: controller.weeklyDetailRepeatValue.value,
                    onConfirm: (int selectedValue) {
                      controller.weeklyDetailRepeatValue.value = selectedValue;
                    },
                    postfixText: '주 간격으로',
                  ),
                );
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
