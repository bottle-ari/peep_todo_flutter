// 앱 내 테마 정의하는 공간. 색/폰트/텍스트 스타일은 여기 정의해주세요
import 'package:flutter/material.dart';
import 'package:peep_todo_flutter/app/data/model/palette/palette_model.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/views/user/page/font_setting.dart';

final ThemeData appThemeData = ThemeData(
  colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: defaultPalette.primaryColor.color,
      onPrimary: Palette.peepWhite,
      secondary: defaultPalette.primaryColor.color,
      onSecondary: Palette.peepWhite,
      error: Palette.peepRed,
      onError: Palette.peepRed,
      background: Palette.peepWhite,
      onBackground: Palette.peepGray500,
      surface: Palette.peepGray100,
      onSurface: Palette.peepBlack,),
  highlightColor: Colors.transparent,
  fontFamily: "KoPub",
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

class Themes {
  final ThemeData defaultTheme = ThemeData(
    primaryColor: Palette.peepYellow300,
    highlightColor: Colors.transparent,
    fontFamily: "pretender",
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

  final ThemeData KoPubTheme = ThemeData(
    primaryColor: Palette.peepYellow300,
    highlightColor: Colors.transparent,
    fontFamily: "KoPub",
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

  final ThemeData LeeSeoyunTheme = ThemeData(
    primaryColor: Palette.peepYellow300,
    highlightColor: Colors.transparent,
    fontFamily: "LeeSeoyun",
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

  final ThemeData NanumTheme = ThemeData(
    primaryColor: Palette.peepYellow300,
    highlightColor: Colors.transparent,
    fontFamily: "Nanum,",
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

  ThemeData getThemeByFont(String font) {
    switch (font) {
      case 'KoPub':
        return KoPubTheme;
      case 'Nanum':
        return NanumTheme;
      case 'LeeSeoyun':
        return LeeSeoyunTheme;
      default:
        return defaultTheme;
    }
  }
}

class PeepScrollBehavior extends MaterialScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    // 여기서는 오버스크롤 인디케이터를 아예 빌드하지 않도록 하여 제거합니다.
    return StretchingOverscrollIndicator(
      axisDirection: details.direction,
      child: child,
    );
  }
}

class ColorService {
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}
