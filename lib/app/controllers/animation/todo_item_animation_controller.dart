import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../todo_controller.dart';

class TodoItemAnimationController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  final double openHeight = 8.h;

  @override
  void onInit() {
    final TodoController todoController = Get.find();

    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    animation = Tween<double>(begin: 0.0, end: openHeight).animate(animationController);

    if (todoController.todoList[0].isFold.value) {
      animationController.value = openHeight;
    }
  }

  void toggleAnimation(bool isChecked) {
    if (isChecked) {
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