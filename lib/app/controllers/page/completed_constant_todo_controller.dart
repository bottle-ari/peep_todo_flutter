import 'dart:ui';

import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/data/model/todo/sub_todo_model.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';

import '../../data/mock_data.dart';
import '../../data/model/category_model.dart';
import '../../data/model/todo/todo_model.dart';
import '../todo_controller.dart';

class CompletedConstantTodoController extends TodoController {
  late RxList<dynamic> _constantTodoList;
  late RxList<int> categoryIndexMap;

  final RxMap<String, List<TodoModel>> _todoList = mockTodos.obs;
  final RxList<CategoryModel> _categoryList = mockCategories.obs;

  @override
  void onInit() {
    updateConstantTodoList();
    updateCategoryIndexMap();
  }

  void updateConstantTodoList() {
    {
      _constantTodoList = [].obs;
      categoryIndexMap = <int>[].obs;
      int index = 0;

      for (int i = 0; i < _categoryList.length; i++) {
        _constantTodoList.add(_categoryList[i]);
        categoryIndexMap.add(_constantTodoList.length - 1);

        while (index < _todoList['constant']!.length) {
          var todo = _todoList['constant']![index];

          if (todo.categoryId != _categoryList[i].id) break;

          if(_todoList['constant']![index].isChecked.value) {
            _constantTodoList.add(todo);
          }
          index++;
        }
      }
    }
  }

  @override
  void deleteTodoItem(String? date, int index) {
    // TODO: implement deleteTodoItem
  }

  @override
  List<SubTodoModel> getSubTodoList(
      {required String date, required int mainIndex}) {
    return _constantTodoList[mainIndex].subTodo ?? [];
  }

  @override
  List getTodoList({required String date}) {
    return _constantTodoList;
  }

  @override
  void reorderTodoList(String date, int oldIndex, int newIndex) {
    if (newIndex == 0) return;
    if (isCategoryModel(date, oldIndex)) return;

    var oldCategory = getTodoCategory(oldIndex);

    var list = _constantTodoList;
    final TodoModel todoItem = list.removeAt(oldIndex);

    list.insert(newIndex, todoItem);
    _constantTodoList.value = List.from(list);

    updateCategoryIndexMap();

    var newCategory = getTodoCategory(newIndex);

    if (oldCategory != newCategory) {
      todoItem.categoryId = _constantTodoList[newCategory].id;
    }

    update();
  }

  @override
  void rollbackTodoItem() {
    // TODO: implement rollbackTodoItem
  }

  @override
  void toggleMainTodoChecked(String date, int index) {
    _constantTodoList[index].isChecked.value =
    !_constantTodoList[index].isChecked.value;

    updateConstantTodoList();
    updateCategoryIndexMap();

    update();
  }

  @override
  void toggleSubTodoChecked(String date, int mainIndex, int index) {
    _constantTodoList[mainIndex].subTodo![index].isChecked.value =
    !_constantTodoList[mainIndex].subTodo![index].isChecked.value;
    update();
  }

  @override
  void toggleTodoIsFold(String date, int index) {
    _constantTodoList[index].isFold.value =
    !_constantTodoList[index].isFold.value;
  }

  @override
  bool isCategoryModel(String date, int index) {
    if (categoryIndexMap.contains(index)) {
      return true;
    } else {
      return false;
    }
  }

  Color todoColor(String date, int index) {
    return Palette.peepGreen;
  }

  getTodoCategory(int index) {
    int i = 0;
    for (; i < categoryIndexMap.length - 1; i++) {
      if (categoryIndexMap[i] < index &&
          categoryIndexMap[i + 1] > index) {
        return categoryIndexMap[i];
      }
    }
    return categoryIndexMap[i];
  }

  void updateCategoryIndexMap() {
    List<int> newCategoryIndexMap = [];

    for (int i = 0; i < _constantTodoList.length; i++) {
      if (_constantTodoList[i] is CategoryModel) {
        newCategoryIndexMap.add(i);
      }
    }

    categoryIndexMap.value = newCategoryIndexMap;
  }
}
