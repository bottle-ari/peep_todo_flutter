import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/utils/routine_util.dart';
import 'package:peep_todo_flutter/app/views/routine/widget/ly/peep_daily_condition.dart';
import 'package:peep_todo_flutter/app/views/routine/widget/ly/peep_monthly_condition.dart';
import 'package:peep_todo_flutter/app/views/routine/widget/ly/peep_weekly_condition.dart';
import 'package:peep_todo_flutter/app/views/routine/widget/ly/peep_yearly_condition.dart';
import 'package:peep_todo_flutter/app/views/routine/widget/peep_ly_select_button.dart';

class PeepRepeatConditionPicker extends StatelessWidget {
  final Color color;
  final PeepRepeatConditionPickerController controller;

  const PeepRepeatConditionPicker({
    super.key,
    required this.color,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: AppValues.horizontalMargin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    PeepIcon(
                      Iconsax.routineOutline,
                      color: Palette.peepGray500,
                      size: AppValues.baseIconSize,
                    ),
                    SizedBox(width: AppValues.horizontalMargin),
                    Text(
                      '반복 조건',
                      style: PeepTextStyle.regularM(color: Palette.peepGray500),
                    ),
                  ],
                ),
                Text(
                  controller.repeatConditionDescription.value,
                  style: PeepTextStyle.boldM(color: Palette.peepGray500),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: AppValues.horizontalMargin),
            child: PeepLySelectButton(
              initLyValue: controller.ly.value,
              onLySelected: (lyValue) {
                controller.ly.value = lyValue;
              },
            ),
          ),
          if (controller.ly.value == 0)
            PeepDailyCondition(
              controller: controller,
              color: color,
            ),
          if (controller.ly.value == 1)
            PeepWeeklyCondition(
              controller: controller,
              color: color,
            ),
          if (controller.ly.value == 2)
            PeepMonthlyCondition(
              controller: controller,
              color: color,
            ),
          if (controller.ly.value == 3)
            PeepYearlyCondition(
              controller: controller,
              color: color,
            ),
        ],
      ),
    );
  }
}

class PeepRepeatConditionPickerController extends GetxController {
  // ly, 0 : daily, 1 : weekly, 2 : monthly, 3 : yearly
  final RxInt ly = 0.obs;
  final RxString endDate = DateFormat("yyyy/MM/dd").format(DateTime.now()).obs;
  final RxBool endIsChecked = false.obs;
  final RxString subRepeatCondition = "".obs;
  final RxString repeatConditionDescription = "".obs;

  /*
    daily
   */
  final RxBool dailyDetailRepeatIsChecked = true.obs;
  final RxInt dailyDetailRepeatValue = 1.obs;

  /*
    weekly
   */
  final RxBool weeklyDayRepeatIsChecked = true.obs;
  // [월, 화, 수, 목, 금 ,토, 일] 선택되었는지 유무
  final RxList<bool> weeklyDayRepeatValue =
      [false, false, true, false, false, false, false].obs;
  final RxBool weeklyDetailRepeatIsChecked = true.obs;
  final RxInt weeklyDetailRepeatValue = 1.obs;

  /*
    monthly
   */
  final RxBool monthlyDayRepeatIsChecked = true.obs;

  // [월, 화, 수, 목, 금 ,토, 일] 선택되었는지 유무
  final RxList<bool> monthlyDayRepeatValue =
      [false, false, true, false, false, false, false].obs;

  // 몇 째주
  final RxInt monthlyDayRepeatOrdinalValue = 1.obs;
  final RxInt monthlyDetailRepeatValue = 1.obs;

  /*
    yearly
   */
  final RxBool yearlyDetailRepeatIsChecked = true.obs;
  final RxString yearlyDetailRepeatValue =
      "${DateTime.now().month.toString().padLeft(2, '0')}/${DateTime.now().day.toString().padLeft(2, '0')}"
          .obs;

  /*
    function
   */
  @override
  void onInit() {
    super.onInit();

    everAll([
      ly,
      dailyDetailRepeatIsChecked,
      dailyDetailRepeatValue,
      weeklyDayRepeatIsChecked,
      weeklyDayRepeatValue,
      weeklyDetailRepeatIsChecked,
      weeklyDetailRepeatValue,
      monthlyDayRepeatIsChecked,
      monthlyDayRepeatValue,
      monthlyDayRepeatOrdinalValue,
      monthlyDetailRepeatValue,
      yearlyDetailRepeatValue,
    ], (callback) {
      updateSubRepeatCondition();
      updateRepeatConditionDescription();
    });

    updateSubRepeatCondition();
    updateRepeatConditionDescription();
  }

  updateRepeatConditionDescription() {
    repeatConditionDescription.value =
        subRepeatConditionToDescription(subRepeatCondition.value);
  }

  updateSubRepeatCondition() {
    subRepeatCondition.value = makeSubRepeatCondition();
  }

  String makeSubRepeatCondition() {
    String repeatCondition = "";

    switch (ly.value) {
      case 0:
        // daily : "0(daily)-1(일 간격)"
        repeatCondition = "0";

        // 상세히 반복하기
        if (dailyDetailRepeatIsChecked.value) {
          repeatCondition = "$repeatCondition-${dailyDetailRepeatValue.value}";
        } else {
          repeatCondition = "$repeatCondition-1";
        }
        break;

      case 1:
        // weekly : "1(매주)-,02(일,화)-1(주 간격)"
        repeatCondition = "1";

        // 요일로 반복하기
        String weekDays = "";
        for (int i = 0; i < 7; i++) {
          if (weeklyDayRepeatValue[i]) {
            weekDays = "$weekDays$i";
          }
        }
        repeatCondition = "$repeatCondition-$weekDays";

        // 상세히 반복하기
        if (weeklyDetailRepeatIsChecked.value) {
          repeatCondition = "$repeatCondition-${weeklyDetailRepeatValue.value}";
        } else {
          repeatCondition = "$repeatCondition-1";
        }
        break;

      case 2:
        // monthly : "2(매월)-0(요일로 반복)-1(번째주)-02(일,화)" || "2(매월)-1(상세히 반복)-10(일에)"
        repeatCondition = "2";

        // 요일로 반복하기
        if (monthlyDayRepeatIsChecked.value) {
          repeatCondition = "$repeatCondition-0";
          repeatCondition =
              "$repeatCondition-${monthlyDayRepeatOrdinalValue.value}";
          String weekDays = "";
          for (int i = 0; i < 7; i++) {
            if (monthlyDayRepeatValue[i]) {
              weekDays = "$weekDays$i";
            }
          }
          repeatCondition = "$repeatCondition-$weekDays";
        }
        // 상세히 반복하기
        else {
          repeatCondition = "$repeatCondition-1";
          repeatCondition =
              "$repeatCondition-${monthlyDetailRepeatValue.value}";
        }
        break;

      case 3:
        // yearly : "3(매년)-12/21(에)"
        repeatCondition = "3";
        repeatCondition = "$repeatCondition-${yearlyDetailRepeatValue.value}";
        break;

      default:
        break;
    }

    return repeatCondition;
  }

  // repeatCondition 을 받아서, controller의 Rx 변수의 값들 초기화하는 함수
  void initValuesFromSubRepeatCondition(String initRepeatCondition) {
    // end date 초기화
    String initEndDate = initRepeatCondition.split(' ')[2];
    if (initEndDate.isEmpty) {
      endIsChecked.value = false;
    } else {
      endIsChecked.value = true;
      endDate.value = initEndDate;
    }

    // sub repeat condition 초기화
    String initSubRepeatCondition = initRepeatCondition.split(' ')[0];
    List<String> splitSubConditions = initSubRepeatCondition.split('-');

    switch (splitSubConditions[0]) {
      case '0':
        // daily : "0(daily)-1(일 간격)"
        ly.value = 0;
        dailyDetailRepeatIsChecked.value = true;
        dailyDetailRepeatValue.value = int.parse(splitSubConditions[1]);
        break;

      case '1':
        // weekly : "1(매주)-02(일,화)-1(주 간격)"
        ly.value = 1;
        weeklyDetailRepeatIsChecked.value = true;
        weeklyDetailRepeatValue.value = int.parse(splitSubConditions[2]);

        weeklyDayRepeatIsChecked.value = true;
        bool isWed = false;
        for (int i = 0; i < splitSubConditions[1].length; i++) {
          int dayIndex = int.parse(splitSubConditions[1][i]);
          weeklyDayRepeatValue[dayIndex] = true;

          if (dayIndex == 2) isWed = true;
        }
        if (!isWed) weeklyDayRepeatValue[2] = false;
        break;

      case '2':
        // monthly : "2(매월)-0(요일로 반복)-1(번째주)-02(일,화)" || "2(매월)-1(상세히 반복)-10(일에)"
        ly.value = 2;
        // 요일로 반복
        if (splitSubConditions[1] == '0') {
          monthlyDayRepeatIsChecked.value = true;
          monthlyDayRepeatOrdinalValue.value = int.parse(splitSubConditions[2]);

          bool isWed = false;
          for (int i = 0; i < splitSubConditions[3].length; i++) {
            int dayIndex = int.parse(splitSubConditions[3][i]);
            monthlyDayRepeatValue[dayIndex] = true;

            if (dayIndex == 2) isWed = true;
          }
          if (!isWed) monthlyDayRepeatValue[2] = false;
        }
        // 상세히 반복
        else {
          monthlyDayRepeatIsChecked.value = false;
          monthlyDetailRepeatValue.value = int.parse(splitSubConditions[2]);
        }
        break;

      case '3':
        // yearly : "3(매년)-12/21(에)"
        ly.value = 3;
        yearlyDetailRepeatValue.value = splitSubConditions[1];
        break;

      default:
        break;
    }
  }
}
