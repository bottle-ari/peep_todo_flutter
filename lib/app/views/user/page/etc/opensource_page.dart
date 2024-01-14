import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/preferred_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/animation/peep_animation_effect_controller.dart';
import 'package:peep_todo_flutter/app/controllers/page/opensource_page_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_view.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_animation_effect.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../theme/app_values.dart';
import '../../../../theme/palette.dart';
import '../../../common/peep_subpage_appbar.dart';

class OpenSourcePage extends BaseView<OpenSourcePageController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(AppValues.appbarHeight),
        child: SafeArea(
          child: PeepSubpageAppbar(
              title: '오픈소스 사용정보',
              onTapBackArrow: () {
                Get.back();
              }),
        ));
  }

  @override
  Widget body(BuildContext context) {
    return SizedBox(
      width: AppValues.screenWidth,
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (var item in opensourceList)
              Padding(
                padding: EdgeInsets.symmetric(vertical: AppValues.innerMargin),
                child: _OpenSource(
                  name: item.split(':')[0] + item.split(':')[1],
                  url: getUrl(item),
                  type: item.split(':')[2],
                  typeUrl: getLicenseUrl(item),
                ),
              ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppValues.innerMargin),
              child: const _OpenSource(
                  name: 'Iconsax',
                  url: 'https://iconsax.io/',
                  type: 'License',
                  typeUrl: 'https://iconsax.io/#license'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppValues.innerMargin),
              child: const _OpenSource(
                  name: 'pretendard',
                  url: 'https://cactus.tistory.com/306',
                  type: 'SIL OPEN FONT LICENSE Version 1.1',
                  typeUrl:
                      'https://github.com/orioncactus/pretendard/blob/main/LICENSE'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppValues.innerMargin),
              child: const _OpenSource(
                  name: '네이버 나눔글꼴',
                  url: 'https://hangeul.naver.com/font',
                  type: 'SIL OPEN FONT LICENSE Version 1.1',
                  typeUrl:
                  'https://help.naver.com/service/30016/contents/18088?osType=PC&lang=ko'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppValues.innerMargin),
              child: const _OpenSource(
                  name: 'LeeSeoyun',
                  url: 'https://github.com/webfontworld/heungkuk/blob/main/README.md',
                  type: 'SIL OPEN FONT LICENSE Version 1.1',
                  typeUrl:
                  'https://github.com/webfontworld/heungkuk/blob/main/README.md'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppValues.innerMargin),
              child: const _OpenSource(
                  name: 'KoPub',
                  url: 'https://www.kopus.org/biz-electronic-font2/',
                  type: 'SIL OPEN FONT LICENSE Version 1.1',
                  typeUrl:
                  'https://www.kopus.org/biz-electronic-font2/'),
            ),
            SizedBox(
              height: 60.h,
            ),
          ],
        ),
      ),
    );
  }
}

List<String> opensourceList = [
  'cupertino_icons: ^1.0.2:MIT',
  'get: ^4.6.6:MIT',
  'intl: ^0.18.1:BSD-3-Clause',
  'http: ^1.1.2:BSD-3-Clause',
  'loading_animation_widget: ^1.2.0+4:BSD-3-Clause',
  'shared_preferences: ^2.2.0:BSD-3-Clause',
  'flutter_screenutil: ^5.8.4:Apache-2.0',
  'flutter_svg: ^2.0.7:MIT',
  'reorderables: ^0.6.0:MIT',
  'table_calendar: ^3.0.9:Apache-2.0',
  'sqflite: ^2.3.0:BSD-2-Clause',
  'path: ^1.8.3:BSD-3-Clause',
  'uuid: ^4.2.1:MIT',
  'flutter_slidable: ^3.0.1:MIT',
  'emoji_picker_flutter: ^1.6.3:BSD-2-Clause',
  'image_picker: ^1.0.5:Apache-2.0, BSD-3-Clause',
  'path_provider: ^2.1.1:BSD-3-Clause',
  'permission_handler: ^11.1.0:MIT',
  'scroll_date_picker: ^3.7.3:BSD-3-Clause',
  'numberpicker: ^2.1.2:BSD-2-Clause',
  'url_launcher: ^6.2.2:BSD-3-Clause',
  'flutter_keyboard_visibility: ^6.0.0:MIT',
  'device_info_plus: ^9.1.1:BSD-3-Clause',
  'super_clipboard: ^0.8.1:MIT',
  'flutter_quill: ^9.2.2:MIT',
  'carousel_slider: ^4.2.1:MIT',
];

String getUrl(String name) {
  return "https://pub.dev/packages/${name.split(':')[0]}";
}

String getLicenseUrl(String name) {
  return "https://pub.dev/packages/${name.split(':')[0]}/license";
}

class _OpenSource extends StatelessWidget {
  final String name;
  final String url;
  final String type;
  final String typeUrl;

  const _OpenSource(
      {required this.name,
      required this.url,
      required this.type,
      required this.typeUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppValues.screenWidth - (AppValues.screenPadding * 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppValues.baseRadius),
        border: Border.all(color: Palette.peepGray300),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppValues.screenPadding,
            vertical: AppValues.verticalMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PeepAnimationEffect(
              onTap: () {
                _launchUrl(url);
              },
              child: Text(
                name,
                style: PeepTextStyle.boldM(color: Palette.peepBlue).copyWith(
                    decoration: TextDecoration.underline,
                    decorationColor: Palette.peepBlue),
              ),
            ),
            PeepAnimationEffect(
              onTap: () {
                _launchUrl(typeUrl);
              },
              child: Text(
                type,
                style: PeepTextStyle.regularS(color: Palette.peepGray400),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<void> _launchUrl(String url) async {
  final Uri _url = Uri.parse(url);

  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
