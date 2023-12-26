import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/scheduled_todo_controller.dart';
import 'package:peep_todo_flutter/app/data/enums/todo_enum.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/views/common/base/peep_text_field.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_animation_effect.dart';

import '../../../controllers/data/todo_controller.dart';

class PeepTodoInputItem extends StatelessWidget {
  final Color color;
  final TodoType todoType;
  final String todoId;
  final String categoryId;
  final FocusNode focusNode;
  final TextEditingController textEditingController;

  const PeepTodoInputItem(
      {super.key,
      required this.todoId,
      required this.color,
      required this.todoType,
      required this.focusNode,
      required this.textEditingController,
      required this.categoryId});

  @override
  Widget build(BuildContext context) {
    final ScheduledTodoController controller = Get.find();

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppValues.baseRadius),
      child: Container(
        width: AppValues.screenWidth - AppValues.screenPadding * 2,
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(AppValues.baseRadius),
          color: Palette.peepWhite,
        ),
        child: ConstrainedBox(
          constraints:
              BoxConstraints(minHeight: AppValues.baseItemHeight),
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: AppValues.innerMargin),
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
                        hintText: "할 일을 입력하세요.",
                        controller: textEditingController,
                        inputType: TextInputType.text,
                        autoFocus: true,
                        color: color,
                        func: (String value) {
                          controller.addNewTodoConfirm();
                        },
                        focusNode: focusNode,
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
                              onTap: () {
                                controller.addNewTodoConfirm();
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppValues.innerMargin),
                                child: PeepIcon(
                                  Iconsax.edit,
                                  size: AppValues.baseIconSize,
                                  color: color,
                                ),
                              ),
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
