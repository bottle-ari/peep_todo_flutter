import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/todo/widget/peep_button_textfield.dart';

class TodoAddModal extends StatelessWidget {
  final Color color;

  const TodoAddModal({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.peepWhite,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(AppValues.baseRadius),
            topLeft: Radius.circular(AppValues.baseRadius)),
      ),
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.h,),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: AppValues.verticalMargin),
                child: Text(
                  'Todo 추가하기',
                  style: PeepTextStyle.boldL(color: Palette.peepGray400),
                ),
              ),
            ),
            PeepTodoTextfield(
                icon: PeepIcon(
                  Iconsax.egg,
                  color: Palette.peepGray400,
                  size: AppValues.baseIconSize,
                ),
                color: color,
                onTapPriority: () {},
                onTapAddButton: (String str) {}),
            SizedBox(height: 30.h,),
          ],
        ),
      ),
    );
  }
}
