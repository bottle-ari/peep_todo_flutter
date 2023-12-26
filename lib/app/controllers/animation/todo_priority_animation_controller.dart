import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TodoPriorityAnimationController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  final bool isFold;
  final double openHeight = 8.h;

  TodoPriorityAnimationController(this.isFold);

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    animation = Tween<double>(begin: openHeight, end: 0.0).animate(animationController);

    if (isFold) {
      animationController.value = openHeight;
    }
  }

  void toggleAnimation() {
    if (isFold) {
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