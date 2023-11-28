import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:peep_todo_flutter/app/controllers/peep_calendar_controller.dart';
import 'package:peep_todo_flutter/app/controllers/page/scheduled_todo_controller.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/utils/peep_calendar_util.dart';
import 'package:peep_todo_flutter/app/views/calendar/widget/peep_calendar_day_cell.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../theme/app_values.dart';
import '../../../theme/palette.dart';

class PeepCalendar extends StatelessWidget {
  final ScheduledTodoController scheduledTodoController;
  final PeepCalendarController calendarController;

  const PeepCalendar({
    Key? key,
    required this.scheduledTodoController,
    required this.calendarController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: const BoxDecoration(
          color: Palette.peepWhite,
        ),
        child: TableCalendar(
          headerVisible: false,
          daysOfWeekHeight: 35.h,
          rowHeight: 93.h,
          locale: 'ko_KR',
          firstDay: DateTime.utc(1923, 1, 1),
          lastDay: DateTime.utc(2123, 12, 31),
          calendarFormat: CalendarFormat.month,
          startingDayOfWeek: StartingDayOfWeek.sunday,
          focusedDay: calendarController.focusedDay.value,

          selectedDayPredicate: (day) {
            return isSameDay(calendarController.selectedDay.value, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            calendarController.onDaySelected(selectedDay, focusedDay);
          },
          onPageChanged: (focusedDay) {
            calendarController.onPageChanged(focusedDay);
          },

          // calendarBuilder
          calendarBuilders: CalendarBuilders(
            // 요일 스타일링 : 토(blue), 일(red)
            dowBuilder: (context, day) {
              return Center(
                child: Text(
                  DateFormat.E('ko_KR').format(day),
                  style: PeepTextStyle.regularS(color: getDayColor(day)),
                ),
              );
            },
            // 현재 달에 포함되지 않는 바깥의 날짜 cell
            outsideBuilder: (context, day, focusedDay) {
              return Stack(
                children: [
                  PeepCalendarDayCell(
                    day: day,
                    scheduledTodoController: scheduledTodoController,
                    calendarController: calendarController,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Palette.peepWhite
                            .withOpacity(AppValues.baseOpacity),
                      ),
                    ),
                  ),
                ],
              );
            },
            // 선택된 날짜 cell
            selectedBuilder: (context, day, focusedDay) {
              return Stack(
                children: [
                  PeepCalendarDayCell(
                    day: day,
                    scheduledTodoController: scheduledTodoController,
                    calendarController: calendarController,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Palette.peepGray300),
                        borderRadius: BorderRadius.all(
                          Radius.circular(AppValues.smallRadius),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
            // 오늘 날짜 cell
            todayBuilder: (context, day, focusedDay) {
              return Stack(
                children: [
                  PeepCalendarDayCell(
                    day: day,
                    scheduledTodoController: scheduledTodoController,
                    calendarController: calendarController,
                  ),
                  if (day.month != focusedDay.month)
                    Padding(
                      padding: const EdgeInsets.only(top: 1),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Palette.peepWhite
                              .withOpacity(AppValues.baseOpacity),
                        ),
                      ),
                    ),
                ],
              );
            },
            // 기본 날짜 cell
            defaultBuilder: (context, day, focusedDay) {
              return PeepCalendarDayCell(
                day: day,
                scheduledTodoController: scheduledTodoController,
                calendarController: calendarController,
              );
            },
          ),
        ),
      ),
    );
  }
}
