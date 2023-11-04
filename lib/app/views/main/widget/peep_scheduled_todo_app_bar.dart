import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_notification_button.dart';
import 'package:peep_todo_flutter/app/views/common/peep_dropdown_menu.dart';

import '../../../theme/app_values.dart';
import '../../../theme/icons.dart';
import '../../../theme/palette.dart';

class DateOfPick extends GetxController {
  var Date = 20231028;
}

class PeepScheduledTodoAppBar extends StatelessWidget {
  final String selectedDate;
  final Function() onTapClock;
  final Function() onTapFunc; // dropdown_menu 콜백 함수
  final Function() onTapSecondFunc; //dropdown_menu 콜백 함수
  final Function() onTapThirdFunc; //dropdown_menu 콜백 함수
  final Function() onTapFourthFunc; //dropdown_menu 콜백 함수

  const PeepScheduledTodoAppBar({
    Key? key,
    required this.selectedDate,
    required this.onTapClock,
    required this.onTapFunc,
    required this.onTapSecondFunc,
    required this.onTapThirdFunc,
    required this.onTapFourthFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
      // 옆의 여백 조절
      decoration: BoxDecoration(
        border: Border.all(color: Palette.peepBackground), // 박스 테두리 스타일링
        borderRadius: BorderRadius.circular(8.r), // 박스 모서리 라운딩
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(selectedDate, style: PeepTextStyle.boldXL(Palette.peepBlack)),
          Row(
            children: [
              PeepNotificationButton(
                icon: const PeepIcon(
                  Iconsax.clock,
                  size: AppValues.iconDefaultSize,
                  color: Palette.peepBlack,
                ),
                isNotified: true,
                onTapFunc: onTapClock,
              ),
              SizedBox(width: 10.w), // 아이콘 사이의 간격 조절
              PeepDropdownMenu(
                onTapFunc: onTapFunc,
                onTapSecondFunc: onTapSecondFunc,
                onTapThirdFunc: onTapThirdFunc,
                onTapFourthFunc: onTapFourthFunc,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
