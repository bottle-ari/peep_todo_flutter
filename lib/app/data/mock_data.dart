// import 'dart:ui';
// import 'package:get/get.dart';
// import 'package:peep_todo_flutter/app/data/model/todo/sub_todo_model.dart';
// import 'model/category_model.dart';
// import 'model/todo/todo_model.dart';
//
// /// category 관련 함수들 ///
// /*
//   add Category Model
// */
// void addCategoryModel(CategoryModel model) {
//   mockCategories.add(model);
// }
//
// /*
//   reorder Category Model
// */
// void reorderCategoryModel(oldIndex, newIndex) {
//   var list = mockCategories;
//
//   final CategoryModel categoryItem = list.removeAt(oldIndex);
//   list.insert(newIndex, categoryItem);
//
//   mockCategories = List.from(list);
// }
//
// /*
//   change category color
// */
// void changeCategoryModelColor(int index, Color newColor) {
//   mockCategories[index].color = newColor;
// }
//
// // Category에 대한 Mock Data
// List<CategoryModel> mockCategories = [
//   CategoryModel(
//     id: 1,
//     name: '할 일',
//     color: const Color(0XFFBD00FF),
//     emoji: '🤔',
//   ),
//   CategoryModel(
//     id: 2,
//     name: '공부',
//     color: const Color(0XFF00DB58),
//     emoji: '📝',
//   ),
//   CategoryModel(
//     id: 3,
//     name: '테스트',
//     color: const Color(0XFF4685FF),
//     emoji: '🥳',
//   ),
// ];
//
// // Todo에 대한 Mock Data
// final Map<String, List<TodoModel>> mockTodos = {
//   'constant': [
//     TodoModel(
//         id: 101,
//         categoryId: 1,
//         reminderId: null,
//         name:
//         '매우 긴 사이즈의 투두 제목 매우 긴 사이즈의 투두 제목  매우 긴 사이즈의 투두 제목 매우 긴 사이즈의 투두 제목',
//         subTodo: [
//           SubTodoModel(text: '화분에 물 주기'.obs, isChecked: false.obs),
//           SubTodoModel(text: '샤워하기'.obs, isChecked: false.obs),
//           SubTodoModel(
//               text:
//               '매우 긴 사이즈의 투두 제목 매우 긴 사이즈의 투두 제목  매우 긴 사이즈의 투두 제목 매우 긴 사이즈의 투두 제목'
//                   .obs,
//               isChecked: true.obs)
//         ].obs,
//         date: '20231010',
//         priority: 3,
//         memo: null,
//         isFold: false.obs,
//         isChecked: false.obs),
//     TodoModel(
//         id: 102,
//         categoryId: 1,
//         reminderId: null,
//         name: '내일 짐 정리 하기',
//         subTodo: [
//           SubTodoModel(text: '옷 정리하기'.obs, isChecked: false.obs),
//           SubTodoModel(text: '간식 정리하기'.obs, isChecked: false.obs),
//         ].obs,
//         date: '20231010',
//         priority: 0,
//         memo: null,
//         isFold: true.obs,
//         isChecked: true.obs),
//     TodoModel(
//         id: 103,
//         categoryId: 2,
//         reminderId: null,
//         name: '영어 단어 만 개 외우기',
//         subTodo: null,
//         date: '20231010',
//         priority: 1,
//         memo: null,
//         isFold: false.obs,
//         isChecked: true.obs),
//     TodoModel(
//         id: 104,
//         categoryId: 2,
//         reminderId: null,
//         name: '수학 1000 문제 풀기',
//         subTodo: null,
//         date: '20231010',
//         priority: 2,
//         memo: '이 것은 메모입니당',
//         isFold: false.obs,
//         isChecked: false.obs),
//     TodoModel(
//         id: 105,
//         categoryId: 3,
//         reminderId: null,
//         name: '테스트1',
//         subTodo: [
//           SubTodoModel(text: '서브 투두 1'.obs, isChecked: false.obs),
//           SubTodoModel(text: '서브 투두 2'.obs, isChecked: false.obs),
//         ].obs,
//         date: '20231010',
//         priority: 2,
//         memo: '이 것은 메모입니당',
//         isFold: true.obs,
//         isChecked: false.obs),
//     TodoModel(
//         id: 106,
//         categoryId: 3,
//         reminderId: null,
//         name: '테스트2',
//         subTodo: [
//           SubTodoModel(text: '서브 투두 1'.obs, isChecked: false.obs),
//           SubTodoModel(text: '서브 투두 2'.obs, isChecked: false.obs),
//         ].obs,
//         date: '20231010',
//         priority: 2,
//         memo: '이 것은 메모입니당',
//         isFold: true.obs,
//         isChecked: false.obs),
//     TodoModel(
//         id: 107,
//         categoryId: 3,
//         reminderId: null,
//         name: '테스트3',
//         subTodo: [
//           SubTodoModel(text: '서브 투두 1'.obs, isChecked: false.obs),
//           SubTodoModel(text: '서브 투두 2'.obs, isChecked: false.obs),
//         ].obs,
//         date: '20231010',
//         priority: 2,
//         memo: '이 것은 메모입니당',
//         isFold: true.obs,
//         isChecked: false.obs),
//   ],
//   '20231115': [
//     TodoModel(
//         id: 1,
//         categoryId: 1,
//         reminderId: null,
//         name:
//             '매우 긴 사이즈의 투두 제목 매우 긴 사이즈의 투두 제목  매우 긴 사이즈의 투두 제목 매우 긴 사이즈의 투두 제목',
//         subTodo: [
//           SubTodoModel(text: '화분에 물 주기'.obs, isChecked: false.obs),
//           SubTodoModel(text: '샤워하기'.obs, isChecked: false.obs),
//           SubTodoModel(
//               text:
//                   '매우 긴 사이즈의 투두 제목 매우 긴 사이즈의 투두 제목  매우 긴 사이즈의 투두 제목 매우 긴 사이즈의 투두 제목'
//                       .obs,
//               isChecked: true.obs)
//         ].obs,
//         date: '20231010',
//         priority: 3,
//         memo: null,
//         isFold: false.obs,
//         isChecked: false.obs),
//     TodoModel(
//         id: 2,
//         categoryId: 1,
//         reminderId: null,
//         name: '내일 짐 정리 하기',
//         subTodo: [
//           SubTodoModel(text: '옷 정리하기'.obs, isChecked: false.obs),
//           SubTodoModel(text: '간식 정리하기'.obs, isChecked: false.obs),
//         ].obs,
//         date: '20231010',
//         priority: 0,
//         memo: null,
//         isFold: true.obs,
//         isChecked: true.obs),
//     TodoModel(
//         id: 3,
//         categoryId: 2,
//         reminderId: null,
//         name: '영어 단어 만 개 외우기',
//         subTodo: null,
//         date: '20231010',
//         priority: 1,
//         memo: null,
//         isFold: false.obs,
//         isChecked: true.obs),
//     TodoModel(
//         id: 4,
//         categoryId: 2,
//         reminderId: null,
//         name: '수학 1000 문제 풀기',
//         subTodo: null,
//         date: '20231010',
//         priority: 2,
//         memo: '이 것은 메모입니당',
//         isFold: false.obs,
//         isChecked: false.obs),
//     TodoModel(
//         id: 5,
//         categoryId: 3,
//         reminderId: null,
//         name: '테스트1',
//         subTodo: [
//           SubTodoModel(text: '서브 투두 1'.obs, isChecked: false.obs),
//           SubTodoModel(text: '서브 투두 2'.obs, isChecked: false.obs),
//         ].obs,
//         date: '20231010',
//         priority: 2,
//         memo: '이 것은 메모입니당',
//         isFold: true.obs,
//         isChecked: false.obs),
//     TodoModel(
//         id: 6,
//         categoryId: 3,
//         reminderId: null,
//         name: '테스트2',
//         subTodo: [
//           SubTodoModel(text: '서브 투두 1'.obs, isChecked: false.obs),
//           SubTodoModel(text: '서브 투두 2'.obs, isChecked: false.obs),
//         ].obs,
//         date: '20231010',
//         priority: 2,
//         memo: '이 것은 메모입니당',
//         isFold: true.obs,
//         isChecked: false.obs),
//     TodoModel(
//         id: 7,
//         categoryId: 3,
//         reminderId: null,
//         name: '테스트3',
//         subTodo: [
//           SubTodoModel(text: '서브 투두 1'.obs, isChecked: false.obs),
//           SubTodoModel(text: '서브 투두 2'.obs, isChecked: false.obs),
//         ].obs,
//         date: '20231010',
//         priority: 2,
//         memo: '이 것은 메모입니당',
//         isFold: true.obs,
//         isChecked: false.obs),
//     TodoModel(
//         id: 8,
//         categoryId: 3,
//         reminderId: null,
//         name: '테스트4',
//         subTodo: [
//           SubTodoModel(text: '서브 투두 1'.obs, isChecked: false.obs),
//           SubTodoModel(text: '서브 투두 2'.obs, isChecked: false.obs),
//         ].obs,
//         date: '20231010',
//         priority: 2,
//         memo: '이 것은 메모입니당',
//         isFold: true.obs,
//         isChecked: false.obs),
//     TodoModel(
//         id: 9,
//         categoryId: 3,
//         reminderId: null,
//         name: '테스트5',
//         subTodo: [
//           SubTodoModel(text: '서브 투두 1'.obs, isChecked: false.obs),
//           SubTodoModel(text: '서브 투두 2'.obs, isChecked: false.obs),
//         ].obs,
//         date: '20231010',
//         priority: 2,
//         memo: '이 것은 메모입니당',
//         isFold: true.obs,
//         isChecked: false.obs),
//     TodoModel(
//         id: 10,
//         categoryId: 3,
//         reminderId: null,
//         name: '테스트6',
//         subTodo: [
//           SubTodoModel(text: '서브 투두 1'.obs, isChecked: false.obs),
//           SubTodoModel(text: '서브 투두 2'.obs, isChecked: false.obs),
//         ].obs,
//         date: '20231010',
//         priority: 2,
//         memo: '이 것은 메모입니당',
//         isFold: true.obs,
//         isChecked: false.obs),
//     TodoModel(
//         id: 11,
//         categoryId: 3,
//         reminderId: null,
//         name: '테스트7',
//         subTodo: [
//           SubTodoModel(text: '서브 투두 1'.obs, isChecked: false.obs),
//           SubTodoModel(text: '서브 투두 2'.obs, isChecked: false.obs),
//         ].obs,
//         date: '20231010',
//         priority: 2,
//         memo: '이 것은 메모입니당',
//         isFold: true.obs,
//         isChecked: false.obs),
//   ],
//   '20231116': [
//     TodoModel(
//         id: 20,
//         categoryId: 1,
//         reminderId: null,
//         name: '테스트',
//         subTodo: [
//           SubTodoModel(text: '서브 투두 1'.obs, isChecked: false.obs),
//           SubTodoModel(text: '서브 투두 2'.obs, isChecked: false.obs),
//         ].obs,
//         date: '20231010',
//         priority: 2,
//         memo: '이 것은 메모입니당',
//         isFold: true.obs,
//         isChecked: true.obs),
//     TodoModel(
//         id: 21,
//         categoryId: 1,
//         reminderId: null,
//         name: '테스트',
//         subTodo: [
//           SubTodoModel(text: '서브 투두 1'.obs, isChecked: false.obs),
//           SubTodoModel(text: '서브 투두 2'.obs, isChecked: false.obs),
//         ].obs,
//         date: '20231010',
//         priority: 2,
//         memo: '이 것은 메모입니당',
//         isFold: true.obs,
//         isChecked: false.obs),
//     TodoModel(
//         id: 22,
//         categoryId: 2,
//         reminderId: null,
//         name: '테스트2',
//         subTodo: [
//           SubTodoModel(text: '서브 투두 1'.obs, isChecked: false.obs),
//           SubTodoModel(text: '서브 투두 2'.obs, isChecked: false.obs),
//         ].obs,
//         date: '20231010',
//         priority: 2,
//         memo: '이 것은 메모입니당',
//         isFold: true.obs,
//         isChecked: true.obs),
//   ],
//   '20231118': [
//     TodoModel(
//         id: 30,
//         categoryId: 1,
//         reminderId: null,
//         name: '테스트',
//         subTodo: [
//           SubTodoModel(text: '서브 투두 1'.obs, isChecked: false.obs),
//           SubTodoModel(text: '서브 투두 2'.obs, isChecked: false.obs),
//         ].obs,
//         date: '20231010',
//         priority: 2,
//         memo: '이 것은 메모입니당',
//         isFold: true.obs,
//         isChecked: true.obs),
//     TodoModel(
//         id: 31,
//         categoryId: 2,
//         reminderId: null,
//         name: '테스트',
//         subTodo: [
//           SubTodoModel(text: '서브 투두 1'.obs, isChecked: false.obs),
//           SubTodoModel(text: '서브 투두 2'.obs, isChecked: false.obs),
//         ].obs,
//         date: '20231010',
//         priority: 2,
//         memo: '이 것은 메모입니당',
//         isFold: true.obs,
//         isChecked: true.obs),
//     TodoModel(
//         id: 32,
//         categoryId: 3,
//         reminderId: null,
//         name: '테스트',
//         subTodo: [
//           SubTodoModel(text: '서브 투두 1'.obs, isChecked: false.obs),
//           SubTodoModel(text: '서브 투두 2'.obs, isChecked: false.obs),
//         ].obs,
//         date: '20231010',
//         priority: 2,
//         memo: '이 것은 메모입니당',
//         isFold: true.obs,
//         isChecked: false.obs),
//     TodoModel(
//         id: 33,
//         categoryId: 3,
//         reminderId: null,
//         name: '테스트2',
//         subTodo: [
//           SubTodoModel(text: '서브 투두 1'.obs, isChecked: false.obs),
//           SubTodoModel(text: '서브 투두 2'.obs, isChecked: false.obs),
//         ].obs,
//         date: '20231010',
//         priority: 2,
//         memo: '이 것은 메모입니당',
//         isFold: true.obs,
//         isChecked: true.obs),
//   ],
// };
