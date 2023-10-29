import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:peep_todo_flutter/app/data/model/todo/sub_todo_model.dart';

class TodoModel {
  final int id;
  final int categoryId;
  final int? reminderId;
  final String name;
  final List<SubTodoModel>? subTodo;
  final String? date;
  final int priority;
  final String? memo;
  final RxBool isFold;
  final RxBool isChecked;

  TodoModel(
      {required this.id,
      required this.categoryId,
      required this.reminderId,
      required this.name,
      required this.subTodo,
      required this.date,
      required this.priority,
      required this.memo,
      required this.isFold,
      required this.isChecked});
}
