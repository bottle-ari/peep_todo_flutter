import 'dart:developer';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/todo_controller.dart';
import 'package:peep_todo_flutter/app/data/mock_data.dart';
import 'package:peep_todo_flutter/app/data/model/todo/sub_todo_model.dart';
import 'package:peep_todo_flutter/app/data/model/todo/todo_model.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';

import '../../data/model/category_model.dart';

class ScheduledTodoController extends TodoController {
  // TODO : 현재는 Mock 데이터가 들어가 있으므로, 추후 변경 필요
  late RxMap<String, List<dynamic>> _scheduledTodoList;
  late RxMap<String, List<int>> categoryIndexMap;

  final RxList<bool> categoryFoldMap =
      [false, true].obs; //TODO : categoryFoldMap에 대한 모델과 로컬 상태 저장이 필요함
  final RxMap<String, List<TodoModel>> _todoList = mockTodos.obs;
  final RxList<CategoryModel> _categoryList = mockCategories.obs;

  @override
  void onInit() {
    updateScheduledTodoList();
  }

  void updateScheduledTodoList() {
    {
      _scheduledTodoList = <String, List<dynamic>>{}.obs;
      categoryIndexMap = <String, List<int>>{}.obs;

      for (String date in _todoList.keys) {
        _scheduledTodoList[date] = [];
        categoryIndexMap[date] = [];
        int index = 0;

        for (int i = 0; i < _categoryList.length; i++) {
          _scheduledTodoList[date]!.add(_categoryList[i]);
          categoryIndexMap[date]!.add(_scheduledTodoList[date]!.length - 1);

          log("${_scheduledTodoList.length - 1} : $i");

          while (index < _todoList[date]!.length) {
            var todo = _todoList[date]![index];

            if (todo.categoryId != _categoryList[i].id) break;

            _scheduledTodoList[date]!.add(todo);
            index++;
          }
        }
      }
    }
  }

  @override
  List<dynamic> getTodoList({required String date}) {
    return _scheduledTodoList[date] ?? [];
  }

  @override
  List<SubTodoModel> getSubTodoList(
      {required String date, required int mainIndex}) {
    if (_scheduledTodoList[date] == null) {
      return [];
    } else {
      return _scheduledTodoList[date]![mainIndex].subTodo ?? [];
    }
  }

  @override
  void toggleTodoIsFold(String date, int index) {
    if (_scheduledTodoList[date] == null) return;
    _scheduledTodoList[date]![index].isFold.value =
        !_scheduledTodoList[date]![index].isFold.value;
  }

  @override
  void toggleMainTodoChecked(String date, int index) {
    if (_scheduledTodoList[date] == null) return;
    _scheduledTodoList[date]![index].isChecked.value =
        !_scheduledTodoList[date]![index].isChecked.value;
    update();
  }

  @override
  void toggleSubTodoChecked(String date, int mainIndex, int index) {
    if (_scheduledTodoList[date] == null) return;
    _scheduledTodoList[date]![mainIndex].subTodo![index].isChecked.value =
        !_scheduledTodoList[date]![mainIndex].subTodo![index].isChecked.value;
    update();
  }

  @override
  void reorderTodoList(String date, int oldIndex, int newIndex) {
    if (_scheduledTodoList[date] == null) return;
    if (newIndex == 0) return;
    if (isCategoryModel(date, oldIndex)) return;

    var oldCategory = getTodoCategory(date, oldIndex);

    var list = _scheduledTodoList[date]!;
    final TodoModel todoItem = list.removeAt(oldIndex);

    list.insert(newIndex, todoItem);
    _scheduledTodoList[date] = List.from(list);

    updateCategoryIndexMap(date);

    var newCategory = getTodoCategory(date, newIndex);

    if(oldCategory != newCategory) {
      todoItem.categoryId = _scheduledTodoList[date]![newCategory].id;
    }

    update();
  }

  void addCategoryItem(String date, String emoji, String name, Color color) {
    CategoryModel categoryModel = CategoryModel(id: 5, name: name, color: color, emoji: emoji);
    addCategoryModel(categoryModel);

    _categoryList.value = mockCategories;
    updateScheduledTodoList();
    updateCategoryIndexMap(date);

    log(_categoryList.value.toString());

    update();
  }

  void deleteTodoItem(String date, int index) {

  }

  Color todoColor(String date, int index) {
    var categoryId = _scheduledTodoList[date]![index].categoryId;

    return _categoryList
        .firstWhere((category) => category.id == categoryId)
        .color;
  }

  bool isCategoryModel(String date, int index) {
    if (categoryIndexMap[date]!.contains(index)) {
      return true;
    } else {
      return false;
    }
  }

  int getTodoCategory(String date, int index) {
    int i = 0;
    for (; i < categoryIndexMap[date]!.length - 1; i++) {
      if (categoryIndexMap[date]![i] < index &&
          categoryIndexMap[date]![i + 1] > index) {
        return categoryIndexMap[date]![i];
      }
    }
    return categoryIndexMap[date]![i];
  }

  void updateCategoryIndexMap(String date) {
    List<int> newCategoryIndexMap = [];

    if(_scheduledTodoList[date] == null) return;

    for(int i = 0; i < _scheduledTodoList[date]!.length; i++) {
      if(_scheduledTodoList[date]![i] is CategoryModel) {
        newCategoryIndexMap.add(i);
      }
    }

    categoryIndexMap[date] = newCategoryIndexMap;
  }
}