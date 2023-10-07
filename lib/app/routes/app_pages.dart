import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/views/test.dart';

class AppPages {
  static const INITIAL = '/home';
  static const TEST = '/test';

  static final routes = [
    // GetPage(
    //   name: '/home',
    //   page: () => HomePage(),
    //   binding: HomeBinding(),
    // ),
    GetPage(
      name: '/test',
      page: () => const Test(),
    ),
  ];
}
