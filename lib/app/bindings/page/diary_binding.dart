import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/diary_page_controller.dart';

class DiaryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DiaryPageController>(() {
      return DiaryPageController();
    });
  }
}
