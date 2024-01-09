import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/animation/peep_animation_effect_controller.dart';

class PeepAnimationEffect extends StatelessWidget {
  final Widget child;
  final double scale;
  final Function? onTap;
  final Function? onLongPress;

  const PeepAnimationEffect({
    super.key,
    required this.child,
    this.onTap,
    this.scale = 0.9,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final controller = PeepAnimationEffectController();

    return Listener(
      onPointerDown: (_) => controller.isPressed.value = true,
      onPointerUp: (_) => controller.isPressed.value = false,
      child: GestureDetector(
        onTap: () {
          if (onTap != null) onTap!();
          controller.isPressed.value = false;
        },
        onLongPress: () {
          if (onLongPress != null) onLongPress!();
        },
        child: Obx(
          () => AnimatedScale(
            scale: controller.isPressed.value ? scale : 1.0,
            duration: const Duration(milliseconds: 50),
            child: child,
          ),
        ),
      ),
    );
  }
}
