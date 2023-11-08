import 'dart:ffi';

import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class WeekCalendarController extends GetxController {
  Rx<DateTime> focusedDay = DateTime.now().obs;
  Rx<DateTime> selectedDay = DateTime.now().obs;
  Rx<DateTime> toDay = DateTime.now().obs;

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(this.selectedDay.value, selectedDay)) {
      this.selectedDay.value = selectedDay;
      this.focusedDay.value = focusedDay;
    }
  }



  void onMoveToday() {
    // 오늘 선택 예외 처리
    if(focusedDay.value == toDay.value && selectedDay.value == toDay.value){
      focusedDay.update((val) { val = null; });
    }
    focusedDay.value = toDay.value;
    selectedDay.value = toDay.value;
  }

}
