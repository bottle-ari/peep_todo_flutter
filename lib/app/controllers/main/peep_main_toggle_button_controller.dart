import 'dart:developer';

import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class PeepMainToggleButtonController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final RxInt selectedIndex = 0.obs;

  final isLoading = true.obs;
  late final AnimationController animationController;

  @override
  void onInit() {
    super.onInit();
    loadAnimationController();
  }

  void loadAnimationController() async {
    isLoading(true);
    animationController = AnimationController(
        duration: const Duration(milliseconds: 50), vsync: this);

    log(animationController.value.toString());

    if (selectedIndex.value == 1) {
      animationController.forward();
    }
    isLoading(false);
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
