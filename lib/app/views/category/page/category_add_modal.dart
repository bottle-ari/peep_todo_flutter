import 'package:flutter/material.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/todo/widget/peep_button_textfield.dart';

class CategoryAddModal extends StatelessWidget {
  final Color initColor;

  const CategoryAddModal({super.key, required this.initColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.peepWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppValues.baseRadius),
          topRight: Radius.circular(AppValues.baseRadius),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: AppValues.screenPadding,
            ),
            Text(
              '카테고리 추가하기',
              style: PeepTextStyle.boldL(color: Palette.peepGray400),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppValues.screenPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PeepCategoryTextfield(
                    emoji: '🤔',
                    color: initColor,
                    onTapEmoji: () {},
                    onTapAddButton: (string) {},
                    onLongPressAddButton: () {},
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
