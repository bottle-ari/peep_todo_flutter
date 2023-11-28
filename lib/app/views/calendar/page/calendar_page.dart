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

  // Todo : statusBar 색, peepWhite 적용 확인
  //statusBar 색 지정
  @override
  Color statusBarColor() {
    return Palette.peepWhite;
  }

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  //배경색 지정
  @override
  Color pageBackgroundColor() {
    return Palette.peepWhite;
  }

  @override
  Widget body(BuildContext context) {
    return Container(
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
