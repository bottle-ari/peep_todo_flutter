part of './app_pages.dart';

abstract class Routes {
  Routes._();

  static const TEST_PAGE = _Paths.TEST_PAGE;
  static const MAIN = _Paths.MAIN;
  static const CATEGORY_MANAGE_PAGE = _Paths.CATEGORY_MANAGE_PAGE;
  static const CATEGORY_DETAIL_PAGE = _Paths.CATEGORY_DETAIL_PAGE;
  static const CATEGORY_ADD_PAGE = _Paths.CATEGORY_ADD_PAGE;
  static const OVERDUE_TODO_PAGE = _Paths.OVERDUE_TODO_PAGE;
  static const TODO_DETAIL_PAGE = _Paths.TODO_DETAIL_PAGE;
  static const TODO_MEMO_PAGE = _Paths.TODO_MEMO_PAGE;
  static const ROUTINE_MANAGE_PAGE = _Paths.ROUTINE_MANAGE_PAGE;
  static const ROUTINE_ADD_PAGE = _Paths.ROUTINE_ADD_PAGE;
  static const ROUTINE_DETAIL_PAGE = _Paths.ROUTINE_DETAIL_PAGE;
  static const TODO_SEARCH_PAGE = _Paths.TODO_SEARCH_PAGE;
  static const MY_PAGE = _Paths.MY_PAGE;
  static const FONT_PAGE = _Paths.FONT_PAGE;
  static const DIARY_EDIT_PAGE = _Paths.DIARY_EDIT_PAGE;
  static const FEEDBACK_PAGE = _Paths.FEEDBACK_PAGE;
}

abstract class _Paths {
  static const TEST_PAGE = '/test';
  static const MAIN = '/main';
  static const CATEGORY_MANAGE_PAGE = '/category/manage';
  static const CATEGORY_DETAIL_PAGE = '/category/detail';
  static const CATEGORY_ADD_PAGE = '/category/add';
  static const OVERDUE_TODO_PAGE = '/todo/overdue';
  static const TODO_DETAIL_PAGE = '/todo/detail';
  static const TODO_MEMO_PAGE = '/todo/memo';
  static const ROUTINE_MANAGE_PAGE = '/routine/manage';
  static const ROUTINE_ADD_PAGE = '/routine/add';
  static const ROUTINE_DETAIL_PAGE = '/routine/detail';
  static const TODO_SEARCH_PAGE = '/todo/search';
  static const MY_PAGE = '/mypage';
  static const FONT_PAGE = '/mypage/font';
  static const DIARY_EDIT_PAGE = '/diary/edit';
  static const FEEDBACK_PAGE = '/mypage/feedback';

}