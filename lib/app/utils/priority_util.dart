import 'package:peep_todo_flutter/app/data/enums/priority.dart';

class PriorityUtil {
  static Priority getPriority(int priority) {
    switch (priority) {
      case 0:
        return Priority.unspecified;
      case 1:
        return Priority.low;
      case 2:
        return Priority.medium;
      case 3:
        return Priority.high;
      default:
        return Priority.unspecified;
    }
  }
}
