import 'dart:ui';

import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';

import '../../data/model/enum/menu_state.dart';
import '../../data/model/enum/page_state.dart';

abstract class BaseController extends GetxController {

  // 페이지 리로드
  final _refreshController = false.obs;
  refreshPage(bool refresh) => _refreshController(refresh);

  // 페이지 상태 관리
  final _pageStateController = PageState.DEFAULT.obs;
  PageState get pageState => _pageStateController.value;

  //페이지 업데이트
  updatePageState(PageState state) => _pageStateController(state);
  //페이지 초기화
  resetPageState() => _pageStateController(PageState.DEFAULT);
  //로딩 보여주기
  showLoading() => updatePageState(PageState.LOADING);
  //로딩 끄기
  hideLoading() => resetPageState();

  //스테이터스 바, 배경 색 지정
  Rx<Color> backgroundColor = Palette.peepBackground.obs;

  //종료시 초기화
  @override
  void onClose() {
    _refreshController.close();
    _pageStateController.close();
    super.onClose();
  }
}