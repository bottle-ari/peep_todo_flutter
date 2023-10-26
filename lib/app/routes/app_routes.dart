part of './app_pages.dart';

abstract class Routes {
  Routes._();

  static const TEST_PAGE = _Paths.TEST_PAGE;
  static const MAIN = _Paths.MAIN;
}

abstract class _Paths {
  static const TEST_PAGE = '/test';
  static const MAIN = '/main';
}