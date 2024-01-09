import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/main/main_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_view.dart';
import 'package:peep_todo_flutter/app/views/diary/page/dairy_page.dart';
import 'package:peep_todo_flutter/app/views/todo/page/todo_page.dart';

import '../../../data/model/enum/menu_state.dart';
import '../../../theme/app_values.dart';
import '../widget/peep_diary_app_bar.dart';
import '../widget/peep_todo_app_bar.dart';

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

  Widget getAppbarOnSelectedMenu(MenuState menuState) {
    switch (menuState) {
      case MenuState.TODO:
        return PeepTodoAppBar(controller: controller,);
      case MenuState.DAIRY:
        return PeepDiaryAppBar(controller: controller,);
      default:
        // return LoginPage();
        return Container();
    }
  }

  Widget getPageOnSelectedMenu(MenuState menuState) {
    switch (menuState) {
      case MenuState.TODO:
        return TodoPage();
      case MenuState.DAIRY:
        return DiaryPage();
      default:
        // return LoginPage();
        return Container();
    }
  }
}
