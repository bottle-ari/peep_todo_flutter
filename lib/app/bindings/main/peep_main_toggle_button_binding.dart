import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/main/peep_main_toggle_button_controller.dart';

class PeepMainToggleButtonBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PeepMainToggleButtonController>(() {
      return PeepMainToggleButtonController();
    });
  }
}