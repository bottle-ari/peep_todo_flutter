import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/data/category_controller.dart';
import 'package:peep_todo_flutter/app/controllers/main/main_controller.dart';
import 'package:peep_todo_flutter/app/routes/app_pages.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_animation_effect.dart';
import 'package:peep_todo_flutter/app/views/common/peep_dropdown_menu.dart';
import 'package:peep_todo_flutter/app/views/main/widget/peep_main_toggle_button.dart';
import 'package:peep_todo_flutter/app/views/main/widget/peep_profile_button.dart';
import '../../../data/model/enum/menu_state.dart';
import '../../../theme/app_values.dart';
import '../../../theme/icons.dart';
import '../../../theme/palette.dart';

class PeepDiaryAppBar extends StatelessWidget {
  final MainController controller;
  final CategoryController categoryController = Get.find();

  PeepDiaryAppBar({super.key, required this.controller});

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
                // Row(
                //   children: [
                //     PeepAnimationEffect(
                //       onTap: () {},
                //       child: PeepIcon(
                //         Iconsax.calendarSearch,
                //         size: AppValues.baseIconSize,
                //         color: Palette.peepGray500,
                //       ),
                //     ),
                //     PeepDropdownMenu(
                //       menuItems: [
                //         DropdownMenuItemData(
                //             'popup_action_1',
                //             PeepIcon(Iconsax.categoryboxAdd,
                //                 size: AppValues.smallIconSize,
                //                 color: Palette.peepBlack),
                //             '다이어리 어쩌구 추가'),
                //         DropdownMenuItemData(
                //             'popup_action_2',
                //             PeepIcon(Iconsax.categorybox,
                //                 size: AppValues.smallIconSize,
                //                 color: Palette.peepBlack),
                //             '다이어리 관리'),
                //       ],
                //       onMenuItemSelected: {
                //         'popup_action_1': () {
                //           debugPrint('1');
                //         },
                //         'popup_action_2': () {
                //           debugPrint('2');
                //         },
                //       },
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
