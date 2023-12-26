import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/calendar_page_contoller.dart';

class CalendarPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CalendarPageController>(() {
      return CalendarPageController();
    });
  }
}
