// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:peep_todo_flutter/app/data/model/todo/todo_model.dart';
// import 'package:peep_todo_flutter/app/theme/app_values.dart';
// import 'package:peep_todo_flutter/app/theme/icons.dart';
// import 'package:peep_todo_flutter/app/theme/palette.dart';
// import 'package:peep_todo_flutter/app/theme/text_style.dart';
// import 'package:peep_todo_flutter/app/views/common/buttons/peep_check_button.dart';
//
// import '../../../data/model/todo/sub_todo_model.dart';
//
// class PeepTodoBase extends StatelessWidget {
//   final Color color;
//   final TodoModel todo;
//   final int index;
//   final Function(int) toggleFold;
//   final bool isChecked;
//   final Function(int) toggleChecked;
//   final Function(int, int) toggleSubChecked;
//   final bool isLast;
//
//   const PeepTodoBase(
//       {super.key,
//       required this.color,
//       required this.todo,
//       required this.toggleFold,
//       required this.index,
//       required this.isChecked,
//       required this.toggleChecked,
//       required this.toggleSubChecked,
//       required this.isLast});
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => SizedBox(
//         width: AppValues.screenWidth - AppValues.screenPadding * 2,
//         child: Column(
//           children: [
//             SizedBox(
//               child: Row(
//                 children: [
//                   PeepCheckButton(
//                     color: color,
//                     index: index,
//                     isToggled: toggleChecked,
//                     isChecked: isChecked,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(left: 4.w, right: 8.w),
//                     child: GestureDetector(
//                         onTap: () {},
//                         child:
//                             Text(todo.name, style: PeepTextStyle.regularM())),
//                   ),
//                   if (todo.priority != 0)
//                     PeepIcon(
//                       Iconsax.priority,
//                       color: priorityColor(todo.priority),
//                       size: 18.w,
//                     ),
//                   Expanded(
//                     child: Align(
//                         alignment: Alignment.centerRight,
//                         child: Material(
//                           color: Colors.transparent,
//                           child: InkWell(
//                               onTap: () {
//                                 toggleFold(index);
//                               },
//                               child: PeepIcon(
//                                 todo.isFold.value
//                                     ? Iconsax.arrowCircleDown
//                                     : Iconsax.arrowCircleUp,
//                                 color: todo.subTodo != null
//                                     ? Palette.peepGray300
//                                     : Colors.transparent,
//                                 size: 24.w,
//                               )),
//                         )),
//                   ),
//                 ],
//               ),
//             ),
//             _buildSubTodoWidget(todo, color),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSubTodoWidget(TodoModel todo, Color color) {
//     if (todo.subTodo != null &&
//         todo.subTodo!.isNotEmpty &&
//         !todo.isFold.value) {
//       return Container(
//           constraints: const BoxConstraints(minHeight: 0),
//           child: PeepSubTodoBase(
//             subTodoList: todo.subTodo!,
//             color: color,
//             mainIndex: index,
//             toggleChecked: toggleSubChecked,
//             isLast: isLast,
//           ));
//     }
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Padding(
//         padding: EdgeInsets.only(left: 13.w),
//         child: isLast
//             ? Container()
//             : Container(
//                 width: 2.w,
//                 height: 10.h,
//                 color: color,
//               ),
//       ),
//     );
//   }
//
//   Color priorityColor(int value) {
//     switch (value) {
//       case 1:
//         return Palette.peepGreen;
//       case 2:
//         return Palette.peepYellow400;
//       case 3:
//         return Palette.peepRed;
//       default:
//         return Palette.peepGreen;
//     }
//   }
// }
//
// class PeepSubTodoBase extends StatelessWidget {
//   final Color color;
//   final List<SubTodoModel> subTodoList;
//   final int mainIndex;
//   final Function(int, int) toggleChecked;
//   final bool isLast;
//
//   const PeepSubTodoBase(
//       {super.key,
//       required this.subTodoList,
//       required this.color,
//       required this.toggleChecked,
//       required this.mainIndex,
//       required this.isLast});
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => SizedBox(
//         child: Column(
//           children: [
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Padding(
//                 padding: EdgeInsets.only(left: 13.w),
//                 child: isLast
//                     ? Container(height: 10.h,)
//                     : Container(
//                   width: 2.w,
//                   height: 10.h,
//                   color: color,
//                 ),
//               ),
//             ),
//             for (int inx = 0; inx < subTodoList.length; inx++)
//               PeepSubTodoBaseItem(
//                 color: color,
//                 text: subTodoList[inx].text,
//                 isChecked: subTodoList[inx].isChecked.value,
//                 toggleCheck: toggleChecked,
//                 index: inx,
//                 mainIndex: mainIndex,
//                 isLast: isLast,
//               ),
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Padding(
//                 padding: EdgeInsets.only(left: 13.w),
//                 child: isLast
//                     ? Container()
//                     : Container(
//                   width: 2.w,
//                   height: 10.h,
//                   color: color,
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // 서브 투두 단일 Item
// class PeepSubTodoBaseItem extends StatelessWidget {
//   final Color color;
//   final String text;
//   final bool isChecked;
//   final int mainIndex;
//   final int index;
//   final Function(int, int) toggleCheck;
//   final bool isLast;
//
//   const PeepSubTodoBaseItem(
//       {super.key,
//       required this.color,
//       required this.text,
//       required this.isChecked,
//       required this.toggleCheck,
//       required this.index,
//       required this.mainIndex, required this.isLast});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         SizedBox(
//           width: 13.w,
//         ),
//         if(isLast)
//           SizedBox(width: 2.w)
//         else
//         Container(
//           width: 2.w,
//           height: 32.h,
//           color: color,
//         ),
//         SizedBox(
//           width: 15.w,
//         ),
//         PeepCheckSubButton(
//           color: color,
//           mainIndex: mainIndex,
//           index: index,
//           isToggled: toggleCheck,
//           isChecked: isChecked,
//         ),
//         SizedBox(
//           width: 4.w,
//         ),
//         GestureDetector(
//             onTap: () {}, child: Text(text, style: PeepTextStyle.regularM())),
//       ],
//     );
//   }
// }
