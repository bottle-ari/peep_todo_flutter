import 'dart:developer';

import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/data/mock_data.dart';
import 'package:peep_todo_flutter/app/data/model/todo/todo_model.dart';

class TodoController extends GetxController {
  // TODO : 현재는 Mock 데이터가 들어가 있으므로, 추후 변경 필요
  final RxList<TodoModel> _todoList = mockTodos.obs;

  // Getter
  RxList<TodoModel> get todoList => _todoList;

  // Setter
  void reorderTodoList(int oldIndex, int newIndex) {
    TodoModel todoItem = _todoList.removeAt(oldIndex);
    _todoList.insert(newIndex, todoItem);
  }

  void toggleTodoIsFold(int index) {
    _todoList[index].isFold.value = !_todoList[index].isFold.value;
  }

  void toggleMainTodoChecked(int index) {
    _todoList[index].isChecked.value = !_todoList[index].isChecked.value;
    update();
  }

  void toggleSubTodoChecked(int mainIndex, int index) {
    _todoList[mainIndex].subTodo![index].isChecked.value =
        !_todoList[mainIndex].subTodo![index].isChecked.value;
    update();
  }
}
