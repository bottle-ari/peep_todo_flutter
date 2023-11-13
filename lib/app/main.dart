import 'package:flutter/material.dart';
import 'package:peep_todo_flutter/app/routes/app_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/theme/app_theme.dart';

import 'package:intl/date_symbol_data_local.dart';

import 'bindings/initial_binding.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(const MyApp()));
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (buildContext, widget) => GetMaterialApp(
        title: '삐약Todo',
        debugShowCheckedModeBanner: false,
        theme: appThemeData,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        initialBinding: InitialBinding(),
        defaultTransition: Transition.fade,
        scrollBehavior: PeepScrollBehavior(),
      ),
    );
  }
}
