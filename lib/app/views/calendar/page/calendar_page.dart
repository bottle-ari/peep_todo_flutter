import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/calendar_page_contoller.dart';
import 'package:peep_todo_flutter/app/controllers/page/scheduled_todo_controller.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/views/calendar/widget/peep_calendar.dart';
import '../../../core/base/base_view.dart';

class CalendarPage extends BaseView<CalendarPageController> {
  final ScheduledTodoController scheduledTodoController = Get.find();

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return Container(
      color: Palette.peepWhite,
      height: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
        child: PeepCalendar(
          scheduledTodoController: scheduledTodoController,
          calendarController: controller.peepCalendarController,
        ),
      ),
    );
  }
}
