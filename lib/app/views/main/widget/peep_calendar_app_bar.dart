import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:peep_todo_flutter/app/controllers/page/calendar_page_contoller.dart';
import 'package:peep_todo_flutter/app/controllers/data/peep_calendar_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_view.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import '../../../theme/app_values.dart';
import '../../../theme/icons.dart';
import '../../../theme/palette.dart';

class PeepCalendarAppBar extends BaseView<CalendarPageController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    final PeepCalendarController peepCalendarController =
        controller.peepCalendarController;

    return Obx(
      () => Container(
        color: Palette.peepWhite,
        width: AppValues.screenWidth,
        height: AppValues.appbarHeight,
        padding: EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
        // 옆의 여백 조절
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                // Todo : date picker 모달 띄우기
              },
              child: Text(
                  DateFormat('yyyy년 MM월')
                      .format(peepCalendarController.selectedDay.value),
                  style: PeepTextStyle.boldXL(color: Palette.peepGray500)),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    peepCalendarController.onMoveToday();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: AppValues.baseIconSize,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Palette.peepGray500,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(AppValues.tinyRadius))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppValues.innerMargin),
                      child: Text(
                        '오늘',
                        style:
                            PeepTextStyle.regularXS(color: Palette.peepGray500),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: AppValues.horizontalMargin),
                GestureDetector(
                  onTap: () {
                    // Todo : Todo 검색 페이지로 이동
                  },
                  child: PeepIcon(
                    Iconsax.calendarSearch,
                    size: AppValues.baseIconSize,
                    color: Palette.peepGray500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
