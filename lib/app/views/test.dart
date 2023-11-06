import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/todo_controller.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_priority_folding_button.dart';
import 'package:peep_todo_flutter/app/views/todo/widget/peep_todo_item.dart';
import '../controllers/animation/todo_priority_animation_controller.dart';
import '../theme/icons.dart';

class TestController extends GetxController {
  // 위젯 구현 및 테스트 중, 상위 컨트롤러가 필요하다면 여기에서 간단하게 구현하여 사용하세요.
  Rx<Color> color = Palette.peepYellow400.obs;
  RxBool isChecked = false.obs;
  RxBool isMain = true.obs;
  RxBool isOpen = true.obs;

  void toggleChecked() {
    isOpen.value = !isOpen.value;
  }
}

class Test extends StatelessWidget {
  Test({super.key});

  final TestController controller = Get.put(TestController());
  final TodoController todoController = Get.put(TodoController());
  final TodoPriorityAnimationController animationController = Get.put(TodoPriorityAnimationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Title")),
      body: SizedBox(
        height: double.infinity,
        child: Center(
          // 여기에 위젯 붙여넣기
          child: PeepTodoItem(),
        ),
      ),
    backgroundColor: Palette.peepBackground,
    );
  }
}
