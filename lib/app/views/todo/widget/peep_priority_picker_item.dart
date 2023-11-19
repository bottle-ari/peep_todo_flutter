import 'package:flutter/material.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';

class PeepPriorityPickerItem extends StatelessWidget {
  final int priority;
  final bool currentPriority;
  final VoidCallback onTap;

  const PeepPriorityPickerItem({
    Key? key,
    required this.priority,
    required this.currentPriority,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color;
    String text;

    if (priority == 3) {
      color = Palette.peepRed;
      text = "높음";
    } else if (priority == 2) {
      color = Palette.peepYellow400;
      text = "보통";
    } else if (priority == 1) {
      color = Palette.peepGreen;
      text = "낮음";
    } else if (priority == 0) {
      color = Palette.peepGray400;
      text = "미설정";
    } else {
      return Container();
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        width: AppValues.screenWidth - AppValues.screenPadding,
        decoration: BoxDecoration(
          color: currentPriority ? Palette.peepButton200 : Palette.peepWhite,
          borderRadius: BorderRadius.all(
            Radius.circular(AppValues.baseRadius),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: AppValues.horizontalMargin,
            bottom: AppValues.horizontalMargin,
            left: AppValues.screenPadding / 2,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PeepIcon(
                Iconsax.egg,
                size: AppValues.smallIconSize,
                color: color,
              ),
              SizedBox(
                width: AppValues.horizontalMargin,
              ),
              Text(
                "중요도 $text",
                style: PeepTextStyle.regularM(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
