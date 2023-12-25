import 'package:flutter/material.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/routine/widget/peep_routine_check_button.dart';

class PeepRepeatConditionItem extends StatelessWidget {
  final String descriptionText;
  final String boldText;
  final String postfixText;
  final Color color;
  final bool isChecked;
  final Function onCheckButtonTap;
  final Function onBoldTextTap;
  final String prefixText;

  const PeepRepeatConditionItem({
    super.key,
    required this.descriptionText,
    required this.boldText,
    required this.postfixText,
    required this.color,
    required this.isChecked,
    required this.onCheckButtonTap,
    required this.onBoldTextTap,
    required this.prefixText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppValues.screenWidth - AppValues.screenPadding * 2,
      height: AppValues.baseItemHeight,
      decoration: BoxDecoration(
        border: Border.all(color: Palette.peepGray200),
        borderRadius: BorderRadius.circular(AppValues.baseRadius),
      ),
      child: Padding(
        padding: EdgeInsets.only(
            left: AppValues.innerMargin, right: AppValues.innerMargin * 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                PeepRoutineCheckButton(
                  color: color,
                  isChecked: isChecked,
                  onTap: onCheckButtonTap,
                ),
                Text(
                  descriptionText,
                  style: PeepTextStyle.regularS(color: Palette.peepBlack),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                onBoldTextTap();
              },
              child: Row(
                children: [
                  Text(
                    prefixText,
                    style: PeepTextStyle.regularM(color: Palette.peepBlack),
                  ),
                  SizedBox(width: AppValues.innerMargin),
                  Text(
                    boldText,
                    style: PeepTextStyle.boldL(color: Palette.peepGray500),
                  ),
                  SizedBox(width: AppValues.innerMargin),
                  Text(
                    postfixText,
                    style: PeepTextStyle.regularM(color: Palette.peepBlack),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
