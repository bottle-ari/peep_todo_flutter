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
  static const constantTodo = 'assets/image/icon/constant_todo.svg';
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
  static const more = 'assets/image/icon/more.svg';
  static const eggTop = 'assets/image/icon/egg_top.svg';
  static const eggBottom = 'assets/image/icon/egg_bottom.svg';
  static const egg = 'assets/image/icon/egg.svg';
  static const trash = 'assets/image/icon/trash.svg';
  static const rollback = 'assets/image/icon/rollback.svg';
  static const addSquare = 'assets/image/icon/add_square.svg';
  static const arrowDown = 'assets/image/icon/arrow_down.svg';
  static const reminder = 'assets/image/icon/reminder.svg';
  static const addcircle = 'assets/image/icon/addcircle.svg';
  static const categorybox = 'assets/image/icon/categorybox.svg';
  static const clipboardCheck = 'assets/image/icon/clipboard_check.svg';
  static const clipboardCheckBold = 'assets/image/icon/clipboard_check_bold.svg';
  static const clipboardDelete = 'assets/image/icon/clipboard_delete.svg';
  static const clockBold = 'assets/image/icon/clock_bold.svg';
  static const arrowLeft = 'assets/image/icon/arrow_left.svg';
  static const check = 'assets/image/icon/check.svg';
  static const eggBroken = 'assets/image/icon/egg_broken';
  static const cancel = 'assets/image/icon/cancel.svg';
  static const calendarSearch = 'assets/image/icon/calendar_search.svg';
  static const notification = 'assets/image/icon/notification.svg';
  static const memo = 'assets/image/icon/memo.svg';
  static const eggCracked = 'assets/image/icon/egg_cracked.svg';
  static const addSquareOutline = 'assets/image/icon/add_square_outline.svg';
  static const categoryboxAdd = 'assets/image/icon/categorybox_add.svg';
  static const routineOutline = 'assets/image/icon/routine_outline.svg';
  static const checkBold = 'assets/image/icon/check_bold.svg';
  static const diary = 'assets/image/icon/diary.svg';
  static const edit = 'assets/image/icon/edit.svg';
  static const trashBold = 'assets/image/icon/trash_bold.svg';
  static const image = 'assets/image/icon/image.svg';
  static const emptyBox = 'assets/image/icon/empty_box.svg';
  static const export = 'assets/image/icon/export.svg';
}
