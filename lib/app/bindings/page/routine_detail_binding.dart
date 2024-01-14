import 'package:get/get.dart';
import '../../controllers/page/routine_detail_controller.dart';

class RoutineDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoutineDetailController>(() {
      return RoutineDetailController();
    });
  }
}