import 'dart:developer';

import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/data/todo_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_controller.dart';
import 'package:peep_todo_flutter/app/data/model/diary/diary_model.dart';
import 'package:peep_todo_flutter/app/data/services/diary_service.dart';

class DiaryController extends BaseController {
  final DiaryService _service = Get.put(DiaryService());
  final TodoController _todoController = Get.find();

  // Data
  final Rx<DiaryModel> diaryData =
      DiaryModel(id: '', date: DateTime.now(), image: [], memo: '').obs;

  @override
  void onInit() {
    super.onInit();

    ever(_todoController.selectedDate, (callback) => loadSelectedDiaryData());

    loadSelectedDiaryData();
  }

  /*
    Init Functions
   */
  void loadSelectedDiaryData() async {
    final selectedDate = _todoController.selectedDate.value;
    final DateTime startDate =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
    final DateTime endDate = startDate.add(const Duration(days: 1));

    final data =
        await _service.getDiary(startDate: startDate, endDate: endDate);

    if (data.isNotEmpty) {
      diaryData.value = data[0];
    } else {
      diaryData.value = DiaryModel(id: '', date: DateTime.now(), image: [], memo: '');
    }
  }

  /*
  Future<String> getLocalImagePath() async {
    final directory = await getApplicationDocumentsDirectory();
    // 나중에 앱을 다시 실행할 때 이 경로를 사용하여 이미지를 불러옵니다.
    return '${directory.path}/image.jpg'; // 저장된 이미지의 파일명을 사용합니다.
  }
   */

  /*
    CREATE Functions
   */
  void addDiary({required DiaryModel diary}) async {
    await _service.insertDiary(diary: diary);

    loadSelectedDiaryData();
  }

  /*
    UPDATE Functions
   */
  void updateDiary({required DiaryModel diary}) async {
    await _service.updateDiary(diary);

    loadSelectedDiaryData();
  }

  /*
    DELETE Functions
   */
  Future<void> deleteDiary({required DiaryModel diary}) async {
    await _service.deleteDiary(diary.id);

    loadSelectedDiaryData();
  }
}
