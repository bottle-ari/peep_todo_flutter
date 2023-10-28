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
  static const todo = 'image/icon/todo.svg';
  static const calendar = 'image/icon/calendar.svg';
  static const routine = 'image/icon/routine.svg';
  static const profile = 'image/icon/profile.svg';
  static const priority = 'image/icon/priority.svg';
  static const arrowCircleUp = 'image/icon/arrow_circle_up.svg';
  static const arrowCircleDown = 'image/icon/arrow_circle_down.svg';
  static const checkFalse = 'image/icon/check_false.svg';
  static const checkTrue = 'image/icon/check_true.svg';
}
