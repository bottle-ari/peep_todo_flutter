import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';

import '../../../controllers/animation/todo_priority_animation_controller.dart';
import '../../../controllers/todo_controller.dart';
import '../../../theme/icons.dart';

class PeepPriorityFoldingButton extends StatelessWidget {
  final Color color;
  final double size = AppValues.baseIconSize;
  final int index;

  PeepPriorityFoldingButton({super.key, required this.index, required this.color});

  @override
  Widget build(BuildContext context) {
    final TodoController controller = Get.find();
    final TodoPriorityAnimationController animationController = Get.put(
        TodoPriorityAnimationController(
            controller.todoList[index].isFold.value),
        tag: controller.todoList[index].id.toString());

    return Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: () {
              controller.toggleTodoIsFold(index);
              animationController
                  .toggleAnimation(controller.todoList[index].isFold.value);
            },
            child: AnimatedBuilder(
                animation: animationController.animation,
                builder: (context, child) {
                  return Padding(
                    padding: EdgeInsets.only(left: AppValues.horizontalMargin, right: AppValues.innerMargin),
                    child: SizedBox(
                      width: size,
                      height: size * 1.6,
                      child: Stack(
                        children: [
                          Positioned(
                            top: size * 0.3 + animationController.animation.value / 2 * -1,
                            child: PeepIcon(Iconsax.eggTop,
                                color: color, size: size),
                          ),
                          Positioned(
                            top: size * 0.3 + animationController.animation.value / 2,
                            child: PeepIcon(Iconsax.eggBottom,
                                color: color, size: size),
                          )
                        ],
                      ),
                    ),
                  );
                })));
  }
}
