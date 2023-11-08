import 'dart:developer';

import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/data/mock_data.dart';
import 'package:peep_todo_flutter/app/data/model/todo/todo_model.dart';

import '../core/base/base_controller.dart';
import '../data/model/todo/sub_todo_model.dart';

abstract class TodoController extends BaseController {
  @override
  List<TodoModel> getTodoList({required String date});

  @override
  List<SubTodoModel> getSubTodoList(
      {required String date, required int mainIndex});

  @override
  void reorderTodoList(String date, int oldIndex, int newIndex);

  @override
  void toggleTodoIsFold(String date, int index);

  @override
  void toggleMainTodoChecked(String date, int index);

  @override
  void toggleSubTodoChecked(String date, int mainIndex, int index);
}
