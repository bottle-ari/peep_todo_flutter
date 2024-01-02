import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/views/routine/widget/peep_repeat_condition_item.dart';
import 'package:peep_todo_flutter/app/views/routine/widget/peep_repeat_condition_picker.dart';

import '../../../../utils/routine_util.dart';
import '../../../common/peep_date_picker.dart';

class PeepYearlyCondition extends StatelessWidget {
  final PeepRepeatConditionPickerController controller;
  final Color color;

  const PeepYearlyCondition({
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
              boldText: controller.yearlyDetailRepeatValue.value.toString(),
              postfixText: "에",
              color: color,
              isChecked: controller.yearlyDetailRepeatIsChecked.value,
              onCheckButtonTap: () {
                // controller.yearlyDetailRepeatIsChecked.value =
                //     !controller.yearlyDetailRepeatIsChecked.value;
              },
              onBoldTextTap: () {
                // Todo : 월, 일 picker 띄우기
              },
              prefixText: '매 년',
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
