import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/my_page_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_view.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_animation_effect.dart';
import 'package:peep_todo_flutter/app/views/common/peep_subpage_appbar.dart';

class FeedbackPage extends BaseView<MyPageController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(AppValues.appbarHeight),
        child: SafeArea(
          child: PeepSubpageAppbar(
            title: '피드백 작성',
            onTapBackArrow: () {
              Get.back();
            },
            buttons: [
              PeepAnimationEffect(
                onTap: () {
                  controller.sendFeedbackText();
                  controller.initFeedbackText();
                },
                child: PeepIcon(
                  Iconsax.export,
                  size: AppValues.baseIconSize,
                  color: Palette.peepBlack,
                ),
              ),
            ],
          ),
        ));
  }

  @override
  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 300.w,
        height: double.infinity,
        child: TextField(
          controller: controller.textEditingController,
          style: PeepTextStyle.regularM(color: Palette.peepBlack),
          decoration: InputDecoration(
            border: InputBorder.none, // 밑줄 제거
            hintText: '피드백을 작성해 주세요',
            hintStyle:
            PeepTextStyle.regularS(color: Palette.peepGray300),
          ),
          maxLines: null,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          onEditingComplete: () {
            // Handle the Enter key pressed
          },
        ),
      ),
    );
  }
}
