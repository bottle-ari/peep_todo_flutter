import 'package:peep_todo_flutter/app/data/model/todo/sub_todo_model.dart';

class TodoModel {
  final int id;
  final int categoryId;
  final int? reminderId;
  final String name;
  final DateTime? completedAt;
  final List<SubTodoModel>? subTodo;
  final String? date;
  final int priority;
  final String? memo;
  final int order;

  TodoModel({required this.id,
    required this.categoryId,
    required this.reminderId,
    required this.name,
    required this.completedAt,
    required this.subTodo,
    required this.date,
    required this.priority,
    required this.memo,
    required this.order});
}
