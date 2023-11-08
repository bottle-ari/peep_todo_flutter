import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/main/main_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_view.dart';
import 'package:peep_todo_flutter/app/views/main/widget/peep_constant_todo_appbar.dart';
import 'package:peep_todo_flutter/app/views/todo/page/scheduled_todo_page.dart';

import '../../../data/model/enum/menu_state.dart';
import '../../../theme/app_values.dart';
import '../widget/peep_bottom_navigation_bar.dart';

class MainPage extends BaseView<MainController> {
  // 앱바 구현하기
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(AppValues.appbarHeight),
        child: SafeArea(
          child: PeepConstantTodoAppbar(
              dropdownMenuItems: [],
              onMenuItemSelected: (String str) {},
              onTapClipboard: () {}),
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

  Widget getPageOnSelectedMenu(MenuState menuState) {
    switch (menuState) {
      case MenuState.TODO:
        return ScheduledTodoPage();
      case MenuState.CALENDAR:
        return Container();
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
