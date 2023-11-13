import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/category_manage_page_controller.dart';

class CategoryManagePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryManagePageController>(() {
      return CategoryManagePageController();
    });
  }
}
