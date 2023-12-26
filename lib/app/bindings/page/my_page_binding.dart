import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/my_page_controller.dart';

class MyPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyPageController>(() {
      return MyPageController();
    });
  }
}