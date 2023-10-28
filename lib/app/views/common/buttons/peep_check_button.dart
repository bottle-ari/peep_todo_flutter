import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../theme/icons.dart';

class PeepCheckButton extends StatelessWidget {
  final Color color;
  final VoidCallback isToggled;
  final bool isMain;
  final bool isChecked;

  const PeepCheckButton({
    Key? key,
    required this.color,
    required this.isToggled,
    required this.isMain,
    required this.isChecked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          isToggled();
        },
        iconSize: isMain ? 20.w : 18.w,
        icon: isChecked
            ? PeepIcon(
                Iconsax.checkTrue,
                color: color,
                size: isMain ? 20.w : 18.w,
              )
            : PeepIcon(
                Iconsax.checkFalse,
                color: color,
                size: isMain ? 20.w : 18.w,
              ));
  }
}
