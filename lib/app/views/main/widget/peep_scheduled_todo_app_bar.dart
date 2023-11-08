import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_notification_button.dart';
import 'package:peep_todo_flutter/app/views/common/peep_dropdown_menu.dart';

import '../../../theme/app_values.dart';
import '../../../theme/icons.dart';
import '../../../theme/palette.dart';

class PeepScheduledTodoAppBar extends StatelessWidget {
  const PeepScheduledTodoAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppValues.screenWidth,
      height: 64.h,
      padding: EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
      // 옆의 여백 조절
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {},
            //Todo
            child: Text('11월 9일',
                style: PeepTextStyle.boldXL(color: Palette.peepGray500)),
          ),
          Row(
            children: [
              PeepNotificationButton(
                icon: PeepIcon(
                  Iconsax.clock,
                  size: AppValues.baseIconSize,
                  color: Palette.peepGray500,
                ),
                isNotified: true,
                onTapFunc: () {},
              ),
              SizedBox(width: AppValues.horizontalMargin),
              PeepDropdownMenu(
                menuItems: [
                  DropdownMenuItemData(
                      'popup_action_1',
                      PeepIcon(Iconsax.addcircle,
                          size: AppValues.smallIconSize, color: Palette.peepBlack),
                      '카테고리 추가'),
                  DropdownMenuItemData(
                      'popup_action_2',
                      PeepIcon(Iconsax.categorybox,
                          size: AppValues.smallIconSize, color: Palette.peepBlack),
                      '카테고리 관리'),
                  DropdownMenuItemData(
                      'popup_action_3',
                      PeepIcon(Iconsax.reminder,
                          size: AppValues.smallIconSize, color: Palette.peepBlack),
                      '리마인더 관리'),
                  DropdownMenuItemData(
                      'popup_action_4',
                      PeepIcon(Iconsax.routine,
                          size: AppValues.smallIconSize, color: Palette.peepBlack),
                      '루틴 추가'),
                ],
                onMenuItemSelected: (popupNum) {
                  if (popupNum == 'popup_action_1') {

                  } else if (popupNum == 'popup_action_2') {

                  } else if (popupNum == 'popup_action_3') {

                  } else {

                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
