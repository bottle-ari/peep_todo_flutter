import 'package:get/get.dart';

import '../../controllers/page/dairy_edit_controller.dart';

class DiaryEditBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DiaryEditController>(() {
      return DiaryEditController();
    });
  }
}
