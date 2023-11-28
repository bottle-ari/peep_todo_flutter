import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/data/enums/todo_enum.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';

import '../../../controllers/animation/todo_priority_animation_controller.dart';
import '../../../controllers/todo_controller.dart';
import '../../../theme/icons.dart';

class PeepPriorityFoldingButton extends StatelessWidget {
  final Color color;
  final double size = AppValues.baseIconSize;
  final String todoId;
  final TodoType todoType;
  final TodoController controller;

  PeepPriorityFoldingButton(
      {super.key,
      required this.todoId,
      required this.color,
      required this.controller,
      required this.todoType});

  @override
  Widget build(BuildContext context) {
    final TodoPriorityAnimationController animationController =
        Get.put(TodoPriorityAnimationController(true), tag: todoId.toString());

    return Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: () {
              controller.toggleIsFold(todoId: todoId, type: todoType);
              animationController.toggleAnimation();
            },
            child: AnimatedBuilder(
                animation: animationController.animation,
                builder: (context, child) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppValues.horizontalMargin,
                    ),
                    child: SizedBox(
                      width: size,
                      height: size * 1.6,
                      child: Stack(
                        children: [
                          Positioned(
                            top: size * 0.3 +
                                animationController.animation.value / 2 * -1,
                            child: PeepIcon(Iconsax.eggTop,
                                color: color, size: size),
                          ),
                          Positioned(
                            top: size * 0.3 +
                                animationController.animation.value / 2,
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
