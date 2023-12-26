import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/todo_memo_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_view.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_animation_effect.dart';
import 'package:peep_todo_flutter/app/views/common/peep_subpage_appbar.dart';

import '../../../theme/palette.dart';
import '../../../utils/custom_color_selection_handle.dart';

class TodoMemoPage extends BaseView<TodoMemoController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(AppValues.appbarHeight),
        child: SafeArea(
          child: PeepSubpageAppbar(
              title: '메모',
              buttons: [
                PeepAnimationEffect(
                    onTap: () => controller.clearText(),
                    child: PeepIcon(
                      Iconsax.trash,
                      color: Palette.peepRed,
                      size: AppValues.baseIconSize,
                    )),
              ],
              onTapBackArrow: () {
                Get.back();
              }),
        ));
  }

  @override
  Widget body(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Palette.peepWhite,
          border: Border.all(color: Palette.peepGray200),
          borderRadius:
          BorderRadius.circular(AppValues.baseRadius),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppValues.screenPadding,
                vertical: AppValues.verticalMargin),
            child: Theme(
              data: ThemeData.light().copyWith(
                textSelectionTheme: TextSelectionThemeData(
                  cursorColor: controller.color, // works on iOS
                  selectionColor: controller.color
                      .withOpacity(AppValues.halfOpacity), // works on iOS
                  selectionHandleColor:
                      controller.color, // not working on iOS
                ),
                cupertinoOverrideTheme: CupertinoThemeData(
                  primaryColor: controller
                      .color, // alternative on iOS for "selectionHandleColor"
                ),
              ),
              child: TextField(
                controller: controller.textEditingController,
                focusNode: controller.focusNode,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                autofocus: true,
                selectionControls:
                    CustomColorSelectionHandle(controller.color),
                decoration: InputDecoration(
                  hintText: controller.oldText,
                  hintStyle: const TextStyle(color: Palette.peepGray300),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
