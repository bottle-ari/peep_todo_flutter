import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class PeepDatePickerController extends GetxController {
  final DateTime date;
  final RxBool isCalendar = true.obs;
  late final Rx<DateTime> focusedDate;
  late final Rx<DateTime> selectedDate;

  PeepDatePickerController({required this.date}) {
    focusedDate = date.obs;
    selectedDate = date.obs;
  }

  void toggleIsCalendar() {
    isCalendar.value = !isCalendar.value;
  }

  bool isToday() {
    return isSameDay(selectedDate.value, DateTime.now());
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(selectedDate.value, selectedDay)) {
      selectedDate.value = selectedDay;
      focusedDate.value = focusedDay;
    }
  }

  void onMoveToday() {
    DateTime today = DateTime.now();

    // 오늘 선택 예외 처리
    if (focusedDate.value == today && selectedDate.value == today) {
      focusedDate.update((val) {
        val = null;
      });
    }
    focusedDate.value = today;
    selectedDate.value = today;
  }

  void onPageChanged(DateTime newFocusedDay) {
    focusedDate.value = newFocusedDay;
    selectedDate.value = newFocusedDay;
  }
}