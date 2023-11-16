import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/bindings/page/category_manage_page_binding.dart';
import 'package:peep_todo_flutter/app/bindings/page/completed_constant_todo_binding.dart';
import 'package:peep_todo_flutter/app/bindings/page/overdue_todo_binding.dart';
import 'package:peep_todo_flutter/app/views/test.dart';
import 'package:peep_todo_flutter/app/views/category/page/category_manage_page.dart';
import 'package:peep_todo_flutter/app/views/todo/page/completed_constant_todo_page.dart';
import 'package:peep_todo_flutter/app/views/todo/page/overdue_todo_page.dart';

import '../bindings/main_binding.dart';
import '../views/main/page/main_page.dart';

part './app_routes.dart';

class AppPages {
  AppPages._();

  static const TEST = Routes.TEST_PAGE;
  static const INITIAL = Routes.MAIN;
  static const OVERDUETODO = Routes.OVERDUE_TODO_PAGE;
  static const COMPLETED_CONSTANT_TODO = Routes.COMPLETED_CONSTANT_TODO_PAGE;

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
    GetPage(
      name: _Paths.OVERDUE_TODO_PAGE,
      page: () => OverdueTodoPage(),
      binding: OverdueTodoBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.COMPLETED_CONSTANT_TODO_PAGE,
      page: () => CompletedConstantTodoPage(),
      binding: CompletedConstantTodoBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}
