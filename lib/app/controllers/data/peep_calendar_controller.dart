import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:peep_todo_flutter/app/core/base/base_controller.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../utils/peep_calendar_util.dart';

class PeepCalendarController extends BaseController {
  DateTime today = DateTime.now();
  Rx<DateTime> focusedDay = DateTime.now().obs;
  Rx<DateTime> selectedDay = DateTime.now().obs;
  RxDouble rowHeight = (630.h /
          calculateWeeksInMonth(
              year: int.parse(DateFormat('yyyy').format(DateTime.now())),
              month: int.parse(DateFormat('MM').format(DateTime.now())),
              startSunday: true))
      .obs;

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(this.selectedDay.value, selectedDay)) {
      this.selectedDay.value = selectedDay;
      this.focusedDay.value = selectedDay;
    }
  }

  void onMoveToday() {
    // 오늘 선택 예외 처리
    if (focusedDay.value == today && selectedDay.value == today) {
      focusedDay.update((val) {
        val = null;
      });
    }
    focusedDay.value = today;
    selectedDay.value = today;
  }

  void onPageChanged(DateTime newFocusedDay) {
    focusedDay.value = newFocusedDay;
    selectedDay.value = newFocusedDay;

    updateRowHeight();
  }

  void updateRowHeight() {
    rowHeight.value = 646.h /
        calculateWeeksInMonth(
            year: int.parse(DateFormat('yyyy').format(selectedDay.value)),
            month: int.parse(DateFormat('MM').format(selectedDay.value)),
            startSunday: true);
  }
}
