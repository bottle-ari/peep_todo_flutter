import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/main/main_controller.dart';
import 'package:peep_todo_flutter/app/routes/app_pages.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_animation_effect.dart';
import 'package:peep_todo_flutter/app/views/common/peep_dropdown_menu.dart';
import 'package:peep_todo_flutter/app/views/main/page/MapScreen.dart';
import 'package:peep_todo_flutter/app/views/main/widget/peep_main_toggle_button.dart';
import 'package:peep_todo_flutter/app/views/main/widget/peep_profile_button.dart';
import '../../../data/model/enum/menu_state.dart';
import '../../../theme/app_values.dart';
import '../../../theme/icons.dart';
import '../../../theme/palette.dart';
import '../page/test_page.dart';

class PeepTodoAppBar extends StatelessWidget {
  final MainController controller;

  const PeepTodoAppBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppValues.screenWidth,
      height: 64.h,
      padding: EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
      // 옆의 여백 조절
      child: Stack(
        children: [
          Center(
            child: PeepMainToggleButton(onNewMenuSelected: (MenuState menu) {
              controller.onMenuSelected(menu);
            }),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PeepProfileButton(),
                Row(
                  children: [
                    PeepAnimationEffect(
                      onTap: () {},
                      child: PeepIcon(
                        Iconsax.calendarSearch,
                        size: AppValues.baseIconSize,
                        color: Palette.peepGray500,
                      ),
                    ),
                    PeepDropdownMenu(
                      menuItems: [
                        DropdownMenuItemData(
                            'popup_action_1',
                            PeepIcon(Iconsax.categoryboxAdd,
                                size: AppValues.smallIconSize,
                                color: Palette.peepBlack),
                            '카테고리 추가'),
                        DropdownMenuItemData(
                            'popup_action_2',
                            PeepIcon(Iconsax.categorybox,
                                size: AppValues.smallIconSize,
                                color: Palette.peepBlack),
                            '카테고리 관리'),
                        DropdownMenuItemData(
                            'popup_action_3',
                            PeepIcon(Iconsax.addSquareOutline,
                                size: AppValues.smallIconSize,
                                color: Palette.peepBlack),
                            '루틴 수동 추가'),
                        DropdownMenuItemData(
                            'popup_action_4',
                            PeepIcon(Iconsax.routineOutline,
                                size: AppValues.smallIconSize,
                                color: Palette.peepBlack),
                            '루틴 관리'),
                        DropdownMenuItemData(
                            'popup_action_5', // Todo 액션 수정
                            PeepIcon(Iconsax.emoji,
                                size: AppValues.smallIconSize,
                                color: Palette.peepBlack),
                            '리마인더 페이지'),
                        DropdownMenuItemData(
                            'popup_action_6', // Todo 액션 수정
                            PeepIcon(Iconsax.priority,
                                size: AppValues.smallIconSize,
                                color: Palette.peepBlack),
                            '구글맵 테스트'),
                      ],
                      onMenuItemSelected: {
                        'popup_action_1': () {
                          debugPrint('1');
                        },
                        'popup_action_2': () {
                          Get.toNamed(Routes.CATEGORY_MANAGE_PAGE);
                        },
                        'popup_action_3': () {
                          debugPrint('3');
                        },
                        'popup_action_4': () {
                          debugPrint('4');
                        },
                        'popup_action_5': () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TestPage()),
                          );
                          // todo : reminder 기능 추가
                          debugPrint('5');
                        },
                        'popup_action_6': () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MapScreen()),
                          );
                          debugPrint('6');
                        },
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
