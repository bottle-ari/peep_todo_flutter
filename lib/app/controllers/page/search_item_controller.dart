import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/data/todo_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_controller.dart';
import 'package:peep_todo_flutter/app/data/model/todo/todo_model.dart';
import 'package:peep_todo_flutter/app/data/services/todo_service.dart';

class SearchItemController extends BaseController {
  final TodoService _service = TodoService();
  final TodoController _todoController = Get.find();

  // Data
  final RxMap<String, List<TodoModel>> searchTodoList =
      <String, List<TodoModel>>{}.obs;
  final TextEditingController searchFieldController = TextEditingController();

  // Variables
  final RxString searchKeyword = ''.obs;

  @override
  void onInit() {
    super.onInit();
    searchKeyword.value = searchFieldController.text;
  }

  @override
  void onClose() {
    searchFieldController.dispose();
    super.onClose();
  }

  // local db 검색 기능
  void search() async {
    searchKeywordUpdate();

    if (searchKeyword.value.isEmpty) {
      searchTodoList.value = {};
      return;
    }

    var data =
        await _service.getTodoWithSearch(inputString: searchKeyword.value);

    searchTodoList.value = _todoController.groupByDate(data);
    log('search : ${data.length}');
  }

  // 검색 기능 초기화
  void initSearchFunction() {
    searchFieldController.clear();
    searchTodoList.value = {};
  }

  // 검색 키워드 갱신 기능
  void searchKeywordUpdate() {
    searchKeyword.value = searchFieldController.text;

    if (searchFieldController.text.isEmpty) {
      searchKeyword.value = '';
    }
  }

  // 검색하여 클릭한 날짜로 selected Day 변경
  void selectedDay(DateTime? newSelectedDay) {
    if (newSelectedDay == null) return;
    _todoController.onDaySelected(newSelectedDay, newSelectedDay);
    log("onDaySelected:{$newSelectedDay} ");
  }

  // 올해인지 확인하여 형태에 맞는 String 리턴하는 함수
  String checkYear(String formattedDate) {
    if (DateTime.now().year != int.parse(formattedDate.substring(0, 4))) {
      return formattedDate.substring(0, 4) +
          "년 " +
          formattedDate.substring(4, 6) +
          "월 " +
          formattedDate.substring(6) +
          "일";
    }
    return formattedDate.substring(4, 6) +
        "월 " +
        formattedDate.substring(6) +
        "일";
  }
}
