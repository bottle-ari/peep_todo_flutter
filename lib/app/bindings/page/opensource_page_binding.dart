import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/opensource_page_controller.dart';

class OpenSourcePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OpenSourcePageController>(() {
      return OpenSourcePageController();
    });
  }
}