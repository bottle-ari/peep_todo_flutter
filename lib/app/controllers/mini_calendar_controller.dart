import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/core/base/base_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class MiniCalendarController extends BaseController {
  DateTime today = DateTime.now();
  Rx<DateTime> focusedDay = DateTime.now().obs;
  Rx<DateTime> selectedDay = DateTime.now().obs;

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(this.selectedDay.value, selectedDay)) {
      this.selectedDay.value = selectedDay;
      this.focusedDay.value = focusedDay;
    }
  }



  void onMoveToday() {
    // 오늘 선택 예외 처리
    if(focusedDay.value == today && selectedDay.value == today){
      focusedDay.update((val) { val = null; });
    }
    focusedDay.value = today;
    selectedDay.value = today;
  }

}
