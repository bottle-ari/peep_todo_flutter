import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
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
  final List<DropdownMenuItemData> dropdownMenuItems;
  final Function(String) onMenuItemSelected;
  final Function() onTapClock;

  const PeepScheduledTodoAppBar({
    Key? key,
    required this.selectedDate,
    required this.dropdownMenuItems,
    required this.onMenuItemSelected,
    required this.onTapClock,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
      // 옆의 여백 조절
      decoration: BoxDecoration(
        border: Border.all(color: Palette.peepBackground), // 박스 테두리 스타일링
        borderRadius:
        BorderRadius.circular(AppValues.smallRadius), // 박스 모서리 라운딩
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(selectedDate,
              style: PeepTextStyle.boldXL(Palette.peepBlack)),
          Row(
            children: [
              PeepNotificationButton(
                icon: PeepIcon(
                  Iconsax.clock,
                  size: AppValues.baseIconSize,
                  color: Palette.peepBlack,
                ),
                isNotified: true,
                onTapFunc: onTapClock,
              ),
              SizedBox(width: AppValues.horizontalMargin), // 아이콘 사이의 간격 조절
              PeepDropdownMenu(
                menuItems: dropdownMenuItems,
                onMenuItemSelected: onMenuItemSelected,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
