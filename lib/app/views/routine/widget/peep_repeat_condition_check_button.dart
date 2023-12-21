import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import '../../../theme/icons.dart';

class PeepRepeatConditionCheckButton extends StatelessWidget {
  final bool isChecked;
  final Color color;
  final Function onTap;

  const PeepRepeatConditionCheckButton({
    Key? key,
    required this.color,
    required this.isChecked,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppValues.innerMargin,
              vertical: AppValues.verticalMargin),
          child: isChecked
              ? PeepIcon(
            Iconsax.checkTrue,
            color: color,
            size: 24.w,
          )
              : PeepIcon(
            Iconsax.checkFalse,
            color: Palette.peepGray400,
            size: 24.w,
          ),
        ),
      ),
    );
  }
}
