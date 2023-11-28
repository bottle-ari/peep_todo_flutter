import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';

class PeepCalendarDayCellListItem extends StatelessWidget {
  final Color color;
  final String text;

  const PeepCalendarDayCellListItem({
    super.key,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 2.w,
          height: 15,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(
              Radius.circular(1),
            ),
          ),
        ),
        SizedBox(
          width: 2.w,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 2.w),
          child: SizedBox(
            width: (AppValues.screenWidth - AppValues.screenPadding * 2) / 7 -
                6.w,
            child: Text(
              text,
              style: TextStyle(
                color: Palette.peepBlack,
                fontSize: 8.sp,
                fontWeight: FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
      ],
    );
  }
}
