import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/data/model/menu/bottom_navigation_item.dart';
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
      () => BottomNavigationBar(
        key: bottomNavKey,
        items: navItems
            .map(
              (BottomNavigationItem navItem) => BottomNavigationBarItem(
                icon: PeepIcon(
                  navItem.iconName,
                  size: 24.w,
                  color:
                      navItems.indexOf(navItem) == navController.selectedIndex
                          ? selectedItemColor
                          : unselectedItemColor,
                ),
                label: "",
              ),
            )
            .toList(),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Palette.peepBackground,
        selectedItemColor: selectedItemColor,
        unselectedItemColor: unselectedItemColor,
        currentIndex: navController.selectedIndex,
        onTap: (index) {
          navController.updateSelectedIndex(index);
          onNewMenuSelected(navItems[index].menuState);
        },
      ),
    );
  }

  List<BottomNavigationItem> _getNavItems() {
    return [
      const BottomNavigationItem(
        iconName: Iconsax.todo,
        menuState: MenuState.TODO,
      ),
      const BottomNavigationItem(
        iconName: Iconsax.calendar,
        menuState: MenuState.CALENDAR,
      ),
      const BottomNavigationItem(
        iconName: Iconsax.routine,
        menuState: MenuState.ROUTINE,
      ),
      const BottomNavigationItem(
        iconName: Iconsax.profile,
        menuState: MenuState.MYPAGE,
      ),
    ];
  }
}
