import 'package:get/get.dart';

import '../../controllers/mini_calendar_controller.dart';

class MiniCalendarBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MiniCalendarController>(() {
      return MiniCalendarController();
    });
  }
}