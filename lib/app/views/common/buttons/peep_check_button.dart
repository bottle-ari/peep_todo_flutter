import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/todo_controller.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';

import '../../../theme/icons.dart';
import '../../test.dart';

class PeepCheckButton extends StatelessWidget {
  final Color color;

  const PeepCheckButton({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Todo : TodoController로 변경해야함
    final TestController controller = Get.find();

    return Obx(
      () => Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              controller.isChecked.value = !controller.isChecked.value;
            },
            child: controller.isChecked.value
                ? PeepIcon(Iconsax.checkTrue,
                    color: color, size: controller.isMain.value ? 24.w : 20.w)
                : PeepIcon(Iconsax.checkFalse,
                    color: Palette.peepGray400,
                    size: controller.isMain.value ? 24.w : 20.w),
          )),
    );
  }
}
