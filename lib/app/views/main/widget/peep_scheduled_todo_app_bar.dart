import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_notification_button.dart';

import '../../../theme/icons.dart';
import '../../../theme/palette.dart';

class DateOfPick extends GetxController {
  var Date = 20231028;
}

class PeepScheduledTodoAppBar extends StatelessWidget {
  final String selectedDate;
  final Function() onTapFunc; // 추가된 콜백 함수
  final Function() onTapSecondFunc; //추가된 콜백 함수

  const PeepScheduledTodoAppBar({
    Key? key,
    required this.selectedDate,
    required this.onTapFunc,
    required this.onTapSecondFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w), // 옆의 여백 조절
      decoration: BoxDecoration(
        border: Border.all(color: Palette.peepBackground), // 박스 테두리 스타일링
        borderRadius: BorderRadius.circular(8.r), // 박스 모서리 라운딩
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(selectedDate, style: PeepTextStyle.boldXL(color: Palette.peepBlack)),
          Row(
            children: [
              PeepNotificationButton(icon: PeepIcon(Iconsax.clock, size: 24.r, color: Palette.peepBlack,), isNotified: true, onTapFunc: onTapFunc,),
              SizedBox(width: 10.w), // 아이콘 사이의 간격 조절
              IconButton(onPressed: onTapSecondFunc, icon: PeepIcon(Iconsax.more, size: 24.r, color: Palette.peepBlack,)),
            ],

          ),
        ],
      ),
    );
  }
}
