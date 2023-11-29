import 'package:flutter/material.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';

class CalendarPickerModal extends StatelessWidget {
  final Function(DateTime) onDateSelected;

  const CalendarPickerModal({super.key, required this.onDateSelected});

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
        padding: EdgeInsets.all(AppValues.screenPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    '0000년 00월',
                    style: PeepTextStyle.boldL(color: Palette.peepGray400),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: PeepIcon(
                    Iconsax.checkTrue,
                    size: AppValues.largeIconSize,
                  ),
                ),
              ],
            ),
            // Todo : Date Picker 추가
            // DatePickerDialog(
            //   initialDate: DateTime.now(),
            //   firstDate: DateTime.utc(1923, 1, 1),
            //   lastDate: DateTime.utc(2123, 1, 1),
            // ),
          ],
        ),
      ),
    );
  }
}
