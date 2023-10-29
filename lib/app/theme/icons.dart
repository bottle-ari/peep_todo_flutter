import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';

class PeepIcon extends StatelessWidget {
  final String assetName;
  final double size;
  final Color? color;

  const PeepIcon(
    this.assetName, {
    required this.size,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      width: size,
      height: size,
      colorFilter:
          ColorFilter.mode(color ?? Palette.peepGray300, BlendMode.srcIn),
    );
  }
}

class Iconsax {
  static const todo = 'assets/image/icon/todo.svg';
  static const calendar = 'assets/image/icon/calendar.svg';
  static const routine = 'assets/image/icon/routine.svg';
  static const profile = 'assets/image/icon/profile.svg';
  static const priority = 'assets/image/icon/priority.svg';
  static const arrowCircleUp = 'assets/image/icon/arrow_circle_up.svg';
  static const arrowCircleDown = 'assets/image/icon/arrow_circle_down.svg';
  static const checkFalse = 'assets/image/icon/check_false.svg';
  static const checkTrue = 'assets/image/icon/check_true.svg';
  static const emoji = 'assets/image/icon/emoji.svg';
  static const clock = 'assets/image/icon/clock.svg';
}