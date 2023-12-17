import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class PeepCategoryToggleButtonController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  final bool isActive;
  final double size;

  PeepCategoryToggleButtonController(this.isActive, this.size);

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    animation = Tween<double>(begin: 0.0, end: size * 0.8).animate(animationController);

    if(isActive) {
      animationController.value = size * 0.8;
    }
  }

  void toggleAnimation() {
    if (!animationController.isCompleted) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
