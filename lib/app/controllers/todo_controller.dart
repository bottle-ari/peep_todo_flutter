import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/data/mock_data.dart';
import 'package:peep_todo_flutter/app/data/model/category_model.dart';
import 'package:peep_todo_flutter/app/data/model/todo_model.dart';

class TodoController extends GetxController {
  // TODO : 현재는 Mock 데이터가 들어가 있으므로, 추후 변경 필요
  final List<TodoModel> todos = mockTodos;
  final List<CategoryModel> categories = mockCategories;

  CategoryModel getCategoryOfTodo(TodoModel todo) {
    return categories.firstWhere((category) => category.id == todo.categoryId);
  }
}