import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/animation/peep_animation_effect_controller.dart';

class PeepAnimationEffect extends StatelessWidget {
  final Widget child;
  final Function onTap;

  const PeepAnimationEffect(
      {super.key, required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final controller = PeepAnimationEffectController();

    return GestureDetector(
      onTapDown: (_) => controller.isPressed.value = true,
      onTapUp: (_) => controller.isPressed.value = false,
      onTapCancel: () => controller.isPressed.value = false,
      onTap: () {
        onTap();
        controller.isPressed.value = false;
      },
      child: Obx(
        () => Transform.scale(
          scale: controller.isPressed.value ? 0.9 : 1.0,
          child: child,
        ),
      ),
    );
  }
}
