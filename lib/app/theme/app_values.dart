//앱 내 사용할 값들을 저장하는 공간
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppValues {
  static double screenWidth = 393.w;
  static double screenHeight = 852.h;

  static double screenPadding = 20.w;
  static double margin = 16.w;

  static double buttonRadius = 8.r;
  static double buttonHeight = 50.h;

  static double iconDefaultSize = 24.w;
  static double floatButtonSize = 72.w;
  static double listBottomEmptySpace = 200.h;

  static const int defaultPageSize = 10;
  static const int defaultPageNumber = 1;
  static const int defaultDebounceTimeInMilliSeconds = 1000;
  static const int defaultThrottleTimeInMilliSeconds = 500;
}