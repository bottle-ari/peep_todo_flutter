import 'package:get/get.dart';
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
      name: '매우 긴 사이즈의 투두 제목 매우 긴 사이즈의 투두 제목  매우 긴 사이즈의 투두 제목 매우 긴 사이즈의 투두 제목',
      subTodo: [
        SubTodoModel(text: '화분에 물 주기'.obs, isChecked: false.obs),
        SubTodoModel(text: '샤워하기'.obs, isChecked: false.obs),
        SubTodoModel(text: '매우 긴 사이즈의 투두 제목 매우 긴 사이즈의 투두 제목  매우 긴 사이즈의 투두 제목 매우 긴 사이즈의 투두 제목'.obs, isChecked: true.obs)
      ].obs,
      date: '20231010',
      priority: 3,
      memo: null,
      isFold: false.obs,
      isChecked: false.obs),
  TodoModel(
      id: 2,
      categoryId: 1,
      reminderId: null,
      name: '내일 짐 정리 하기',
      subTodo: [
        SubTodoModel(text: '옷 정리하기'.obs, isChecked: false.obs),
        SubTodoModel(text: '간식 정리하기'.obs, isChecked: false.obs),
      ].obs,
      date: '20231010',
      priority: 0,
      memo: null,
      isFold: true.obs,
      isChecked: true.obs),
  TodoModel(
      id: 3,
      categoryId: 2,
      reminderId: null,
      name: '영어 단어 만 개 외우기',
      subTodo: null,
      date: '20231010',
      priority: 1,
      memo: null,
      isFold: false.obs,
      isChecked: true.obs),
  TodoModel(
      id: 4,
      categoryId: 2,
      reminderId: null,
      name: '수학 1000 문제 풀기',
      subTodo: null,
      date: '20231010',
      priority: 2,
      memo: '이 것은 메모입니당',
      isFold: false.obs,
      isChecked: false.obs),
];
