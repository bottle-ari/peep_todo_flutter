// import 'dart:developer';
// import 'dart:ui';
//
// import 'package:get/get.dart';
// import 'package:peep_todo_flutter/app/core/base/base_controller.dart';
// import 'package:peep_todo_flutter/app/data/model/todo/sub_todo_model.dart';
// import 'package:peep_todo_flutter/app/data/model/todo/todo_model.dart';
//
// import '../../data/model/category_model.dart';
//
// class ScheduledTodoController extends BaseController {
//   late RxMap<String, List<dynamic>> _scheduledTodoList;
//
//   late RxMap<String, List<int>> categoryIndexMap;
//   final RxList<bool> categoryFoldMap = <bool>[].obs;
//
//   final RxMap<String, List<TodoModel>> _todoList = mockTodos.obs;
//   final RxList<CategoryModel> _categoryList = mockCategories.obs;
//
//   final RxMap<String, List<double>> calendarItemCounts =
//       <String, List<double>>{}.obs;
//
//   TodoModel? backupTodoItem;
//   int? backupIndex;
//   String? backupDate;
//
//   @override
//   void onInit() {
//     initCategoryFoldMap();
//     updateScheduledTodoList();
//     initCalendarItemCounts();
//   }
//
//   int reverseCategoryFoldMap(String date, int index) {
//     if(categoryIndexMap[date] == null) return -1;
//     return categoryIndexMap[date]!.indexOf(index);
//   }
//
//   void initCategoryFoldMap() {
//     for(var _ in _categoryList) {
//       categoryFoldMap.add(false);
//     }
//   }
//
//   void updateScheduledTodoList() {
//     {
//       _scheduledTodoList = <String, List<dynamic>>{}.obs;
//       categoryIndexMap = <String, List<int>>{}.obs;
//
//       for (String date in _todoList.keys) {
//         _scheduledTodoList[date] = [];
//         categoryIndexMap[date] = [];
//         int index = 0;
//
//         for (int i = 0; i < _categoryList.length; i++) {
//           _scheduledTodoList[date]!.add(_categoryList[i]);
//           categoryIndexMap[date]!.add(_scheduledTodoList[date]!.length - 1);
//
//           log("${_scheduledTodoList.length - 1} : $i");
//
//           while (index < _todoList[date]!.length) {
//             var todo = _todoList[date]![index];
//
//             if (todo.categoryId != _categoryList[i].id) break;
//
//             _scheduledTodoList[date]!.add(todo);
//             index++;
//           }
//         }
//       }
//     }
//   }
//
//   @override
//   List<dynamic> getTodoList({required String date}) {
//     return _scheduledTodoList[date] ?? [];
//   }
//
//   @override
//   List<SubTodoModel> getSubTodoList(
//       {required String date, required int mainIndex}) {
//     if (_scheduledTodoList[date] == null) {
//       return [];
//     } else {
//       return _scheduledTodoList[date]![mainIndex].subTodo ?? [];
//     }
//   }
//
//   @override
//   void toggleTodoIsFold(String date, int index) {
//     if (_scheduledTodoList[date] == null) return;
//     _scheduledTodoList[date]![index].isFold.value =
//     !_scheduledTodoList[date]![index].isFold.value;
//   }
//
//   void toggleCategoryIsFold(String date, int index) {
//     int inx = reverseCategoryFoldMap(date, index);
//     categoryFoldMap[inx] = !categoryFoldMap[inx];
//
//     log("$categoryFoldMap");
//
//     update();
//   }
//
//   @override
//   void toggleMainTodoChecked(String date, int index) {
//     if (_scheduledTodoList[date] == null) return;
//     _scheduledTodoList[date]![index].isChecked.value =
//     !_scheduledTodoList[date]![index].isChecked.value;
//
//     updateCalendarItemCounts(date);
//
//     update();
//   }
//
//   @override
//   void toggleSubTodoChecked(String date, int mainIndex, int index) {
//     if (_scheduledTodoList[date] == null) return;
//     _scheduledTodoList[date]![mainIndex].subTodo![index].isChecked.value =
//     !_scheduledTodoList[date]![mainIndex].subTodo![index].isChecked.value;
//     update();
//   }
//
//   @override
//   void reorderTodoList(String date, int oldIndex, int newIndex) {
//     if (_scheduledTodoList[date] == null) return;
//     if (newIndex == 0) return;
//     if (isCategoryModel(date, oldIndex)) return;
//
//     var oldCategory = getTodoCategory(date, oldIndex);
//
//     var list = _scheduledTodoList[date]!;
//     final TodoModel todoItem = list.removeAt(oldIndex);
//
//     list.insert(newIndex, todoItem);
//     _scheduledTodoList[date] = List.from(list);
//
//     updateCategoryIndexMap(date);
//
//     var newCategory = getTodoCategory(date, newIndex);
//
//     if (oldCategory != newCategory) {
//       todoItem.categoryId = _scheduledTodoList[date]![newCategory].id;
//     }
//
//     updateCalendarItemCounts(date);
//
//     update();
//   }
//
//   void addCategoryItem(String date, String emoji, String name, Color color) {
//     CategoryModel categoryModel =
//     CategoryModel(id: 5, name: name, color: color, emoji: emoji);
//     addCategoryModel(categoryModel);
//
//     _categoryList.value = mockCategories;
//     updateScheduledTodoList();
//     updateCategoryIndexMap(date);
//
//     log(_categoryList.toString());
//
//     update();
//   }
//
//   @override
//   void deleteTodoItem(String? date, int index) {
//     if(date == null) return;
//
//     backupDate = date;
//     backupIndex = index;
//
//     var list = _scheduledTodoList[date]!;
//
//     backupTodoItem = list.removeAt(index);
//     _scheduledTodoList[date] = List.from(list);
//
//     updateCategoryIndexMap(date);
//     updateCalendarItemCounts(date);
//
//     update();
//   }
//
//   @override
//   void rollbackTodoItem() {
//     if(backupTodoItem == null || backupDate == null || backupIndex == null) return;
//
//     var list = _scheduledTodoList[backupDate]!;
//     list.insert(backupIndex!, backupTodoItem);
//     _scheduledTodoList[backupDate!] = List.from(list);
//
//     updateCategoryIndexMap(backupDate!);
//     updateCalendarItemCounts(backupDate!);
//
//     update();
//   }
//
//   Color todoColor(String date, int index) {
//     var categoryId = _scheduledTodoList[date]![index].categoryId;
//
//     return _categoryList
//         .firstWhere((category) => category.id == categoryId)
//         .color;
//   }
//
//   @override
//   bool isCategoryModel(String date, int index) {
//     if (categoryIndexMap[date]!.contains(index)) {
//       return true;
//     } else {
//       return false;
//     }
//   }
//
//   int getTodoCategory(String date, int index) {
//     int i = 0;
//     for (; i < categoryIndexMap[date]!.length - 1; i++) {
//       if (categoryIndexMap[date]![i] < index &&
//           categoryIndexMap[date]![i + 1] > index) {
//         return categoryIndexMap[date]![i];
//       }
//     }
//     return categoryIndexMap[date]![i];
//   }
//
//   void updateCategoryIndexMap(String date) {
//     List<int> newCategoryIndexMap = [];
//
//     if (_scheduledTodoList[date] == null) return;
//
//     for (int i = 0; i < _scheduledTodoList[date]!.length; i++) {
//       if (_scheduledTodoList[date]![i] is CategoryModel) {
//         newCategoryIndexMap.add(i);
//       }
//     }
//
//     categoryIndexMap[date] = newCategoryIndexMap;
//   }
//
//   /*
//   MiniCalendar
//    */
//   List<CategoryModel> getCategoryList() {
//     return _categoryList;
//   }
//
//   void initCalendarItemCounts() {
//     for (var date in _todoList.keys) {
//       if (_scheduledTodoList[date] == null) continue;
//
//       List<int> itemCounts = [];
//       int sum = 0;
//       for (int i = 0; i < _scheduledTodoList[date]!.length; i++) {
//         if (isCategoryModel(date, i)) {
//           itemCounts.add(0);
//         } else {
//           sum++;
//           if (_scheduledTodoList[date]![i].isChecked.value) {
//             itemCounts[itemCounts.length - 1]++;
//           }
//         }
//       }
//
//       if (sum != 0) {
//         calendarItemCounts[date] =
//             itemCounts.map((item) => item / sum).toList();
//       }
//     }
//   }
//
//   void updateCalendarItemCounts(String date) {
//     List<int> itemCounts = [];
//     int sum = 0;
//     for (int i = 0; i < _scheduledTodoList[date]!.length; i++) {
//       if (isCategoryModel(date, i)) {
//         itemCounts.add(0);
//       } else {
//         sum++;
//         if (_scheduledTodoList[date]![i].isChecked.value) {
//           itemCounts[itemCounts.length - 1]++;
//         }
//       }
//     }
//
//     if (sum != 0) {
//       calendarItemCounts[date] =
//           itemCounts.map((item) => item / sum).toList();
//     }
//   }
// }

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/data/category_controller.dart';
import 'package:peep_todo_flutter/app/data/enums/todo_enum.dart';
import 'package:peep_todo_flutter/app/data/model/category/category_model.dart';
import 'package:peep_todo_flutter/app/data/model/todo/todo_model.dart';
import 'package:uuid/uuid.dart';

import '../../core/base/base_controller.dart';
import '../data/pref_controller.dart';
import '../data/todo_controller.dart';

class ScheduledTodoController extends BaseController {
  final CategoryController _categoryController = Get.find();
  final TodoController _todoController = Get.find();
  final PrefController prefController = Get.find();

  // Data
  final RxList<dynamic> scheduledTodoList = <dynamic>[].obs;

  // Variables
  Map<String, List<int>> categoryIndexMap = <String, List<int>>{};
  RxMap<String, bool> categoryFoldMap = <String, bool>{}.obs;

  String? newTodoId;
  String? newTodoCategoryId;

  final TextEditingController textFieldController = TextEditingController();
  final Rx<FocusNode> focusNode = FocusNode().obs;
  final RxBool isInputMode = false.obs;

  final isFirstTimeAccess = false.obs;

  @override
  void onInit() {
    super.onInit();

    focusNode.value.addListener(_focusNodeListener);

    ever(_todoController.selectedTodoList, (callback) {
      updateScheduledTodoList();
    });

    ever(_categoryController.categoryList,
        (callback) => updateScheduledTodoList());

    updateScheduledTodoList();
    loadIsFirstTimeAccess();
  }

  @override
  void onClose() {
    focusNode.value.removeListener(_focusNodeListener);
    focusNode.value.dispose();
    super.onClose();
  }

  void _focusNodeListener() {
    if (!focusNode.value.hasFocus) {
      addNewTodoConfirm();
      log('focus off');
    }
  }

  /*
    Init Functions
   */
  void loadIsFirstTimeAccess() async {
    var key = 'isFirstTimeAccess';

    await prefController.updateData(key);

    log(prefController.data[key] ?? '?');

    if (prefController.data[key]?.isEmpty ?? true) {
      prefController.saveData(key, 'true');
      isFirstTimeAccess.value = true;
    } else if (prefController.data[key] == 'true') {
      isFirstTimeAccess.value = true;
    } else {
      isFirstTimeAccess.value = false;
    }
  }

  void updateScheduledTodoList() async {
    addNewTodoConfirm();

    List<dynamic> newScheduledTodoList = List<dynamic>.from(_categoryController
        .categoryList
        .where((element) => element.isActive == true));

    initCategoryIndexMap(newScheduledTodoList);

    for (var todo in _todoController.selectedTodoList) {
      if (categoryIndexMap[todo.categoryId] == null) continue;

      var inx = categoryIndexMap[todo.categoryId]![1]; // todo가 추가될 index

      if (inx >= newScheduledTodoList.length) {
        newScheduledTodoList.add(todo);
      } else {
        newScheduledTodoList.insert(inx, todo);
      }

      updateCategoryIndexMap(inx);
      categoryIndexMap[todo.categoryId]?[1]++;
    }

    scheduledTodoList.value = newScheduledTodoList;

    initCategoryFoldMap();
  }

  void initCategoryFoldMap() {
    if (_categoryController.categoryList.isEmpty) return;

    var key = 'categoryFoldMap';
    prefController.updateData(key);

    if (prefController.data[key] == null) {
      for (var category in _categoryController.categoryList) {
        categoryFoldMap[category.id] = false;
      }
    } else {
      Map<String, dynamic> tempMap = jsonDecode(prefController.data[key]!);

      Map<String, bool> storedCategoryFoldMap =
          tempMap.map((key, value) => MapEntry(key, value as bool));

      for (var category in _categoryController.categoryList) {
        categoryFoldMap[category.id] =
            storedCategoryFoldMap[category.id] ?? false;
      }
    }

    String categoryFoldMapString = jsonEncode(categoryFoldMap);
    prefController.saveData(key, categoryFoldMapString);
  }

  void initCategoryIndexMap(List<dynamic>? todoList) {
    todoList ??= scheduledTodoList;

    Map<String, List<int>> newCategoryIndexMap = {};

    for (int i = 0; i < todoList.length; i++) {
      if (todoList[i] is CategoryModel) {
        newCategoryIndexMap[todoList[i].id] = [i, i + 1];
      } else {
        newCategoryIndexMap[todoList[i].categoryId]?[1]++;
      }
    }

    categoryIndexMap = newCategoryIndexMap;
  }

  void updateCategoryIndexMap(int index) {
    Map<String, List<int>> newCategoryIndexMap = {};

    for (var key in categoryIndexMap.keys) {
      if (categoryIndexMap[key] == null) {
        throw Exception('error in updateCategoryIndexMap');
      }

      if (categoryIndexMap[key]![0] >= index) {
        newCategoryIndexMap[key] = [
          categoryIndexMap[key]![0] + 1,
          categoryIndexMap[key]![1] + 1
        ];
      } else {
        newCategoryIndexMap[key] = [
          categoryIndexMap[key]![0],
          categoryIndexMap[key]![1]
        ];
      }
    }

    categoryIndexMap = newCategoryIndexMap;
  }

  /*
    Create Function
   */
  void addNewTodo({required String categoryId}) {
    if (isFirstTimeAccess.value) {
      prefController.saveData('isFirstTimeAccess', 'false');
      isFirstTimeAccess.value = false;
    }

    if (isInputMode.value) {
      if (newTodoCategoryId == categoryId) {
        return;
      } else {
        addNewTodoConfirm();
      }
    }
    focusNode.value = FocusNode();
    newTodoCategoryId = categoryId;
    isInputMode.value = true;

    final newTodoPos = categoryIndexMap[categoryId]![1];
    log(newTodoPos.toString());

    var uuid = const Uuid();
    newTodoId = uuid.v4();

    List<dynamic> newScheduledTodoList = List<dynamic>.from(scheduledTodoList);

    newScheduledTodoList.insert(
        newTodoPos,
        TodoModel(
            id: newTodoId!,
            categoryId: categoryId,
            reminderId: null,
            name: '',
            date: _todoController.selectedDate.value,
            priority: 0,
            memo: 'memo',
            isChecked: false,
            checkTime: null,
            pos: newTodoPos));

    initCategoryIndexMap(newScheduledTodoList);
    scheduledTodoList.value = newScheduledTodoList;

    log(scheduledTodoList.toString());
    log(categoryIndexMap.toString());
    update();
  }

  void addNewTodoConfirm({bool isContinued = false}) {
    if (!isInputMode.value) return;

    TodoModel todo =
        scheduledTodoList.firstWhere((element) => element.id == newTodoId);

    if (textFieldController.text != '') {
      final bool isScheduledTodoType = _categoryController
              .getCategoryById(categoryId: todo.categoryId)
              .type ==
          TodoType.scheduled;
      if (isScheduledTodoType) {
        _todoController.addTodo(
          todo: TodoModel(
              id: todo.id,
              categoryId: todo.categoryId,
              reminderId: null,
              name: textFieldController.text,
              date: todo.date,
              priority: 0,
              memo: '',
              isChecked: false,
              checkTime: null,
              pos: todo.pos),
        );
      } else {
        _todoController.addTodo(
          todo: TodoModel(
              id: todo.id,
              categoryId: todo.categoryId,
              reminderId: null,
              name: textFieldController.text,
              date: null,
              priority: 0,
              memo: '',
              isChecked: false,
              checkTime: null,
              pos: todo.pos),
        );
      }

      textFieldController.clear();
    }

    focusNode.value.unfocus();
    newTodoId = null;
    newTodoCategoryId = null;
    isInputMode.value = false;

    updateScheduledTodoList();
    _todoController.updateCalendarItemCounts(todo.date);

    update();
  }

  /*
    Read Function
   */
  Color getColor({required String todoId}) {
    var categoryId = _todoController.selectedTodoList
        .firstWhere((e) => e.id == todoId)
        .categoryId;

    return _categoryController.categoryList
        .firstWhere((e) => e.id == categoryId)
        .color;
  }

  Color getColorByCategory({required TodoModel item}) {
    CategoryModel category =
        _categoryController.getCategoryById(categoryId: item.categoryId);

    return category.color;
  }

  DateTime getSelectedDate() {
    return _todoController.selectedDate.value;
  }

  TodoType getTodoTypeByCategory({required TodoModel item}) {
    CategoryModel category =
        _categoryController.getCategoryById(categoryId: item.categoryId);

    return category.type;
  }

  /*
    Update Function
   */
  void reorderTodoList(int oldIndex, int newIndex) {
    if (newIndex == 0 || oldIndex == newIndex) return;
    if (scheduledTodoList[oldIndex] is CategoryModel) return;

    //_reorderAndSaveTodoList(oldIndex, newIndex);

    var list = scheduledTodoList;
    final TodoModel todoItem = list.removeAt(oldIndex);

    String oldCategoryId = todoItem.categoryId;
    String newCategoryId = '';

    // 1. newCategoryId 구하기
    if (oldIndex > newIndex) {
      for (var key in categoryIndexMap.keys) {
        if (categoryIndexMap[key]![0] < newIndex &&
            categoryIndexMap[key]![1] >= newIndex) {
          newCategoryId = key;
          break;
        }
      }
    } else {
      for (var key in categoryIndexMap.keys) {
        if (categoryIndexMap[key]![0] <= newIndex &&
            categoryIndexMap[key]![1] > newIndex) {
          newCategoryId = key;
          break;
        }
      }
    }

    final todoType = _categoryController
        .getCategoryById(categoryId: todoItem.categoryId)
        .type;
    final newTodoType =
        _categoryController.getCategoryById(categoryId: newCategoryId).type;
    todoItem.categoryId = newCategoryId;
    if (todoType != newTodoType) {
      if (!todoItem.isChecked) {
        if (newTodoType == TodoType.constant) {
          todoItem.date = null;
        } else {
          todoItem.date = _todoController.selectedDate.value;
        }
      }
    }

    list.insert(newIndex, todoItem);
    scheduledTodoList.value = List.from(list);

    initCategoryIndexMap(scheduledTodoList);
    _reorderAndSaveTodoList(oldCategoryId, newCategoryId, newIndex);

    _todoController.updateCalendarItemCounts(todoItem.date);
    update();
  }

  void _reorderAndSaveTodoList(
      String oldCategoryId, String newCategoryId, int newIndex) {
    // 2. oldCategory pos 변경 후 저장
    var first = categoryIndexMap[oldCategoryId]![0];
    var last = categoryIndexMap[oldCategoryId]![1];

    int newPos = 0;
    for (int i = first + 1; i < last; i++) {
      scheduledTodoList[i].pos = newPos;
      newPos++;
    }

    _todoController.updateTodos(
        todoList: scheduledTodoList.sublist(first + 1, last).cast<TodoModel>());

    // newCategory pos 변경 후 저장
    if (newCategoryId != oldCategoryId) {
      first = categoryIndexMap[newCategoryId]![0];
      last = categoryIndexMap[newCategoryId]![1];

      newPos = 0;
      for (int i = first + 1; i < last; i++) {
        scheduledTodoList[i].pos = newPos;
        newPos++;
      }

      _todoController.updateTodos(
          todoList:
              scheduledTodoList.sublist(first + 1, last).cast<TodoModel>());
    }
  }

  void isCategoryFold(String id) async {
    var key = 'categoryFoldMap';

    categoryFoldMap[id] = !categoryFoldMap[id]!;

    String categoryFoldMapString = jsonEncode(categoryFoldMap);
    prefController.saveData(key, categoryFoldMapString);
  }

  void onMoveToday() {
    _todoController.onMoveToday();
  }
}
