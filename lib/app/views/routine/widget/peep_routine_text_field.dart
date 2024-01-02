import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/views/common/base/peep_text_field.dart';

class PeepRoutineTextField extends StatelessWidget {
  final Color color;
  final TextEditingController textEditingController;
  final FocusNode focusNode;

  const PeepRoutineTextField({
    super.key,
    required this.color,
    required this.textEditingController,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppValues.baseRadius),
      child: Container(
        width: AppValues.screenWidth - AppValues.screenPadding * 2,
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(AppValues.baseRadius),
          color: Palette.peepWhite,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: AppValues.baseItemHeight),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppValues.innerMargin),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    SizedBox(width: AppValues.textMargin),
                    SizedBox(
                      width: 280.w,
                      child: PeepTextField(
                        hintText: "루틴 이름을 입력해주세요",
                        controller: textEditingController,
                        inputType: TextInputType.text,
                        autoFocus: false,
                        color: color,
                        focusNode: focusNode,
                        func: (String str) {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
