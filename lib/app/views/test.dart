import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/views/todo/widget/peep_mini_calendar.dart';

class TestController extends GetxController {
  // 위젯 구현 및 테스트 중, 상위 컨트롤러가 필요하다면 여기에서 간단하게 구현하여 사용하세요.
  Rx<Color> color = Palette.peepYellow400.obs;
  RxBool isChecked = false.obs;
  RxBool isMain = true.obs;
  RxBool isOpen = false.obs;

  void toggleChecked() {
    isOpen.value = !isOpen.value;
  }
}

class Test extends StatelessWidget {
  Test({super.key});

  final TestController controller = Get.put(TestController());

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
