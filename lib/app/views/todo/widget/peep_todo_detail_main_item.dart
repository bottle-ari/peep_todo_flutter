import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:peep_todo_flutter/app/controllers/page/todo_detail_controller.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/views/common/base/peep_text_field.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_animation_effect.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_check_button.dart';
import 'package:peep_todo_flutter/app/views/todo/widget/peep_todo_detail_check_button.dart';

import '../../../controllers/data/palette_controller.dart';

class PeepTodoDetailMainItem extends StatelessWidget {
  final TodoDetailController controller;

  const PeepTodoDetailMainItem({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppValues.baseRadius),
      child: Container(
        width: AppValues.screenWidth - AppValues.screenPadding * 2,
        decoration: BoxDecoration(
          border: Border.all(color: controller.getColor()),
          borderRadius: BorderRadius.circular(AppValues.baseRadius),
          color: Palette.peepWhite,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: AppValues.baseItemHeight),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppValues.innerMargin),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    SizedBox(width: AppValues.textMargin),
                    SizedBox(
                      width: 280.w,
                      child: PeepTextField(
                        hintText: controller.todo.value.name,
                        controller: controller.textEditingController,
                        inputType: TextInputType.text,
                        autoFocus: false,
                        color: controller.getColor(),
                        focusNode: controller.focusNode,
                        func: (String str) {},
                      ),
                    ),
                    Flexible(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppValues.innerMargin),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: PeepAnimationEffect(
                            child: PeepTodoDetailCheckButton(
                                color: controller.getColor(),
                                controller: controller,
                                todoType: controller.todoType.value,
                                todo: controller.todo.value),
                                                          ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
