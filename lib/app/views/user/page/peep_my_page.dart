import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/my_page_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_view.dart';
import 'package:peep_todo_flutter/app/routes/app_pages.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_animation_effect.dart';
import 'package:peep_todo_flutter/app/views/common/peep_subpage_appbar.dart';
import 'package:peep_todo_flutter/app/views/user/widget/user_setting_item.dart';
import 'package:url_launcher/url_launcher.dart';

class PeepMyPage extends BaseView<MyPageController> {
  final Map<String, List<String>> myItemList = {
    '일반': ['주 시작 설정'], //, '언어 설정'
    '테마': ['팔레트 테마 변경', '폰트 설정'],
    //'보안': ['앱 잠금'],
    //'기타': ['유저 가이드', '개인정보 보호 정책', '오픈소스 사용 정보'],
    '기타': ['오픈소스 사용 정보'],
  };

  final Map<String, List<String>> myItemSubList = {
    '일반': ['달력의 시작 요일을 지정합니다', '앱 내에서 사용할 언어를 설정합니다'],
    '테마': ['테마 색상과 팔레트 테마를 변경합니다', '앱 내 글자 폰트를 변경합니다'],
    '보안': ['비밀번호를 설정합니다'],
  };

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(AppValues.appbarHeight),
        child: SafeArea(
          child: PeepSubpageAppbar(
              title: '마이페이지',
              onTapBackArrow: () {
                Get.back();
              }),
        ));
  }

  @override
  Widget body(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
        child: Column(
          children: [
            Obx(
              () => PeepAnimationEffect(
                scale: 0.95,
                onTap: () {
                  Get.toNamed(AppPages.FEEDBACKPAGE);
                },
                child: Container(
                  width: AppValues.screenWidth - AppValues.screenPadding * 2,
                  height: AppValues.largeItemHeight,
                  decoration: BoxDecoration(
                    color: controller
                        .getPrimaryColor()
                        .withOpacity(AppValues.quarterOpacity),
                    borderRadius: BorderRadius.circular(AppValues.baseRadius),
                    border: Border.all(color: controller.getPrimaryColor()),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppValues.screenPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "피드백 및 버그 리포트",
                          style: PeepTextStyle.boldM(color: Palette.peepBlack),
                        ),
                        PeepIcon(Iconsax.arrowright,
                            size: AppValues.smallIconSize,
                            color: Palette.peepBlack),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                child: UserSettingItem(
              itemList: myItemList,
              itemSubList: myItemSubList,
            )),
            SizedBox(
              height: 60.h,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    final Uri _url = Uri.parse(
        'https://docs.google.com/forms/d/e/1FAIpQLSf4yvBJFGaCvG_0ArMt-qAmNs8LI6bMpfTf_O1yea9pTLXWCQ/viewform?usp=sf_link');

    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
