import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/main/main_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_view.dart';
import 'package:peep_todo_flutter/app/routes/app_pages.dart';
import 'package:peep_todo_flutter/app/views/calendar/page/calendar_page.dart';
import 'package:peep_todo_flutter/app/views/main/widget/peep_calendar_app_bar.dart';
import 'package:peep_todo_flutter/app/views/main/widget/peep_constant_todo_appbar.dart';
import 'package:peep_todo_flutter/app/views/todo/page/constant_todo_page.dart';
import 'package:peep_todo_flutter/app/views/todo/page/scheduled_todo_page.dart';

import '../../../data/model/enum/menu_state.dart';
import '../../../theme/app_values.dart';
import '../widget/peep_bottom_navigation_bar.dart';
import '../widget/peep_scheduled_todo_app_bar.dart';

class MainPage extends BaseView<MainController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(AppValues.appbarHeight),
        child: SafeArea(
          child: Obx(() => getAppbarOnSelectedMenu(controller.selectedMenuState)),
        ));
  }

  @override
  Widget body(BuildContext context) {
    return Container(
      key: UniqueKey(),
      child: Obx(() => getPageOnSelectedMenu(controller.selectedMenuState)),
    );
  }

  @override
  Widget? bottomNavigationBar() {
    return PeepBottomNavigationBar(
      onNewMenuSelected: controller.onMenuSelected,
    );
  }

  Widget getAppbarOnSelectedMenu(MenuState menuState) {
    switch (menuState) {
      case MenuState.TODO:
        return PeepScheduledTodoAppBar();
      case MenuState.CONSTANT_TODO:
        return PeepConstantTodoAppbar(
            dropdownMenuItems: [],
            onMenuItemSelected: (String str) {},
            onTapClipboard: () {
              Get.toNamed(AppPages.COMPLETED_CONSTANT_TODO);
            });
      case MenuState.CALENDAR:
        return PeepCalendarAppBar();
      case MenuState.ROUTINE:
        return PeepConstantTodoAppbar(
            dropdownMenuItems: [],
            onMenuItemSelected: (String str) {},
            onTapClipboard: () {});
      case MenuState.MYPAGE:
        return PeepConstantTodoAppbar(
            dropdownMenuItems: [],
            onMenuItemSelected: (String str) {},
            onTapClipboard: () {});
      default:
        // return LoginPage();
        return Container();
    }
  }

  Widget getPageOnSelectedMenu(MenuState menuState) {
    switch (menuState) {
      case MenuState.TODO:
        return ScheduledTodoPage();
      case MenuState.CONSTANT_TODO:
        return ConstantTodoPage();
      case MenuState.CALENDAR:
        return CalendarPage();
      case MenuState.ROUTINE:
        return Container();
      case MenuState.MYPAGE:
        return Container();
      default:
        // return LoginPage();
        return Container();
    }
  }
}
