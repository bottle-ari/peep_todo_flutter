import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/data/model/enum/menu_state.dart';

import '/app/core/base/base_controller.dart';

class MainController extends BaseController {
  final _selectedMenuStateController = MenuState.TODO.obs;

  MenuState get selectedMenuState => _selectedMenuStateController.value;

  onMenuSelected(MenuState menuState) async {
    _selectedMenuStateController(menuState);
  }
}