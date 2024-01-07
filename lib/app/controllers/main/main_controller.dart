import 'dart:developer';

import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/data/pref_controller.dart';
import 'package:peep_todo_flutter/app/data/model/enum/menu_state.dart';

import '../../utils/peep_calendar_util.dart';
import '../data/todo_controller.dart';
import '/app/core/base/base_controller.dart';

class MainController extends BaseController with PrefController {
  final keySelectedFont = 'selectedFont';

  final selectedMenu = MenuState.TODO.obs;
  final TodoController _todoController = Get.find();
  late final RxInt pageIndex;

  // 기본 폰트
  late final RxString selectedFont;

  MainController() {
    pageIndex = calculatePageIndex(_todoController.selectedDate.value).obs;
    selectedFont = getString(keySelectedFont)?.obs ?? "Pretendard".obs;
  }

  MenuState get selectedMenuState => selectedMenu.value;

  onMenuSelected(MenuState menuState) async {
    selectedMenu(menuState);
  }
}