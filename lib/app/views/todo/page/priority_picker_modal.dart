import 'package:flutter/material.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/todo/widget/peep_priority_picker_item.dart';

class PriorityPickerModal extends StatelessWidget {
  final int currentPriority;

  const PriorityPickerModal({super.key, required this.currentPriority});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.peepWhite,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(AppValues.baseRadius),
            topLeft: Radius.circular(AppValues.baseRadius)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: AppValues.verticalMargin,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: AppValues.verticalMargin,
              bottom: AppValues.verticalMargin,
              left: AppValues.screenPadding,
            ),
            child: Text(
              '우선순위 설정',
              style: PeepTextStyle.boldL(color: Palette.peepGray400),
            ),
          ),
          for (int i = 4; i >= 0; i--)
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppValues.screenPadding / 2),
              child: PeepPriorityPickerItem(
                priority: i,
                onTap: () {
                  debugPrint("onTap $i");
                },
                currentPriority: i == currentPriority,
              ),
            ),
          SizedBox(
            height: AppValues.verticalMargin,
          ),
        ],
      ),
    );
  }
}
