import 'package:flutter/material.dart';
import 'package:peep_todo_flutter/app/views/common/todo/peep_todo_base.dart';

import '../../../data/model/todo/todo_model.dart';
import '../../../theme/app_values.dart';

class PeepTodoList extends StatelessWidget {
  final Color color;
  final List<TodoModel> todoList;

  const PeepTodoList({super.key, required this.color, required this.todoList});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppValues.screenWidth - AppValues.screenPadding * 2,
      child: ReorderableListView(
        onReorder: (int oldInx, int newInx) {
          if (newInx > oldInx) {
            newInx -= 1;
          }
          final TodoModel item = todoList.removeAt(oldInx);
          todoList.insert(newInx, item);
        },
        buildDefaultDragHandles: false,
        children: todoList.map((e) => _buildListItem(e)).toList(),
      ),
    );
  }

  Widget _buildListItem(TodoModel todo) {
    return PeepTodoBase(
      key: ValueKey(todo.id),
      todo: todo,
      color: color,
    );
  }
}
