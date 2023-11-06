import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';

import '../../../controllers/animation/todo_priority_animation_controller.dart';
import '../../../controllers/todo_controller.dart';
import '../../../theme/icons.dart';

class PeepPriorityFoldingButton extends StatelessWidget {
  final double size = AppValues.baseIconSize;
  final int index;

  PeepPriorityFoldingButton(
      {super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final TodoController controller = Get.find();
    final TodoPriorityAnimationController animationController = Get.put(
        TodoPriorityAnimationController(controller.todoList[index].isFold.value),
        tag: controller.todoList[index].id.toString());
    Color color = Palette.peepGray400;

    switch(controller.todoList[index].priority) {
      case 1:
        color = Palette.peepGreen;
        break;
      case 2:
        color = Palette.peepYellow400;
        break;
      case 3:
        color = Palette.peepRed;
        break;
      default:
        color = Palette.peepGray400;
        break;
    }

    return Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: () {
              controller.toggleTodoIsFold(index);
              animationController.toggleAnimation(controller.todoList[index].isFold.value);
            },
            child: AnimatedBuilder(
                animation: animationController.animation,
                builder: (context, child) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppValues.horizontalMargin,
                        vertical: AppValues.verticalMargin),
                    child: SizedBox(
                      height: size + animationController.animation.value,
                      child: Stack(
                        children: [
                          PeepIcon(Iconsax.eggTop, color: color, size: size),
                          Positioned(
                            top: animationController.animation.value,
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
