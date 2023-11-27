import 'package:peep_todo_flutter/app/data/model/todo/sub_todo_model.dart';

class TodoModel {
  final String id;
  String categoryId;
  String? reminderId;
  String name;
  List<SubTodoModel> subTodo;
  DateTime? date;
  int priority;
  String? memo;
  bool isFold;
  bool isChecked;
  int pos;

  TodoModel({
    required this.id,
    required this.categoryId,
    required this.reminderId,
    required this.name,
    required this.subTodo,
    required this.date,
    required this.priority,
    required this.memo,
    required this.isFold,
    required this.isChecked,
    required this.pos,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category_id': categoryId,
      'reminder_id': reminderId,
      'name': name,
      'date': date?.millisecondsSinceEpoch,
      'priority': priority,
      'memo': memo,
      'is_fold': isFold ? 1 : 0,
      'is_checked': isChecked ? 1 : 0,
      'pos': pos,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'],
      categoryId: map['category_id'],
      reminderId: map['reminder_id'],
      name: map['name'],
      subTodo: [],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      priority: map['priority'],
      memo: map['memo'],
      isFold: (map['is_fold'] == 1),
      isChecked: (map['is_checked'] == 1),
      pos: map['pos'],
    );
  }
}
