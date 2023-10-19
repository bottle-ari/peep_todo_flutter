import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import '../buttons/check_button.dart';

class TodoDefaultController extends GetxController {
  var isFold = false.obs;

  TodoDefaultController({required bool initialIsFold}) {
    isFold.value = initialIsFold;
  }
}

class TodoDefault extends StatelessWidget {
  final bool initialIsFold;

  const TodoDefault({required this.initialIsFold, super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TodoDefaultController(
      initialIsFold: initialIsFold,));

    return Container(
        child: Column(
      children: [
        Row(
          children: [
            CheckButton(
              color: const Color(0xFFBD00FF),
              onCheckedChanged: (bool value) {},
              initialIsCheck: false,
              initialIsMain: true,
            ),
            const Text(
              "테스트 할 일",
              style: TextStyle(),
            ),
            const Icon(
              Iconsax.flag,
              color: Palette.peepRed,
              size: 18,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                    onPressed: () {
                      log("button pressed!");
                    },
                    icon: const Icon(
                      Iconsax.arrow_circle_up,
                      color: Palette.peepGray300,
                      size: 18,
                    )),
              ),
            )
          ],
        ),
      ],
    ));
  }
}
