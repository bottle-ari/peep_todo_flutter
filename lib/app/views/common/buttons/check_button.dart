import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckButtonController extends GetxController {
  var isCheck = false.obs;
  var isMain = true.obs;

  CheckButtonController({required bool initialIsCheck, required bool initialIsMain}) {
    isCheck.value = initialIsCheck;
    isMain.value = initialIsMain;
  }
}

class CheckButton extends StatelessWidget {
  final Color color;
  final ValueChanged<bool> onCheckedChanged;
  final bool initialIsCheck;
  final bool initialIsMain;

  const CheckButton({
    required this.color,
    required this.onCheckedChanged,
    required this.initialIsCheck,
    required this.initialIsMain,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckButtonController(initialIsCheck: initialIsCheck, initialIsMain: initialIsMain));
    return Obx(() {
      return IconButton(
        onPressed: () {
          controller.isCheck.value = !controller.isCheck.value;
          onCheckedChanged(controller.isCheck.value);
        },
        iconSize: controller.isMain.value ? 24 : 20,
        icon: controller.isCheck.value
            ? Icon(
          CupertinoIcons.check_mark_circled_solid,
          color: color,
        )
            : Icon(
          CupertinoIcons.circle,
          color: color,
        ),
      );
    });
  }
}