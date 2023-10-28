import 'package:peep_todo_flutter/app/data/model/todo/sub_todo_model.dart';

import 'model/category_model.dart';
import 'model/todo/todo_model.dart';

// Category에 대한 Mock Data
final List<CategoryModel> mockCategories = [
  CategoryModel(
      id: 1, userId: 1, name: '할 일', color: 'BD00FF', emoji: '🤔', order: 1),
  CategoryModel(
      id: 2, userId: 1, name: '공부', color: '00DB58', emoji: '📝', order: 2),
];

// Todo에 대한 Mock Data
final List<TodoModel> mockTodos = [
  TodoModel(
      id: 1,
      categoryId: 1,
      reminderId: null,
      name: '집가서 할 일',
      completedAt: null,
      subTodo: [
        SubTodoModel(text: '화분에 물 주기', isChecked: false),
        SubTodoModel(text: '샤워하기', isChecked: false),
        SubTodoModel(text: '스트레칭 하기', isChecked: true)
      ],
      date: '20231010',
      priority: 3,
      memo: null,
      order: 1),
  TodoModel(
      id: 2,
      categoryId: 1,
      reminderId: null,
      name: '내일 짐 정리 하기',
      completedAt: DateTime(2023, 10, 8, 14, 20),
      subTodo: [
        SubTodoModel(text: '옷 정리하기', isChecked: false),
        SubTodoModel(text: '간식 정리하기', isChecked: false),
      ],
      date: '20231010',
      priority: 0,
      memo: null,
      order: 2),
  TodoModel(
      id: 3,
      categoryId: 2,
      reminderId: null,
      name: '영어 단어 만 개 외우기',
      completedAt: DateTime(2023, 10, 8, 14, 20),
      subTodo: null,
      date: '20231010',
      priority: 0,
      memo: null,
      order: 1),
  TodoModel(
      id: 4,
      categoryId: 2,
      reminderId: null,
      name: '수학 1000 문제 풀기',
      completedAt: null,
      subTodo: null,
      date: '20231010',
      priority: 2,
      memo: '이 것은 메모입니당',
      order: 2),
];
