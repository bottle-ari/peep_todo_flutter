import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_button.dart';

class TestController extends GetxController {
  // 위젯 구현 및 테스트 중, 상위 컨트롤러가 필요하다면 여기에서 간단하게 구현하여 사용하세요.
}

class Test extends StatelessWidget {
  Test({super.key});

  final TestController controller = Get.put(TestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Title")),
      body: SizedBox(
        height: double.infinity,
        child: Center(
          // 여기에 위젯 붙여넣기
          child: PeepButton(
            color: Palette.peepYellow300,
            text: '시작하기',
            func: () {},
            isActive: true,
          ),
        ),
      ),
    );
  }
}
