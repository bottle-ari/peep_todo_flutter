import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:peep_todo_flutter/app/controllers/data/category_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_controller.dart';
import 'package:peep_todo_flutter/app/data/model/todo/todo_model.dart';

import '../../data/model/diary/diary_model.dart';
import '../../data/model/diary/diary_todo_model.dart';
import '../data/todo_controller.dart';

class DiaryController extends BaseController {
  final TodoController _todoController = Get.find();
  final CategoryController _categoryController = Get.find();
  final RxBool isOpen = false.obs;

  final RxList<DiaryTodoModel> checkedTodo = <DiaryTodoModel>[].obs;
  final RxMap<String, String> selectedImagePath = <String, String>{}.obs;

  @override
  void onInit() {
    super.onInit();

    ever(_todoController.selectedTodoList, (callback) {
      updateCheckedTodoList();
    });

    updateCheckedTodoList();
  }

  /* Init Functions */
  void updateCheckedTodoList() async {
    List<DiaryTodoModel> newCheckTodo = [];

    log('start');

    for (var todo in _todoController.selectedTodoList) {
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

  DateTime getSelectedDate() {
    return _todoController.selectedDate.value;
  }

  void onMoveToday() {
    _todoController.onMoveToday();
  }

  void toggleIsOpen() {
    isOpen.value = !isOpen.value;
  }

  /*
    IMAGE functions
  */
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      selectedImagePath[DateFormat('yyyyMMdd')
          .format(_todoController.selectedDate.value)] = image.path;

      // 이미지를 로컬에 저장합니다.
      final File file = File(image.path);
      final directory = await getApplicationDocumentsDirectory();
      final path = directory.path;
      final String fileName = image.name;
      final File localImage = await file.copy('$path/$fileName');

      // 로컬에 저장된 이미지의 경로를 저장합니다.
      selectedImagePath[DateFormat('yyyyMMdd')
          .format(_todoController.selectedDate.value)] = localImage.path;
    }
  }

  Future<String> getLocalImagePath() async {
    final directory = await getApplicationDocumentsDirectory();
    // 나중에 앱을 다시 실행할 때 이 경로를 사용하여 이미지를 불러옵니다.
    return '${directory.path}/image.jpg'; // 저장된 이미지의 파일명을 사용합니다.
  }
}
