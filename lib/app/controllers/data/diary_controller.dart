import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:peep_todo_flutter/app/controllers/data/todo_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_controller.dart';
import 'package:peep_todo_flutter/app/data/model/diary/diary_model.dart';
import 'package:peep_todo_flutter/app/data/services/diary_service.dart';

import '../../data/enums/crud.dart';
import '../../utils/peep_calendar_util.dart';

class DiaryController extends BaseController {
  final DiaryService _service = Get.put(DiaryService());
  final TodoController _todoController = Get.find();

  // Data
  final RxMap<String, DiaryModel> diaryData = <String, DiaryModel>{}.obs;

  @override
  void onInit() {
    super.onInit();

    ever(_todoController.selectedDate, (callback) {
      String newDateString =
          DateFormat("yyyyMM").format(_todoController.selectedDate.value);
      String oldDateString =
          DateFormat("yyyyMM").format(_todoController.currentDate);
      if (newDateString != oldDateString) {
        loadDiaryData();
        _todoController.currentDate = _todoController.selectedDate.value;
      }
    });

    loadDiaryData();
  }

  /*
    Init Functions
   */
  void loadDiaryData() async {
    final DateTime startDate =
        getPreviousMonthEnd(_todoController.selectedDate.value)
            .subtract(const Duration(days: 7));
    final DateTime endDate =
        getNextMonthStart(_todoController.selectedDate.value)
            .add(const Duration(days: 7));

    final data =
        await _service.getDiary(startDate: startDate, endDate: endDate);

    diaryData.value = groupByDate(data);
  }

  /*
    CRUD 공통 함수
   */
  void _updateDiaryMap({required CRUD operation, required DiaryModel newDiary}) async {
    Map<String, DiaryModel> newDiaryMap = Map.from(diaryData);

    if(operation == CRUD.create) {
      // CREATE
        final formattedDate = DateFormat('yyyyMMdd').format(newDiary.date);

        // 실제 데이터 저장
        await _service.insertDiary(diary: newDiary);

        // 옵저버 변수에 값 추가
        newDiaryMap[formattedDate] = newDiary;
    } else if(operation == CRUD.update) {
      // UPDATE
      final formattedDate = DateFormat('yyyyMMdd').format(newDiary.date);

      // 실제 데이터 저장
      await _service.updateDiary(newDiary);

      // 옵저버 변수에 값 추가
      newDiaryMap[formattedDate] = newDiary;
    } else if(operation == CRUD.delete) {
      // DELETE
      final formattedDate = DateFormat('yyyyMMdd').format(newDiary.date);

      // 실제 데이터 저장
      await _service.deleteDiary(newDiary.id);

      // 옵저버 변수에 값 추가
      newDiaryMap[formattedDate] = newDiary;
    }

    diaryData.value = newDiaryMap;
  }


  /*
    CREATE Functions
   */
  void addDiary({required DiaryModel diary}) async {
    _updateDiaryMap(operation: CRUD.create, newDiary: diary);
  }

  /*
    UPDATE Functions
   */
  void updateDiary({required DiaryModel diary}) async {
    _updateDiaryMap(operation: CRUD.update, newDiary: diary);
  }

  /*
    DELETE Functions
   */
  Future<void> deleteDiary({required DiaryModel diary}) async {
    _updateDiaryMap(operation: CRUD.delete, newDiary: diary);
  }

  // 날짜별로 데이터를 분류하는 함수
  Map<String, DiaryModel> groupByDate(List<DiaryModel> diaryList) {
    Map<String, DiaryModel> dateMap = {};

    for (var diary in diaryList) {
      final formattedDate = DateFormat('yyyyMMdd').format(diary.date);
      dateMap[formattedDate] = diary;
    }

    return dateMap;
  }
}
