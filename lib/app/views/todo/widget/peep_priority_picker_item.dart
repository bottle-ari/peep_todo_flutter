import 'package:flutter/material.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/utils/priority_util.dart';

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
    return InkWell(
      onTap: onTap,
      child: Container(
        width: AppValues.screenWidth - AppValues.screenPadding,
        decoration: BoxDecoration(
          color: Palette.peepWhite,
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
                Iconsax.priority,
                size: AppValues.smallIconSize,
                color: PriorityUtil.getPriority(priority).PriorityColor,
              ),
              SizedBox(
                width: AppValues.horizontalMargin,
              ),
              Text(
                PriorityUtil.getPriority(priority).PriorityString,
                style: PeepTextStyle.regularM(
                    color: PriorityUtil.getPriority(priority).PriorityColor),
              ),
              if (currentPriority)
                Padding(
                  padding: EdgeInsets.only(left: AppValues.horizontalMargin),
                  child: PeepIcon(
                    Iconsax.checkBold,
                    size: AppValues.smallIconSize,
                    color: PriorityUtil.getPriority(priority).PriorityColor,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
