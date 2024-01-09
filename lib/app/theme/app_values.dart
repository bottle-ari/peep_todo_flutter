//앱 내 사용할 값들을 저장하는 공간
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppValues {
  static double appbarHeight = 70.h;

  static double screenWidth = 393.w;
  static double screenHeight = 852.h;
  static double screenPadding = 20.w;

  static double innerMargin = 5.w;
  static double verticalMargin = 10.h;
  static double horizontalMargin = 10.w;
  static double textMargin = 15.w;

  static double baseItemHeight = 48.h;
  static double largeItemHeight = 52.h;

  static double baseRadius = 20.r;
  static double calendarItemRadius = 15.5.r;
  static double smallRadius = 10.r;
  static double tinyRadius = 5.r;

  static double highOpacity = 0.85;
  static double baseOpacity = 0.7;
  static double halfOpacity = 0.5;
  static double quarterOpacity = 0.25;
  static double shadowOpacity = 0.1;

  static double tinyIconSize = 12.w;
  static double miniIconSize = 16.w;
  static double smallIconSize = 20.w;
  static double diaryIconSize = 21.w;
  static double baseIconSize = 24.w;
  static double mediumIconSize = 28.w;
  static double largeIconSize = 32.w;
  static double xlargeIconSize = 48.w;

  static double imagePreviewSize = 60.h;

  static double listBottomEmptySpace = 200.h;
}