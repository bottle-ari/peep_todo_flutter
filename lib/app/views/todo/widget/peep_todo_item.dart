import 'package:flutter/material.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';

class PeepTodoItem extends StatelessWidget {
  const PeepTodoItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppValues.screenWidth - AppValues.screenPadding * 2,
      height: AppValues.baseItemHeight,
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(AppValues.baseRadius),
        color: Palette.peepWhite,
      ),
    );
  }

}