import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:peep_todo_flutter/app/controllers/todo_controller.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/utils/peep_calendar_util.dart';
import 'package:peep_todo_flutter/app/views/common/painter/ring_painter.dart';

class PeepCalendarDayIndicator extends StatelessWidget {
  final DateTime day;
  final bool isToday;
  final TodoController todoController = Get.find();

  PeepCalendarDayIndicator({
    super.key,
    required this.isToday,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      /* Ring Painter 의 두께(5px) 만큼 크기 조정 */
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Stack(
        alignment: Alignment.center,
        children: [
          /* Ring Painter 관련 코드 */
          Obx(
            () => CustomPaint(
              size: Size(32.w, 32.w),
              painter: RingPainter(
                  itemCounts: todoController.calendarItemCounts[
                  DateFormat('yyyyMMdd').format(day)] ??
                      {}),
            ),
          ),
          /* 선택된 날짜 == 오늘 날짜 */
          if (isToday)
            Container(
              alignment: Alignment.center,
              /* Ring Painter 의 두께(5px) 만큼 크기 조정 */
              width: 32.w - 5,
              height: 32.w - 5,
              decoration: const BoxDecoration(
                color: Palette.peepYellow400,
                shape: BoxShape.circle,
              ),
              child: Text(
                day.day.toString(),
                style: PeepTextStyle.boldS(color: Palette.peepWhite),
              ),
            )
          else
            Text(
              day.day.toString(),
              style: PeepTextStyle.regularS(color: getDayColor(day)),
            ),
        ],
      ),
    );
  }
}
