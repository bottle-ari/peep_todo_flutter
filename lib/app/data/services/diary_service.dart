import 'dart:developer';

import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/data/model/diary/diary_model.dart';
import 'package:peep_todo_flutter/app/data/provider/database/diary_provider.dart';

class DiaryService extends GetxService {
  final DiaryProvider _provider = DiaryProvider();

  /*
    CREATE DATA
   */
  Future<void> insertDiary({required DiaryModel diary}) async {
    Map<String, Object?> diaryMap = diary.toMap();
    await _provider.insertDiary(diaryMap);
  }

  /*
    READ DATA
  */
  Future<List<DiaryModel>> getDiaryAll() async {
    final List<Map<String, dynamic>> diaryMaps = await _provider.getDiaryAll();

    return diaryMaps.map((e) => DiaryModel.fromMap(e)).toList();
  }

  Future<List<DiaryModel>> getDiary(
      {required DateTime startDate, required DateTime endDate}) async {
    final List<Map<String, dynamic>> diaryMaps = await _provider.getDiary(
        startDate.millisecondsSinceEpoch, endDate.millisecondsSinceEpoch);

    List<DiaryModel> diaryList = [];

    for (var diaryMap in diaryMaps) {
      DiaryModel diary = DiaryModel.fromMap(diaryMap);
      diaryList.add(diary);
    }

    return diaryList;
  }

  /*
    UPDATE DATA
   */
  Future<void> updateDiary(DiaryModel diary) async {
    var row = await _provider.updateDiary(diary.toMap());

    log("update $row rows.");
  }

  /*
    DELETE DATA
   */
  Future<void> deleteDiary(String diaryId) async {
    var row = await _provider.deleteDiary(diaryId);

    log("delete $row rows.");
  }
}
