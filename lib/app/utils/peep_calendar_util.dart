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