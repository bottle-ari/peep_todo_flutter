part of './app_pages.dart';

abstract class Routes {
  Routes._();

  static const TEST_PAGE = _Paths.TEST_PAGE;
  static const MAIN = _Paths.MAIN;
  static const CATEGORY_MANAGE_PAGE = _Paths.CATEGORY_MANAGE_PAGE;
  static const OVERDUE_TODO_PAGE = _Paths.OVERDUE_TODO_PAGE;
}

abstract class _Paths {
  static const TEST_PAGE = '/test';
  static const MAIN = '/main';
  static const CATEGORY_MANAGE_PAGE = '/category/manage';
  static const OVERDUE_TODO_PAGE = '/todo/overdue';
}