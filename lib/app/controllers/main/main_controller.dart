import 'dart:developer';

import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/data/model/enum/menu_state.dart';

import '../../theme/palette.dart';
import '/app/core/base/base_controller.dart';

class MainController extends BaseController {
  final _selectedMenuStateController = MenuState.TODO.obs;

  MenuState get selectedMenuState => _selectedMenuStateController.value;

  onMenuSelected(MenuState menuState) async {
    _selectedMenuStateController(menuState);
    getColorOnSelectedMenu(menuState);
  }

  getColorOnSelectedMenu(MenuState menuState) {
    switch (menuState) {
      case MenuState.TODO:
        backgroundColor.value = Palette.peepBackground;
        break;
      case MenuState.CONSTANT_TODO:
        backgroundColor.value = Palette.peepBackground;
        break;
      case MenuState.CALENDAR:
        backgroundColor.value = Palette.peepWhite;
        break;
      case MenuState.ROUTINE:
        backgroundColor.value = Palette.peepBackground;
        break;
      case MenuState.MYPAGE:
        backgroundColor.value = Palette.peepWhite;
        break;
      default:
      // return LoginPage();
        backgroundColor.value = Palette.peepBackground;
        break;
    }

    log(backgroundColor.value.toString());

    update();
  }
}