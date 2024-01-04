import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/my_page_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_view.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/views/common/peep_subpage_appbar.dart';

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
    return ListView.builder(
      itemCount: availableFonts.length,
      itemBuilder: (context, index) {
        String font = availableFonts[index];
        return ListTile(
          title: Text(font, style: TextStyle(fontFamily: font)),
          onTap: () {
            log("font setting {$font}");
            controller.setSelectedFont(font);
          },
        );
      },
    );
  }
}
