import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';

class PeepCategoryTag extends StatelessWidget {
  final Color color;
  final String name;

  const PeepCategoryTag({
    Key? key,
    required this.color,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Center(
        widthFactor: 1,
        child: Text(
          name,
          style: PeepTextStyle.boldXS(color: Colors.white),
        ),
      ),
    );
  }
}
