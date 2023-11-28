import 'package:flutter/material.dart';
import 'package:peep_todo_flutter/app/controllers/peep_calendar_controller.dart';
import 'package:peep_todo_flutter/app/controllers/page/scheduled_todo_controller.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/views/calendar/widget/peep_calendar_day_indicator.dart';
import 'package:table_calendar/table_calendar.dart';

class PeepCalendarDayCell extends StatelessWidget {
  final DateTime day;
  final ScheduledTodoController scheduledTodoController;
  final PeepCalendarController calendarController;

  const PeepCalendarDayCell({
    super.key,
    required this.day,
    required this.scheduledTodoController,
    required this.calendarController,
  });

  @override
  Widget build(BuildContext context) {
    // List<Color> colorList = [Colors.purple, Colors.green, Colors.blue];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          color: Palette.peepGray200,
          thickness: 1,
          height: 1, // 가로선 상단 여백
        ),
        Center(
          child: PeepCalendarDayIndicator(
            isToday: isSameDay(day, calendarController.today),
            day: day,
          ),
        ),

        // Todo : 이후 이 위치에 Todo list 들어가도록
        // for (int i = 0; i < 3; i++)
        //   Padding(
        //     padding: const EdgeInsets.only(
        //       top: 1,
        //       bottom: 1,
        //       left: 2,
        //     ),
        //     child: PeepCalendarDayCellListItem(
        //       color: colorList[i],
        //       text: "texttexttexttexttexttexttexttexttexttexttexttexttext",
        //     ),
        //   )
      ],
    );
  }
}
