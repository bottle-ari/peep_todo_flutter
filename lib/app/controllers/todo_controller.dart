import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/data/services/todo_service.dart';

import '../data/model/todo/todo_model.dart';

class TodoController extends GetxController {
  final TodoService _service = TodoService();

  // Data
  final RxList<TodoModel> scheduledTodoList = <TodoModel>[].obs;

  // Variables
  final Rx<DateTime> selectDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();

    ever(selectDate, (_) => loadScheduledData());

    loadScheduledData();
  }

  /*
    Init Functions
   */
  void loadScheduledData() async {
    final DateTime startDate =
        selectDate.value.subtract(const Duration(days: 60));
    final DateTime endDate = selectDate.value.add(const Duration(days: 60));

    var data = await _service.getScheduledTodoByDate(
        startDate: startDate, endDate: endDate);
    scheduledTodoList.value = data;
  }

  /*
    READ Functions
   */
  Future<TodoModel> getTodo({required int todoId}) async {
    return await _service.getTodo(todoId: todoId);
  }

  /*
    UPDATE Functions
   */
  void toggleMainTodoChecked({required int todoId}) async {
    TodoModel todo = await getTodo(todoId: todoId);

    todo.isChecked = !todo.isChecked;

    await _service.updateTodo(todo);
  }
}
