import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/category_detail_controller.dart';


class CategoryDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryDetailController>(() {
      return CategoryDetailController();
    });
  }
}