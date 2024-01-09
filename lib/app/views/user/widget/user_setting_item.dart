import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/routes/app_pages.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_animation_effect.dart';

class UserSettingItem extends StatelessWidget {
  final Map<String, List<String>> itemList;
  final Map<String, List<String>> itemSubList;

  const UserSettingItem({
    Key? key,
    required this.itemList,
    required this.itemSubList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemList.length,
      itemBuilder: (context, index) {
        final group = itemList.entries.elementAt(index);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(AppValues.verticalMargin),
              child: Text(
                group.key,
                style: PeepTextStyle.boldL(color: Palette.peepGray500),
              ),
            ),
            Column(
              children: group.value.asMap().entries.map((entry) {
                int itemIndex = entry.key;
                String item = entry.value;
                String subItem = "";

                if (itemSubList[group.key] != null &&
                    itemSubList[group.key]!.isNotEmpty) {
                  subItem = itemSubList[group.key]![itemIndex];
                }
                //'일반': ['주 시작 설정'], //, '언어 설정'
                //'테마': ['메인 색상 변경', '폰트 설정'],
                ////'보안': ['앱 잠금'],
                //'기타': ['유저 가이드', '개인정보 보호 정책', '오픈소스 사용 정보'],
                return PeepAnimationEffect(
                  scale: 0.95,
                  onTap: () {
                    if (item == "주 시작 설정") {
                      Get.toNamed(AppPages.CALENDARSETTINGPAGE);
                      log("주 시작 설정");
                    } else if (item == "팔레트 테마 변경") {
                      Get.toNamed(AppPages.PALETTE_SETTING_PAGE);
                    } else if (item == "폰트 설정") {
                      Get.toNamed(AppPages.FONTPAGE);
                    } else if (item == "유저 가이드") {
                      log("유저 가이드");
                    } else if (item == "개인정보 보호 정책") {
                      log("개인정보 보호 정책");
                    } else if (item == "오픈소스 사용 정보") {
                      log("오픈소스 사용 정보");
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(0.5 * AppValues.horizontalMargin),
                    child: Container(
                      width:
                          AppValues.screenWidth - AppValues.screenPadding * 2,
                      height: AppValues.largeItemHeight,
                      decoration: BoxDecoration(
                        color: Palette.peepGray50,
                        borderRadius:
                            BorderRadius.circular(AppValues.baseRadius),
                        border: Border.all(color: Palette.peepGray100),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppValues.screenPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item,
                                    style: PeepTextStyle.regularM(
                                        color: Palette.peepBlack),
                                  ),
                                  if (subItem.isNotEmpty)
                                    Text(
                                      subItem,
                                      style: PeepTextStyle.regularXS(
                                          color: Palette.peepGray400),
                                    ),
                                ],
                              ),
                            ),
                            PeepIcon(
                              Iconsax.arrowright,
                              size: AppValues.smallIconSize,
                              color: Palette.peepGray500,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
