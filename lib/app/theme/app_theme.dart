// 앱 내 테마 정의하는 공간. 색/폰트/텍스트 스타일은 여기 정의해주세요
import 'package:flutter/material.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';

final ThemeData appThemeData = ThemeData(
  primaryColor: Palette.peepYellow300,
  highlightColor: Colors.transparent,
  fontFamily: 'Pretendard',
  splashColor: Colors.transparent,
  hoverColor: Colors.transparent,
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Palette.peepBlack,
    ),
  ),
);