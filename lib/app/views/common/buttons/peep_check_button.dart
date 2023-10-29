import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';

import '../../../theme/icons.dart';

class PeepCheckButton extends StatelessWidget {
  final Color color;
  final int index;
  final Function(int) isToggled;
  final bool isChecked;

  const PeepCheckButton({
    Key? key,
    required this.color,
    required this.isToggled,
    required this.isChecked,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            isToggled(index);
          },
          child: isChecked
              ? PeepIcon(Iconsax.checkTrue, color: color, size: 28.w)
              : PeepIcon(Iconsax.checkFalse, color: color, size: 28.w),
        ));
  }
}

class PeepCheckSubButton extends StatelessWidget {
  final Color color;
  final int mainIndex;
  final int index;
  final Function(int, int) isToggled;
  final bool isChecked;

  const PeepCheckSubButton({
    Key? key,
    required this.color,
    required this.isToggled,
    required this.isChecked,
    required this.index,
    required this.mainIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            isToggled(mainIndex, index);
          },
          child: Padding(
              padding: EdgeInsets.all(4.w),
              child: isChecked
                  ? PeepIcon(
                      Iconsax.checkTrue,
                      color: color,
                      size: 24.w,
                    )
                  : PeepIcon(
                      Iconsax.checkFalse,
                      color: color,
                      size: 24.w,
                    )),
        ));
  }
}
