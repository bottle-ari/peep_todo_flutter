import 'package:flutter/painting.dart';

class Palette {
  static const Color peepYellow400 = Color(0xFFFFB800);
  static const Color peepYellow300 = Color(0xFFFFCE50);
  static const Color peepYellow200 = Color(0xFFFFDD6F);
  static const Color peepYellow100 = Color(0xFFFEEC90);
  static const Color peepYellow50 = Color(0xFFFFFBD2);

  static const Color peepGray500 = Color(0xFF575757);
  static const Color peepGray400 = Color(0xFF989898);
  static const Color peepGray300 = Color(0xFFC9C9C9);
  static const Color peepGray200 = Color(0xFFE2E2E2);
  static const Color peepGray100 = Color(0xFFF2F2F2);
  static const Color peepGray50 = Color(0xFFF9F9F9);

  static const Color peepButton300 = Color(0xFFEFECE5);
  static const Color peepButton200 = Color(0xFFFFFAEE);

  static const Color peepWhite = Color(0xFFFFFFFF);
  static const Color peepBlack = Color(0xFF1d1d1d);
  static const Color peepRed = Color(0xFFFF5151);
  static const Color peepGreen = Color(0xFF51CF6C);
  static const Color peepBlue = Color(0xFF4685FF);
  static const Color peepPurple = Color(0xFFBD00FF);

  static const Color peepBackground = peepWhite;
}

Color getTextColor(Color color) {
  double luminance = color.computeLuminance();

  if (luminance > 0.5) {
    return Palette.peepBlack;
  } else {
    return Palette.peepWhite;
  }
}