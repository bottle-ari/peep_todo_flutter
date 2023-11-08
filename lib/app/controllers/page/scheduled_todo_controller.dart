import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/todo_controller.dart';
import 'package:peep_todo_flutter/app/data/mock_data.dart';
import 'package:peep_todo_flutter/app/data/model/todo/sub_todo_model.dart';
import 'package:peep_todo_flutter/app/data/model/todo/todo_model.dart';

class ScheduledTodoController extends TodoController {
  // TODO : 현재는 Mock 데이터가 들어가 있으므로, 추후 변경 필요
  final RxMap<String, List<TodoModel>> _todoList = mockTodos.obs;

  @override
  List<TodoModel> getTodoList({required String date}) {
    return _todoList[date] ?? [];
  }

  @override
  List<SubTodoModel> getSubTodoList(
      {required String date, required int mainIndex}) {
    if (_todoList[date] == null) {
      return [];
    } else {
      return _todoList[date]![mainIndex].subTodo ?? [];
    }
  }

  @override
  void toggleTodoIsFold(String date, int index) {
    if (_todoList[date] == null) return;
    _todoList[date]![index].isFold.value =
        !_todoList[date]![index].isFold.value;
  }

  @override
  void toggleMainTodoChecked(String date, int index) {
    if (_todoList[date] == null) return;
    _todoList[date]![index].isChecked.value =
        !_todoList[date]![index].isChecked.value;
    update();
  }

  @override
  void toggleSubTodoChecked(String date, int mainIndex, int index) {
    if (_todoList[date] == null) return;
    _todoList[date]![mainIndex].subTodo![index].isChecked.value =
        !_todoList[date]![mainIndex].subTodo![index].isChecked.value;
    update();
  }

  @override
  void reorderTodoList(String date, int oldIndex, int newIndex) {
    if (_todoList[date] == null) return;

    var list = _todoList[date]!;
    final TodoModel todoItem = list.removeAt(oldIndex);

    list.insert(newIndex, todoItem);
    _todoList[date] = List.from(list);

    update();
  }
}
