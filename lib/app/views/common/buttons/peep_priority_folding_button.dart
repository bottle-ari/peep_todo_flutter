import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';

import '../../../controllers/animation/todo_priority_animation_controller.dart';
import '../../../theme/icons.dart';
import '../../test.dart';

class PeepPriorityFoldingButton extends StatelessWidget {
  final Color color;
  final double size;

  PeepPriorityFoldingButton({super.key, required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    final TestController controller = Get.find();
    final TodoPriorityAnimationController animationController = Get.find();

    return Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: () {
              controller.toggleChecked();
              animationController.toggleAnimation(controller.isOpen.value);
            },
            child: AnimatedBuilder(
                animation: animationController.animation,
                builder: (context, child) {
                  return SizedBox(
                    height:
                    size + animationController.animation.value,
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
                  );
                })));
  }
}
