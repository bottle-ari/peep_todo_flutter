import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';

class PeepButton extends StatelessWidget {
  final Color color;
  final String text;
  final Function func;
  final bool isActive;

  const PeepButton(
      {super.key,
      required this.color,
      required this.text,
      required this.func,
      required this.isActive});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(isActive) {
          func();
        }
      },
      child: Container(
        width: 313.w,
        height: 64.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.r),
          color: isActive ? color : Palette.peepGray200,
        ),
        child: Center(
            child: Text(
          text,
          style: PeepTextStyle.boldM(
              color: isActive ? getTextColor(color) : Palette.peepGray400),
        )),
      ),
    );
  }
}
