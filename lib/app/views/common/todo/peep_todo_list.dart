import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/todo_controller.dart';
import 'package:peep_todo_flutter/app/views/common/todo/peep_todo_base.dart';
import 'package:reorderables/reorderables.dart';

import '../../../data/model/todo/todo_model.dart';
import '../../../theme/app_values.dart';

class PeepTodoList extends StatelessWidget {
  final Color color;
  final TodoController todoController;

  const PeepTodoList(
      {super.key, required this.color, required this.todoController});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: AppValues.screenWidth - AppValues.screenPadding * 2,
        child: CustomScrollView(
          slivers: [
            ReorderableSliverList(
              delegate: ReorderableSliverChildListDelegate([
                for (int index = 0;
                    index < todoController.todoList.length;
                    index++)
                  PeepTodoBase(
                    color: color,
                    todo: todoController.todoList[index],
                    toggleFold: todoController.toggleTodoIsFold,
                    index: index,
                    isLast: todoController.todoList.length - 1 == index,
                    isChecked: todoController.mainTodoIsChecked(index),
                    toggleChecked: todoController.toggleMainTodoChecked,
                    toggleSubChecked: todoController.toggleSubTodoChecked,
                  )
              ]),
              onReorder: (int oldIndex, int newIndex) =>
                  todoController.reorderTodoList(oldIndex, newIndex),
            ),
          ],
        ),
      ),
    );
  }
}
