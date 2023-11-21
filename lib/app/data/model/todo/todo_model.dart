import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:peep_todo_flutter/app/data/model/todo/sub_todo_model.dart';

class TodoModel {
  final int id;
  int categoryId;
  int? reminderId;
   String name;
  List<SubTodoModel>? subTodo;
  DateTime date;
  int priority;
  String? memo;
  bool isFold;
  bool isChecked;

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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryId': categoryId,
      'reminderId': reminderId,
      'name': name,
      'date': date.millisecondsSinceEpoch,
      'priority': priority,
      'memo': memo,
      'is_fold': isFold ? 1 : 0,
      'is_checked': isChecked ? 1 : 0
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'],
      categoryId: map['category_id'],
      reminderId: map['reminder_id'],
      name: map['name'],
      subTodo: null, // 이 부분은 별도로 처리해야 합니다.
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      priority: map['priority'],
      memo: map['memo'],
      isFold: (map['is_fold'] == 1),
      isChecked: (map['is_checked'] == 1),
    );
  }
}
