import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/dairy_edit_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_view.dart';
import 'package:peep_todo_flutter/app/data/model/palette/palette_model.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';

import '../../../theme/app_values.dart';
import '../../../theme/icons.dart';
import '../../../theme/palette.dart';
import '../../../utils/custom_color_selection_handle.dart';
import '../../common/buttons/peep_animation_effect.dart';
import '../../common/peep_subpage_appbar.dart';

class DiaryEditPage extends BaseView<DiaryEditController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(AppValues.appbarHeight),
        child: SafeArea(
          child: PeepSubpageAppbar(
            title: '일기 작성',
            onTapBackArrow: () {
              Get.back();
            },
            buttons: [
              PeepAnimationEffect(
                onTap: () {
                  controller.clearText();
                },
                child: PeepIcon(
                  Iconsax.trash,
                  size: AppValues.baseIconSize,
                  color: Palette.peepRed,
                ),
              ),
            ],
          ),
        ));
  }

  @override
  Widget body(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppValues.screenPadding,
                  vertical: AppValues.verticalMargin),
              child: Theme(
                data: ThemeData.light().copyWith(
                  textSelectionTheme: TextSelectionThemeData(
                    cursorColor: defaultPalette.primaryColor.color,
                    // works on iOS
                    selectionColor: defaultPalette.primaryColor.color
                        .withOpacity(AppValues.halfOpacity),
                    // works on iOS
                    selectionHandleColor:
                        defaultPalette.primaryColor.color, // not working on iOS
                  ),
                  cupertinoOverrideTheme: CupertinoThemeData(
                    primaryColor: defaultPalette.primaryColor
                        .color, // alternative on iOS for "selectionHandleColor"
                  ),
                ),
                child: TextField(
                  expands: true,
                  maxLines: null,
                  controller: controller.textEditingController,
                  focusNode: controller.focusNode,
                  style: PeepTextStyle.regularM(color: Palette.peepBlack),
                  selectionControls: CustomColorSelectionHandle(
                      defaultPalette.primaryColor.color),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '${controller.date} 일기를 입력해주세요',
                    hintStyle:
                        PeepTextStyle.regularM(color: Palette.peepGray400),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
