import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/bindings/page/category_manage_page_binding.dart';
import 'package:peep_todo_flutter/app/views/test.dart';
import 'package:peep_todo_flutter/app/views/category/page/category_manage_page.dart';

import '../bindings/main_binding.dart';
import '../views/main/page/main_page.dart';

part './app_routes.dart';

class AppPages {
  AppPages._();

  static const TEST = Routes.TEST_PAGE;
  static const INITIAL = Routes.MAIN;

  static final routes = [
    GetPage(
      name: _Paths.MAIN,
      page: () => MainPage(),
      binding: MainBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.TEST_PAGE,
      page: () => Test(),
    ),
    GetPage(
      name: _Paths.CATEGORY_MANAGE_PAGE,
      page: () => CategoryManagePage(),
      binding: CategoryManagePageBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}
