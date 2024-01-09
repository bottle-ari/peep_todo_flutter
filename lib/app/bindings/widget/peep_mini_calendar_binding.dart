import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/widget/peep_mini_calendar_controller.dart';

class PeepMiniCalendarBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PeepMiniCalendarController>(() {
      return PeepMiniCalendarController();
    });
  }
}