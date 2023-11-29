import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/data/model/menu/bottom_navigation_item.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/utils/device_util.dart';

import '../../../controllers/main/bottom_navigation_controller.dart';
import '../../../data/model/enum/menu_state.dart';

class PeepBottomNavigationBar extends StatelessWidget {
  final Function(MenuState menuState) onNewMenuSelected;

  PeepBottomNavigationBar({Key? key, required this.onNewMenuSelected})
      : super(key: key);

  final BottomNavigationController navController = Get.find();
  final Key bottomNavKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Color selectedItemColor = Palette.peepYellow400;
    Color unselectedItemColor = Palette.peepGray300;
    List<BottomNavigationItem> navItems = _getNavItems();

    return Obx(
      () => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
          border: Border(
            top: BorderSide(
              color: Palette.peepGray200, // 왼쪽 상단 모서리 테두리 색상
              width: 1.5.w, // 테두리 두께
            ),
            left: BorderSide(
              color: Palette.peepGray200, // 왼쪽 상단 모서리 테두리 색상
              width: 1.5.w, // 테두리 두께
            ),
            right: BorderSide(
              color: Palette.peepGray200, // 왼쪽 상단 모서리 테두리 색상
              width: 1.5.w, // 테두리 두께
            ),
          )
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
          child: BottomNavigationBar(
            key: bottomNavKey,
            items: navItems
                .map(
                  (BottomNavigationItem navItem) => BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(
                        left: navItem.menuState == MenuState.TODO
                            ? 20.w
                            : (navItem.menuState == MenuState.CONSTANT_TODO
                                ? 10.w
                                : 0),
                        right: navItem.menuState == MenuState.MYPAGE
                            ? 20.w
                            : (navItem.menuState == MenuState.ROUTINE
                                ? 10.w
                                : 0),
                      ),
                      child: Column(
                        children: [
                          PeepIcon(
                            navItem.iconName,
                            size: 28.w,
                            color: navItems.indexOf(navItem) ==
                                    navController.selectedIndex
                                ? selectedItemColor
                                : unselectedItemColor,
                          ),
                          Text(
                            navItem.label,
                            style: navItems.indexOf(navItem) ==
                                    navController.selectedIndex
                                ? PeepTextStyle.boldXS(
                                    color: Palette.peepYellow400)
                                : PeepTextStyle.regularXS(
                                    color: Palette.peepGray400),
                          )
                        ],
                      ),
                    ),
                    label: '',
                  ),
                )
                .toList(),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedFontSize: 10.sp,
            unselectedFontSize: 10.sp,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Palette.peepWhite,
            selectedItemColor: selectedItemColor,
            unselectedItemColor: unselectedItemColor,
            currentIndex: navController.selectedIndex,
            onTap: (index) {
              navController.updateSelectedIndex(index);
              onNewMenuSelected(navItems[index].menuState);
            },
          ),
        ),
      ),
    );
  }

  List<BottomNavigationItem> _getNavItems() {
    return [
      const BottomNavigationItem(
          iconName: Iconsax.todo, menuState: MenuState.TODO, label: "할일"),
      const BottomNavigationItem(
          iconName: Iconsax.constantTodo,
          menuState: MenuState.CONSTANT_TODO,
          label: "상시"),
      const BottomNavigationItem(
          iconName: Iconsax.calendar,
          menuState: MenuState.CALENDAR,
          label: "캘린더"),
      const BottomNavigationItem(
          iconName: Iconsax.routine, menuState: MenuState.ROUTINE, label: "루틴"),
      const BottomNavigationItem(
          iconName: Iconsax.profile, menuState: MenuState.MYPAGE, label: "계정"),
    ];
  }
}
