//앱 내 사용할 값들을 저장하는 공간
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppValues {
  static double screenWidth = 393.w;
  static double screenHeight = 852.h;
  static double screenPadding = 20.w;

  static double innerMargin = 5.w;
  static double verticalMargin = 10.h;
  static double horizontalMargin = 10.w;

  static double baseRadius = 20.r;
  static double smallRadius = 10.r;
  static double tinyRadius = 5.r;

  static double baseOpacity = 0.7;
  static double halfOpacity = 0.5;
  static double shadowOpacity = 0.1;

  static double smallIconSize = 20.w;
  static double baseIconSize = 24.w;
  static double navigationIconSize = 28.w;
  static double largeIconSize = 32.w;
  static double xlargeIconSize = 48.w;

  static double listBottomEmptySpace = 200.h;
}