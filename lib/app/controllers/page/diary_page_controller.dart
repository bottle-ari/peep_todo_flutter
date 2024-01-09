import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:peep_todo_flutter/app/controllers/data/category_controller.dart';
import 'package:peep_todo_flutter/app/controllers/data/diary_controller.dart';
import 'package:peep_todo_flutter/app/controllers/data/palette_controller.dart';
import 'package:peep_todo_flutter/app/controllers/main/main_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_controller.dart';
import 'package:uuid/uuid.dart';

import '../../data/model/diary/diary_model.dart';
import '../../data/model/diary/diary_todo_model.dart';
import '../../utils/peep_calendar_util.dart';
import '../data/todo_controller.dart';
import '../widget/peep_mini_calendar_controller.dart';

class DiaryPageController extends BaseController {
  final PaletteController paletteController = Get.find();
  final MainController mainController = Get.find();
  final TodoController _todoController = Get.find();
  final CategoryController _categoryController = Get.find();
  final DiaryController _diaryController = Get.find();
  final PeepMiniCalendarController _peepMiniCalendarController = Get.find();

  final RxMap<String, bool> isOpen = <String, bool>{}.obs;
  final RxMap<String, List<DiaryTodoModel>> checkedTodo =
      <String, List<DiaryTodoModel>>{}.obs;

  //pageController
  late final Rx<PageController> pageController;
  bool isPageChange = false;

  // Quill
  final RxMap<String, QuillController> quillController =
      <String, QuillController>{}.obs;

  DiaryPageController() {
    pageController = PageController(initialPage: calculatePageIndex(_todoController.selectedDate.value)).obs;
  }

  @override
  void onInit() {
    super.onInit();

    // 팔레트 체크 감지
    ever(paletteController.selectedPalette,
        (callback) => updateCheckedTodoList());

    // 투두 체크 감지
    ever(_todoController.todoMap, (callback) {
      updateCheckedTodoList();
    });

    // 카테고리 데이터 변경 감지
    ever(_categoryController.categoryList,
        (callback) => updateCheckedTodoList());

    // 다이어리 데이터 변경 감지
    ever(_diaryController.diaryData, (callback) => updateCheckedTodoList());

    // 선택된 날짜 변경 감지
    ever(_todoController.selectedDate, (callback) {
      //updateCheckedTodoList();
      onMoveDate();
    });

    updateCheckedTodoList();
  }

  /* Init Functions */
  void updateCheckedTodoList() async {
    Map<String, List<DiaryTodoModel>> newCheckTodo = {};

    for (var date in _todoController.todoMap.keys) {
      for (var todo in _todoController.todoMap[date] ?? []) {
        if (todo.isChecked) {
          final category = await _categoryController.getCategoryByIdAsync(
              categoryId: todo.categoryId);

          if (newCheckTodo[date] == null) {
            newCheckTodo[date] = [];
          }

          newCheckTodo[date]!.add(DiaryTodoModel(
              name: todo.name,
              color:
                  paletteController.getDefaultPalette()[category.color].color,
              categoryOrder: category.pos,
              indexOrder: todo.pos));
        }
      }
      newCheckTodo[date]?.sort((a, b) => a.indexOrder - b.indexOrder);
      newCheckTodo[date]?.sort((a, b) => a.categoryOrder - b.categoryOrder);
    }

    checkedTodo.value = newCheckTodo;

    loadContent();
  }

  /*
    CREATE Functions
   */
  Future<void> createDiary() async {
    if (_diaryController
            .diaryData[_todoController.getSelectedTodoKey()]?.id.isEmpty ??
        true) {
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

  List<String> getImagePath(DateTime date) {
    List<String> imagePath = [];
    for (var image in _diaryController
            .diaryData[DateFormat("yyyyMMdd").format(date)]?.image ??
        []) {
      if (image != '') imagePath.add(image);
    }
    log(imagePath.toString());
    return imagePath;
  }

  void loadContent() {
    log("LOAD CONTENTS");
    Map<String, QuillController> quillControllerMap = Map.from(quillController);

    for (var date in _diaryController.diaryData.keys) {
      if (quillControllerMap[date] == null) {
        quillController[date] = QuillController.basic();
      }

      final String savedJson = _diaryController.diaryData[date]?.memo ?? '';

      if (savedJson.isNotEmpty) {
        final Delta delta = Delta.fromJson(jsonDecode(savedJson));

        quillControllerMap[date] = QuillController(
          document: Document.fromDelta(delta),
          selection: const TextSelection.collapsed(offset: 0),
        );
      }
    }

    quillController.value = quillControllerMap;
  }

  /*
    UPDATE Functions
   */
  void onMoveToday() {
    _peepMiniCalendarController.onMoveToday();
  }

  void onMoveDate() {
    int newInx = calculatePageIndex(_todoController.selectedDate.value);

    if(pageController.value.hasClients) {
      if (!isPageChange) {
        pageController.value.jumpToPage(newInx);
      } else {
        isPageChange = false;
      }
    } else {
      pageController.value =
          PageController(initialPage: newInx);
    }
  }

  void onPageChange(DateTime date) {
    isPageChange = true;
    _todoController.selectedDate.value = date;
    _todoController.focusedDate.value = date;
  }

  void toggleIsOpen(DateTime date) {
    Map<String, bool> isOpenMap = Map.from(isOpen);
    bool? isOpenVal = isOpenMap[DateFormat('yyyyMMdd').format(date)];

    if (isOpenVal == null) {
      isOpenMap[DateFormat('yyyyMMdd').format(date)] = true;
    } else {
      isOpenMap[DateFormat('yyyyMMdd').format(date)] = !isOpenVal;
    }

    isOpen.value = isOpenMap;
  }

  void isOpenValue(DateTime date, bool value) {
    Map<String, bool> isOpenMap = Map.from(isOpen);
    isOpenMap[DateFormat('yyyyMMdd').format(date)] = value;

    isOpen.value = isOpenMap;
  }

  /*
    IMAGE functions
  */
  Future<void> pickImage() async {
    await createDiary();
    var diary =
        _diaryController.diaryData[_todoController.getSelectedTodoKey()];

    if (diary == null) return;

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
    var diary =
        _diaryController.diaryData[_todoController.getSelectedTodoKey()];

    if (diary == null) return;

    diary.image.remove(imagePath);

    _diaryController.updateDiary(diary: diary);
  }
}
