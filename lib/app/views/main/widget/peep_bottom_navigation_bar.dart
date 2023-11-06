import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/data/model/menu/bottom_navigation_item.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';

import '../../../controllers/main/bottom_navigation_controller.dart';
import '../../../data/model/enum/menu_state.dart';

class PeepBottomNavigationBar extends StatelessWidget {
  final Function(MenuState menuState) onNewMenuSelected;

  PeepBottomNavigationBar({Key? key, required this.onNewMenuSelected})
      : super(key: key);

  final navController = BottomNavigationController();
  final Key bottomNavKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Color selectedItemColor = Palette.peepYellow400;
    Color unselectedItemColor = Palette.peepGray300;
    List<BottomNavigationItem> navItems = _getNavItems();

    return Obx(
      () => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppValues.baseRadius),
            boxShadow: [
              BoxShadow(
                  color: Palette.peepBlack.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 3))
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppValues.baseRadius),
            topRight: Radius.circular(AppValues.baseRadius),
          ),
          child: BottomNavigationBar(
            key: bottomNavKey,
            items: navItems
                .map(
                  (BottomNavigationItem navItem) => BottomNavigationBarItem(
                    icon: PeepIcon(
                      navItem.iconName,
                      size: 28.w,
                      color: navItems.indexOf(navItem) ==
                              navController.selectedIndex
                          ? selectedItemColor
                          : unselectedItemColor,
                    ),
                    label: navItem.label,
                  ),
                )
                .toList(),
            showSelectedLabels: true,
            showUnselectedLabels: false,
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
