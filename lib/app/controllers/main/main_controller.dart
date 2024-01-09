import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/data/pref_controller.dart';
import 'package:peep_todo_flutter/app/data/model/enum/menu_state.dart';
import '/app/core/base/base_controller.dart';

class MainController extends BaseController with PrefController {
  final keySelectedFont = 'selectedFont';

  final selectedMenu = MenuState.TODO.obs;

  // 기본 폰트
  late final RxString selectedFont;

  MainController() {
    selectedFont = getString(keySelectedFont)?.obs ?? "Pretendard".obs;
  }

  MenuState get selectedMenuState => selectedMenu.value;

  onMenuSelected(MenuState menuState) async {
    selectedMenu(menuState);
  }
}