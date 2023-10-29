import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/todo_controller.dart';
import 'package:peep_todo_flutter/app/data/mock_data.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'common/todo/peep_todo_list.dart';

class TestController extends GetxController {
  // 위젯 구현 및 테스트 중, 상위 컨트롤러가 필요하다면 여기에서 간단하게 구현하여 사용하세요.
  Rx<Color> color = Palette.peepGreen.obs;
}

class Test extends StatelessWidget {
  Test({super.key});

  final TestController controller = Get.put(TestController());
  final TodoController todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Title")),
      body: Obx(
        () => SizedBox(
          height: double.infinity,
          child: Center(
            // 여기에 위젯 붙여넣기
            child: PeepTodoList(color: controller.color.value, todoController: todoController,),
          ),
        ),
      ),
    );
  }
}
