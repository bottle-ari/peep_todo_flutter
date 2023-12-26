import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/search_item_controller.dart';

class SearchItemBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchItemController>(() {
      return SearchItemController();
    });
  }
}