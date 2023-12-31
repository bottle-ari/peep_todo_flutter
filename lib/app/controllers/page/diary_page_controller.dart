import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:peep_todo_flutter/app/controllers/data/category_controller.dart';
import 'package:peep_todo_flutter/app/controllers/data/diary_controller.dart';
import 'package:peep_todo_flutter/app/controllers/widget/peep_mini_calendar_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_controller.dart';
import 'package:peep_todo_flutter/app/data/model/todo/todo_model.dart';
import 'package:uuid/uuid.dart';

import '../../data/model/diary/diary_model.dart';
import '../../data/model/diary/diary_todo_model.dart';
import '../data/todo_controller.dart';

class DiaryPageController extends BaseController {
  final TodoController _todoController = Get.find();
  final CategoryController _categoryController = Get.find();
  final DiaryController _diaryController = Get.find();
  final PeepMiniCalendarController _peepMiniCalendarController = Get.find();
  final RxBool isOpen = false.obs;

  final RxList<DiaryTodoModel> checkedTodo = <DiaryTodoModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    ever(_todoController.todoMap, (callback) {
      updateCheckedTodoList();
    });

    // 선택된 날짜 변경 감지
    ever(_todoController.selectedDate, (callback) => updateCheckedTodoList());

    // 카테고리 데이터 변경 감지
    ever(_categoryController.categoryList,
        (callback) => updateCheckedTodoList());

    updateCheckedTodoList();
  }

  /* Init Functions */
  void updateCheckedTodoList() async {
    List<DiaryTodoModel> newCheckTodo = [];

    for (var todo
        in _todoController.todoMap[_todoController.getSelectedTodoKey()] ??
            []) {
      if (todo.isChecked) {
        newCheckTodo.add(DiaryTodoModel(
            name: todo.name,
            color: _categoryController
                .getCategoryById(categoryId: todo.categoryId)
                .color));
      }
    }

    log('${newCheckTodo.length}');

    checkedTodo.value = newCheckTodo;
  }

  /*
    CREATE Functions
   */
  Future<void> createDiary() async {
    if (_diaryController.diaryData.value.id.isEmpty) {
      var uuid = const Uuid();
      String newUuid = uuid.v4();

      _diaryController.addDiary(
          diary: DiaryModel(
              id: newUuid,
              date: _todoController.selectedDate.value,
              image: [],
              memo: ''));
    }
  }

  /*
    READ Functions
   */
  DateTime getSelectedDate() {
    return _todoController.selectedDate.value;
  }

  List<String> getImagePath() {
    List<String> imagePath = [];
    for (var image in _diaryController.diaryData.value.image) {
      if (image != '') imagePath.add(image);
    }
    log(imagePath.toString());
    return imagePath;
  }

  String getMemo() {
    return _diaryController.diaryData.value.memo;
  }

  /*
    UPDATE Functions
   */
  void onMoveToday() {
    _peepMiniCalendarController.onMoveToday();
  }

  void toggleIsOpen() {
    isOpen.value = !isOpen.value;
  }

  /*
    IMAGE functions
  */
  Future<void> pickImage() async {
    await createDiary();
    var diary = _diaryController.diaryData.value;

    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      // 이미지를 로컬에 저장합니다.
      final File file = File(image.path);
      final directory = await getApplicationDocumentsDirectory();
      final path = directory.path;
      final String fileName = image.name;
      final File localImage = await file.copy('$path/$fileName');

      // 로컬에 저장된 이미지의 경로를 저장합니다.
      log("여기 : $diary");

      if (getImagePath().isEmpty) {
        diary.image.add(localImage.path);
      } else {
        diary.image[0] = localImage.path;
      }
      _diaryController.updateDiary(diary: diary);
    }
  }
}
