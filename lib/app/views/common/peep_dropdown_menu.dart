import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';

import 'package:peep_todo_flutter/app/theme/app_values.dart';

class PeepDropdownMenu extends StatelessWidget {
  final Function onTapFunc;
  final Function onTapSecondFunc;
  final Function onTapThirdFunc;
  final Function onTapFourthFunc;

  const PeepDropdownMenu({
    Key? key,
    required this.onTapFunc,
    required this.onTapSecondFunc,
    required this.onTapThirdFunc,
    required this.onTapFourthFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: PeepIcon(
        Iconsax.more,
        size: AppValues.smallIconSize,
        color: Palette.peepBlack,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppValues.smallRadius), // 원하는 모서리 둥글기 설정
      ),
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: 'popup_action_1',
            child: Row(
              children: [
                PeepIcon(Iconsax.addcircle,
                    size: AppValues.smallIconSize, color: Palette.peepBlack),
                SizedBox(width: AppValues.horizontalMargin),
                Text('카테고리 추가',
                    style: PeepTextStyle.regularXS(color: Palette.peepBlack)),
              ],
            ),
            onTap: () {
              onTapFunc();
            },
          ),
          PopupMenuItem<String>(
            value: 'popup_action_2',
            child: Row(
              children: [
                PeepIcon(Iconsax.categorybox,
                    size: AppValues.smallIconSize, color: Palette.peepBlack),
                SizedBox(width: AppValues.horizontalMargin),
                Text('카테고리 관리',
                    style: PeepTextStyle.regularXS(color: Palette.peepBlack)),
              ],
            ),
            onTap: () {
              onTapSecondFunc();
            },
          ),
          PopupMenuItem<String>(
            value: 'popup_action_3',
            child: Row(
              children: [
                PeepIcon(Iconsax.reminder,
                    size: AppValues.smallIconSize, color: Palette.peepBlack),
                SizedBox(width: AppValues.horizontalMargin),
                Text('리마인더 관리',
                    style: PeepTextStyle.regularXS(color: Palette.peepBlack)),
              ],
            ),
            onTap: () {
              onTapThirdFunc();
            },
          ),
          PopupMenuItem<String>(
            value: 'popup_action_4',
            child: Row(
              children: [
                PeepIcon(Iconsax.routine,
                    size: AppValues.smallIconSize, color: Palette.peepBlack),
                SizedBox(width: AppValues.horizontalMargin),
                Text('루틴 추가',
                    style: PeepTextStyle.regularXS(color: Palette.peepBlack)),
              ],
            ),
            onTap: () {
              onTapFourthFunc();
            },
          ),
        ];
      },
    );
  }
}
