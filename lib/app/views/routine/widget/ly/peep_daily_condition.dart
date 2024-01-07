import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/utils/routine_util.dart';
import 'package:peep_todo_flutter/app/views/routine/page/modal/routine_interval_picker_modal.dart';
import 'package:peep_todo_flutter/app/views/routine/widget/peep_repeat_condition_item.dart';
import 'package:peep_todo_flutter/app/views/routine/widget/peep_repeat_condition_picker.dart';

import '../../../common/peep_date_picker.dart';

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
                Get.bottomSheet(
                  RoutineIntervalPickerModal(
                    color: color,
                    initValue: controller.dailyDetailRepeatValue.value,
                    onConfirm: (int selectedValue) {
                      controller.dailyDetailRepeatValue.value = selectedValue;
                    },
                    postfixText: '일 간격으로',
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
