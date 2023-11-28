import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/main/bottom_navigation_controller.dart';

class BottomNavBarBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavigationController>(() {
      return BottomNavigationController();
    });
  }
}