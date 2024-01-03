import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:peep_todo_flutter/app/controllers/data/category_controller.dart';
import 'package:peep_todo_flutter/app/controllers/data/diary_controller.dart';
import 'package:peep_todo_flutter/app/controllers/widget/peep_mini_calendar_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_controller.dart';
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

  // Quill
  final Rx<QuillController> quillController = QuillController.basic().obs;

  // PageController
  final PageController pageController = PageController(initialPage: 10000);
  final RxInt pageIndex = 10000.obs;

  @override
  void onInit() {
    super.onInit();

    // 투두 체크 감지
    ever(_todoController.todoMap, (callback) {
      updateCheckedTodoList();
    });

    // 카테고리 데이터 변경 감지
    ever(_categoryController.categoryList,
        (callback) => updateCheckedTodoList());

    // 다이어리 데이터 변경 감지
    ever(_diaryController.diaryData, (callback) => updateCheckedTodoList());

    updateCheckedTodoList();
  }

  /* Init Functions */
  void updateCheckedTodoList() async {
    List<DiaryTodoModel> newCheckTodo = [];

    for (var todo
        in _todoController.todoMap[_todoController.getSelectedTodoKey()] ??
            []) {
      if (todo.isChecked) {
        final category = await _categoryController.getCategoryByIdAsync(
            categoryId: todo.categoryId);
        newCheckTodo.add(DiaryTodoModel(
            name: todo.name,
            color: category.color,
            categoryOrder: category.pos,
            indexOrder: todo.pos));
      }
    }

    newCheckTodo.sort((a, b) => a.indexOrder - b.indexOrder);
    newCheckTodo.sort((a, b) => a.categoryOrder - b.categoryOrder);

    checkedTodo.value = newCheckTodo;

    loadContent();
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

  void loadContent() {
    log("LOAD CONTENTS");
    final String savedJson = _diaryController.diaryData.value.memo;

    if (savedJson.isEmpty) {
      quillController.value = QuillController.basic();
      return;
    }

    final Delta delta = Delta.fromJson(jsonDecode(savedJson));

    quillController.value = QuillController(
      document: Document.fromDelta(delta),
      selection: const TextSelection.collapsed(offset: 0),
    );
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

  void updateSelectedDate(int index) {
    final diff = pageIndex.value - index;

    DateTime newDate;
    if (diff < 0) {
      newDate = _todoController.selectedDate.value.add(const Duration(days: 1));
    } else if (diff > 0) {
      newDate = _todoController.selectedDate.value.subtract(const Duration(days: 1));
    } else {
      newDate = _todoController.selectedDate.value;
    }

    _todoController.selectedDate.value = newDate;
    _todoController.focusedDate.value = newDate;
    pageIndex.value = index;
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

      diary.image.add(localImage.path);

      _diaryController.updateDiary(diary: diary);
    }
  }

  void deleteImage(String imagePath) {
    var diary = _diaryController.diaryData.value;

    diary.image.remove(imagePath);

    _diaryController.updateDiary(diary: diary);
  }
}
