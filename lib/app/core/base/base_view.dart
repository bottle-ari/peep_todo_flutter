import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/core/base/base_controller.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';

import '../../views/common/base/loading.dart';
import '../../data/model/enum/page_state.dart';

abstract class BaseView<Controller extends BaseController>
    extends GetView<Controller> {
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  Widget body(BuildContext context);

  PreferredSizeWidget? appBar(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          annotatedRegion(context),
          Obx(() => controller.pageState == PageState.LOADING
              ? _showLoading()
              : Container()),
          Container(),
        ],
      ),
    );
  }

  //statusBar부분
  Widget annotatedRegion(BuildContext context) {
    return AnnotatedRegion(
        value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark),
        child: Material(
          color: Colors.transparent,
          child: pageScaffold(context),
        ));
  }

  bool? resizeToAvoidBottomInset;

  //scaffold부분
  Widget pageScaffold(BuildContext context) {
    return Obx(
      ()=> Scaffold(
        //sets ios status bar color
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        backgroundColor: controller.backgroundColor.value,
        key: globalKey,
        appBar: appBar(context),
        floatingActionButton: floatingActionButton(),
        body: pageContent(context),
        bottomNavigationBar: bottomNavigationBar(),
        bottomSheet: bottomSheet(),
        drawer: drawer(),
      ),
    );
  }

  Widget pageContent(BuildContext context) {
    return SafeArea(
      child: body(context),
    );
  }

  //배경색 지정
  Color pageBackgroundColor() {
    return Palette.peepBackground;
  }

  //statusBar 색 지정
  Color statusBarColor() {
    return Palette.peepBackground;
  }

  //플로팅 액션바
  Widget? floatingActionButton() {
    return null;
  }

  //바텀 네비게이션바
  Widget? bottomNavigationBar() {
    return null;
  }

  //바텀 시트
  Widget? bottomSheet() {
    return null;
  }

  //메뉴 드로워
  Widget? drawer() {
    return null;
  }

  //로딩 화면
  Widget _showLoading() {
    log("LOADING!");
    return const Loading();
  }
}
