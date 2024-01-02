import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:peep_todo_flutter/app/controllers/data/category_controller.dart';
import 'package:peep_todo_flutter/app/controllers/data/todo_controller.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../utils/peep_calendar_util.dart';

class PeepMiniCalendarController extends GetxController {
  // Controllers
  final TodoController _todoController = Get.find();
  final CategoryController _categoryController = Get.find();

  // Variables
  final RxMap<String, Map<String, double>> calendarItemCounts =
      <String, Map<String, double>>{}.obs;

  final Rx<CalendarFormat> calendarFormat = CalendarFormat.week.obs;

  @override
  void onInit() {
    super.onInit();

    // 투두 데이터 변경 감지
    ever(_todoController.todoMap, (callback) {
      updateCalendarItemCounts();
    });

    // 선택된 날짜 변경 감지
    ever(
        _todoController.selectedDate, (callback) => updateCalendarItemCounts());

    // 카테고리 데이터 변경 감지
    ever(_categoryController.categoryList,
        (callback) => updateCalendarItemCounts());
  }

  /*
    Calendar Functions
   */
  bool isToday() {
    return isSameDay(_todoController.selectedDate.value, DateTime.now());
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_todoController.selectedDate.value, selectedDay)) {
      _todoController.selectedDate.value = selectedDay;
      _todoController.focusedDate.value = focusedDay;
    }

    print("------------------ routineMatchTest start ------------------");
    var routineList = _routineController.routineList;
    for(int i=0;i<routineList.length;i++){
      print("index : $i");
      print("name : ${routineList[i].name}");
      print("repeatCondition : ${routineList[i].repeatCondition}");
      // Todo : active 상태도 확인해야
      bool matched = isMatchToRepeatCondition(selectedDay, routineList[i].repeatCondition);
      print("matched : $matched");
    }
    print("------------------ routineMatchTest end ------------------");
  }

  void onMoveToday() {
    DateTime today = DateTime.now();

    // 오늘 선택 예외 처리
    if (_todoController.focusedDate.value == today &&
        _todoController.selectedDate.value == today) {
      _todoController.focusedDate.update((val) {
        val = null;
      });
    }
    _todoController.focusedDate.value = today;
    _todoController.selectedDate.value = today;
  }

  void onPageChanged(DateTime newFocusedDay) {
    _todoController.focusedDate.value = newFocusedDay;
    _todoController.selectedDate.value = newFocusedDay;

    update();
  }

  // 캘린더 링 그래프 계산 함수 (선택된 달 기준)
  void updateCalendarItemCounts() {
    final DateTime startDate =
        getPreviousMonthEnd(_todoController.selectedDate.value)
            .subtract(const Duration(days: 7));
    final DateTime endDate =
        getNextMonthStart(_todoController.selectedDate.value)
            .add(const Duration(days: 7));

    Map<String, Map<String, double>> newCalendarItemCounts =
        Map.from(calendarItemCounts);

    // StartDate ~ EndDate 까지 반복
    for (DateTime date = startDate;
        date.isBefore(endDate.add(const Duration(days: 1)));
        date = date.add(const Duration(days: 1))) {
      var key = DateFormat('yyyyMMdd').format(date);

      newCalendarItemCounts[key] = {};

      if (_todoController.todoMap[key] == null) continue;

      int sum = 0;
      for (int i = 0; i < _todoController.todoMap[key]!.length; i++) {
        var categoryId = _todoController.todoMap[key]![i].categoryId;

        if (newCalendarItemCounts[key]![categoryId] == null) {
          newCalendarItemCounts[key]![categoryId] = 0;
        }

        if (_todoController.todoMap[key]![i].isChecked) {
          newCalendarItemCounts[key]![categoryId] =
              newCalendarItemCounts[key]![categoryId]! + 1;
        }
        sum++;
      }

      if (sum != 0) {
        for (var categoryId in newCalendarItemCounts[key]!.keys) {
          if (newCalendarItemCounts[key]![categoryId] == null) continue;

          newCalendarItemCounts[key]![categoryId] =
              newCalendarItemCounts[key]![categoryId]! / sum;
        }
      }
    }

    // 데이터 저장 및 변경
    calendarItemCounts.value = newCalendarItemCounts;
  }
}
