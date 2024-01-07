import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';

/*
  date가 오늘 인지 return 하는 함수
 */
bool isToday(DateTime date) {
  final now = DateTime.now();
  return date.year == now.year && date.month == now.month && date.day == now.day;
}

DateTime? parseDate(String date) {
  if (date == 'constant') {
    return null;
  } else {
    try {
      if (date.length != 8) {
        return null; // 문자열 길이가 8이 아니면 null 반환
      }

      int year = int.tryParse(date.substring(0, 4)) ?? 0;
      int month = int.tryParse(date.substring(4, 6)) ?? 0;
      int day = int.tryParse(date.substring(6, 8)) ?? 0;

      if (year == 0 || month == 0 || day == 0) {
        return null; // 유효하지 않은 날짜일 경우 null 반환
      }

      return DateTime(year, month, day);
    } catch (e) {
      log('날짜 파싱 중 에러 발생: $e');
      return null; // 형식이 잘못되었거나 날짜가 유효하지 않을 때 null 반환
    }
  }
}

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

/*
  선택된 날의 페이지 인덱스 구하기
 */

// 날짜 계산을 위한 시작과 끝 날짜 설정
final DateTime calendarStartDate = DateTime(1923, 1, 1);
final DateTime calendarEndDate = DateTime(2123, 12, 31);

// 인덱스에 해당하는 날짜를 계산하는 함수
DateTime getDateFromPageIndex(int index) {
  return calendarStartDate.add(Duration(days: index));
}

// 선택된 날짜에 대한 페이지 인덱스를 계산하는 함수
int calculatePageIndex(DateTime date) {
  log(date.difference(calendarStartDate).inDays.toString());
  return date.difference(calendarStartDate).inDays
  ;
}

