import 'package:peep_todo_flutter/app/data/enums/todo_enum.dart';
import 'package:peep_todo_flutter/app/data/model/todo/todo_model.dart';

class BackupTodoModel {
  final TodoModel backupTodoItem;
  final int backupIndex;
  final DateTime? backupDate;

  BackupTodoModel(
      {required this.backupTodoItem,
      required this.backupIndex,
      required this.backupDate});
}
