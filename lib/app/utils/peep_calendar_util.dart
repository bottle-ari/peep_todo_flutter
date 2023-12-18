import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';

/*
    해당 day 의 요일을 바탕으로 색을 return 하는 함수
  */
Color getDayColor(DateTime day) {
  Color dayColor = Palette.peepBlack;
  if (day.weekday == DateTime.saturday) {
    dayColor = Palette.peepBlue;
  } else if (day.weekday == DateTime.sunday) {
    dayColor = Palette.peepRed;
  }

  return dayColor;
}

/*
  특정 Month의 row 수를 리턴하는 함수
 */
int calculateWeeksInMonth(
    {required int year, required int month, required bool startSunday}) {
  DateTime firstDayOfMonth = DateTime(year, month, 1);
  int firstDayWeekday = firstDayOfMonth.weekday;

  if (startSunday) {
    firstDayWeekday = firstDayWeekday % 7;
  }

  int daysInMonth = DateUtils.getDaysInMonth(year, month);

  int weeks = (firstDayWeekday + daysInMonth + 6) ~/ 7;

  log('$weeks');
  return weeks;
}

class DateUtils {
  static int getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }
}

/*
  선택된 날의 이전 달 마지막 날 구하기
 */
DateTime getPreviousMonthEnd(DateTime selectedDate) {
  int year = selectedDate.month == 1 ? selectedDate.year - 1 : selectedDate.year;
  int month = selectedDate.month == 1 ? 12 : selectedDate.month - 1;

  return DateTime(year, month + 1, 0);
}

/*
  선택된 날의 다음 달 첫째 날 구하기
 */
DateTime getNextMonthStart(DateTime selectedDate) {
  int year = selectedDate.month == 12 ? selectedDate.year + 1 : selectedDate.year;
  int month = selectedDate.month == 12 ? 1 : selectedDate.month + 1;

  return DateTime(year, month, 1);
}
