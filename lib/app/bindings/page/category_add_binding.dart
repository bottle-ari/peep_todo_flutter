import 'package:get/get.dart';
import '../../controllers/page/category_add_controller.dart';


class CategoryAddBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryAddController>(() {
      return CategoryAddController();
    });
  }
}