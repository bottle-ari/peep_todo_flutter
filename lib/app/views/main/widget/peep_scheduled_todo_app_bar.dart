import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:peep_todo_flutter/app/controllers/mini_calendar_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_view.dart';
import 'package:peep_todo_flutter/app/routes/app_pages.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_notification_button.dart';
import 'package:peep_todo_flutter/app/views/common/peep_dropdown_menu.dart';

import '../../../theme/app_values.dart';
import '../../../theme/icons.dart';
import '../../../theme/palette.dart';

class PeepScheduledTodoAppBar extends BaseView<MiniCalendarController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return Obx(
      () => Container(
        width: AppValues.screenWidth,
        height: 64.h,
        padding: EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
        // 옆의 여백 조절
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                controller.onMoveToday();
              },
              //Todo
              child: Text(
                  DateFormat('MM월 dd일').format(controller.selectedDay.value),
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
                  onTapFunc: () {
                    Get.toNamed(AppPages.OVERDUETODO);
                  },
                ),
                SizedBox(width: AppValues.horizontalMargin),
                PeepDropdownMenu(
                  menuItems: [
                    DropdownMenuItemData(
                        'popup_action_1',
                        PeepIcon(Iconsax.addcircle,
                            size: AppValues.smallIconSize,
                            color: Palette.peepBlack),
                        '카테고리 추가'),
                    DropdownMenuItemData(
                        'popup_action_2',
                        PeepIcon(Iconsax.categorybox,
                            size: AppValues.smallIconSize,
                            color: Palette.peepBlack),
                        '카테고리 관리'),
                    DropdownMenuItemData(
                        'popup_action_3',
                        PeepIcon(Iconsax.reminder,
                            size: AppValues.smallIconSize,
                            color: Palette.peepBlack),
                        '리마인더 관리'),
                    DropdownMenuItemData(
                        'popup_action_4',
                        PeepIcon(Iconsax.routine,
                            size: AppValues.smallIconSize,
                            color: Palette.peepBlack),
                        '루틴 추가'),
                  ],
                  onMenuItemSelected: (popupNum) {
                    if (popupNum == 'popup_action_1') {
                      debugPrint('1');
                    } else if (popupNum == 'popup_action_2') {
                      debugPrint('2');
                      // 카테고리 관리
                      Get.toNamed(Routes.CATEGORY_MANAGE_PAGE);
                    } else if (popupNum == 'popup_action_3') {
                      debugPrint('3');
                    } else {
                      debugPrint('4');
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
