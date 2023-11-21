import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_check_button.dart';

class PeepTodoDetailMainItem extends StatelessWidget {
  final Color color;
  final VoidCallback onTap;

  const PeepTodoDetailMainItem({
    Key? key,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // define TextEditingController
    TextEditingController controller = TextEditingController();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppValues.horizontalMargin),
      child: Material(
        child: Container(
          width: double.infinity,
          height: 64.h,
          decoration: BoxDecoration(
            color: Palette.peepWhite,
            borderRadius: BorderRadius.circular(AppValues.baseRadius),
          ),
          child: Padding(
            padding:
            EdgeInsets.symmetric(horizontal: AppValues.horizontalMargin),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: color),
                  borderRadius: BorderRadius.circular(AppValues.baseRadius),
                ),
                border: InputBorder.none,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                // hint text 고정
                contentPadding: EdgeInsets.fromLTRB(
                  AppValues.horizontalMargin, // 왼쪽
                  2 * AppValues.verticalMargin, // 위쪽
                  AppValues.horizontalMargin, // 오른쪽
                  2 * AppValues.verticalMargin, // 아래쪽
                ),
                suffixIcon: GestureDetector(
                  onTap: onTap,
                  child: Padding(
                    padding: EdgeInsets.only(right: AppValues.horizontalMargin),
                    child: Transform.scale(
                      scale: 1.0,
                      child: PeepIcon(Iconsax.checkFalse,
                          color: Palette.peepGray400,
                          size: AppValues.baseIconSize),
                    ),
                  ),
                ),
                hintText: '할 일을 입력해주세요!',
                hintStyle: PeepTextStyle.boldL(color: Palette.peepGray300),
              ),
              style: PeepTextStyle.boldL(color: Palette.peepBlack),
            ),
          ),
        ),
      ),
    );
  }
}
