import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/my_page_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_view.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_animation_effect.dart';
import 'package:peep_todo_flutter/app/views/common/peep_subpage_appbar.dart';

import '../../../theme/icons.dart';
import '../../../theme/palette.dart';

class FontSetting extends BaseView<MyPageController> {
  // 사용 가능한 폰트 리스트
  static const List<String> availableFonts = [
    'Pretendard',
    'LeeSeoyun',
    'KoPub',
    'NanumMyeongjo'
  ];

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(AppValues.appbarHeight),
        child: SafeArea(
          child: PeepSubpageAppbar(
              title: '폰트 설정',
              onTapBackArrow: () {
                Get.back();
              }),
        ));
  }

  @override
  Widget body(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (var font in availableFonts)
            PeepAnimationEffect(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppValues.screenPadding,
                    vertical: AppValues.innerMargin),
                child: Container(
                    width: AppValues.screenWidth - AppValues.screenPadding * 2,
                    height: AppValues.largeItemHeight,
                    decoration: BoxDecoration(
                      color: Palette.peepGray50,
                      borderRadius: BorderRadius.circular(AppValues.baseRadius),
                      border: Border.all(color: Palette.peepGray100),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppValues.screenPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(font,
                              style: PeepTextStyle.regularM()
                                  .copyWith(fontFamily: font)),
                          if (font == controller.mainController.selectedFont.value)
                            Expanded(
                                child: Align(
                              alignment: Alignment.centerRight,
                              child: PeepIcon(
                                Iconsax.checkBold,
                                size: AppValues.baseIconSize,
                                color: Palette.peepGray500,
                              ),
                            ))
                        ],
                      ),
                    )),
              ),
              onTap: () {
                controller.setSelectedFont(font);
              },
            )
        ],
      ),
    );
  }
}
