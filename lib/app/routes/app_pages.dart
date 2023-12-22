import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/bindings/page/category_detail_binding.dart';
import 'package:peep_todo_flutter/app/bindings/page/overdue_todo_binding.dart';
import 'package:peep_todo_flutter/app/bindings/page/search_item_binding.dart';
import 'package:peep_todo_flutter/app/bindings/page/todo_detail_binding.dart';
import 'package:peep_todo_flutter/app/bindings/page/todo_memo_binding.dart';
import 'package:peep_todo_flutter/app/views/category/page/category_detail_page.dart';
import 'package:peep_todo_flutter/app/views/test.dart';
import 'package:peep_todo_flutter/app/views/category/page/category_manage_page.dart';
import 'package:peep_todo_flutter/app/views/todo/page/todo_detail_page.dart';
import 'package:peep_todo_flutter/app/views/todo/page/todo_memo_page.dart';
import 'package:peep_todo_flutter/app/views/todo/page/todo_serach_page.dart';

import '../bindings/main/main_binding.dart';
import '../bindings/page/category_add_binding.dart';
import '../views/category/page/category_add_page.dart';
import '../views/main/page/main_page.dart';

part './app_routes.dart';

class AppPages {
  AppPages._();

  static const TEST = Routes.TEST_PAGE;
  static const INITIAL = Routes.MAIN;
  static const CATEGORY_MANAGE = Routes.CATEGORY_MANAGE_PAGE;
  static const CATEGORY_DETAIL = Routes.CATEGORY_DETAIL_PAGE;
  static const CATEGORY_ADD = Routes.CATEGORY_ADD_PAGE;
  static const TODODETAIL = Routes.TODO_DETAIL_PAGE;
  static const TODOMEMO = Routes.TODO_MEMO_PAGE;
  static const SEARCH = Routes.TODO_SEARCH_PAGE;

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
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.CATEGORY_DETAIL_PAGE,
      page: () => CategoryDetailPage(),
      binding: CategoryDetailBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.CATEGORY_ADD_PAGE,
      page: () => CategoryAddPage(),
      binding: CategoryAddBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.TODO_DETAIL_PAGE,
      page: () => TodoDetailPage(),
      binding: TodoDetailBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.TODO_MEMO_PAGE,
      page: () => TodoMemoPage(),
      binding: TodoMemoBinding(),
    ),
    GetPage(
      name: _Paths.TODO_SEARCH_PAGE,
      page:() => TodoSearchPage(),
      binding: SearchItemBinding(),
    ),
  ];
}
