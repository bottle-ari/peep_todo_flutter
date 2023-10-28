import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';

class PeepCategoryButton extends StatelessWidget {
  final Color color;
  final String name;
  final String emoji;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const PeepCategoryButton({
    Key? key,
    required this.color,
    required this.name,
    required this.emoji,
    required this.onTap,
    required this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        height: 32.h,
        decoration: BoxDecoration(
          color: Palette.peepButton300,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 10.w, right: 8.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  // Emoji
                  Text(emoji),
                  SizedBox(
                    width: 3.w,
                  ),
                  // Category Name
                  Text(
                    name,
                    style: PeepTextStyle.boldS(color)),
                ],
              ),
              SizedBox(
                width: 15.w,
              ),
              // Add Icon
              Icon(
                Icons.add_circle,
                color: Palette.peepYellow400,
                size: 18.w,
              )
            ],
          ),
        ),
      ),
    );
  }
}
