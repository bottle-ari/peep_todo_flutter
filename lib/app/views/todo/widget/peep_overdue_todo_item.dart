import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';

import '../../../controllers/data/todo_controller.dart';

class PeepOverdueTodoItem extends StatelessWidget {
  final TodoController controller;
  final Color color;
  final String date;
  final int index;

  const PeepOverdueTodoItem(
      {super.key,
      required this.color,
      required this.index,
      required this.controller,
      required this.date});

  @override
  Widget build(BuildContext context) {
    Color priorityColor = Palette.peepGray400;

    return Container();
    // switch (controller.getTodoList(date: date)[index].priority) {
    //   case 1:
    //     priorityColor = Palette.peepGreen;
    //     break;
    //   case 2:
    //     priorityColor = Palette.peepYellow400;
    //     break;
    //   case 3:
    //     priorityColor = Palette.peepRed;
    //     break;
    //   default:
    //     priorityColor = Palette.peepGray400;
    //     break;
    // }
    //
    // return Obx(
    //   () => Center(
    //     child: ClipRRect(
    //       borderRadius: BorderRadius.circular(AppValues.baseRadius),
    //       child: Dismissible(
    //         key: UniqueKey(),
    //         background: Container(
    //           color: color,
    //           alignment: Alignment.centerLeft,
    //           child: Padding(
    //             padding: EdgeInsets.only(left: AppValues.horizontalMargin),
    //             child: PeepIcon(
    //               Iconsax.check,
    //               color: Palette.peepWhite,
    //               size: AppValues.baseIconSize,
    //             ),
    //           ),
    //         ),
    //         secondaryBackground: Container(
    //           color: Palette.peepRed,
    //           alignment: Alignment.centerRight,
    //           child: Padding(
    //             padding: EdgeInsets.only(right: AppValues.horizontalMargin),
    //             child: PeepIcon(
    //               Iconsax.trash,
    //               color: Palette.peepWhite,
    //               size: AppValues.baseIconSize,
    //             ),
    //           ),
    //         ),
    //         confirmDismiss: (DismissDirection direction) async {
    //           if (direction == DismissDirection.endToStart) {
    //
    //             Get.snackbar('', '',
    //                 snackPosition: SnackPosition.BOTTOM,
    //                 backgroundColor: Colors.transparent,
    //                 duration: const Duration(days: 9999999),
    //                 isDismissible: true,
    //                 reverseAnimationCurve: Curves.easeOutQuad,
    //                 barBlur: 0,
    //                 titleText: PeepRollbackSnackbar(
    //                     icon: PeepIcon(
    //                       Iconsax.trash,
    //                       size: AppValues.baseIconSize,
    //                       color: Palette.peepRed,
    //                     ),
    //                     boldText:
    //                         controller.getTodoList(date: date)[index].name,
    //                     regularText: '삭제!',
    //                     onTapRollback: () {
    //                       Get.back();
    //                     }));
    //             return true;
    //           } else {
    //             controller.toggleMainTodoChecked(date, index);
    //
    //             Get.snackbar('', '',
    //                 snackPosition: SnackPosition.BOTTOM,
    //                 backgroundColor: Colors.transparent,
    //                 duration: const Duration(days: 9999999),
    //                 isDismissible: true,
    //                 reverseAnimationCurve: Curves.easeOutQuad,
    //                 barBlur: 0,
    //                 titleText: PeepRollbackSnackbar(
    //                     icon: PeepIcon(
    //                       Iconsax.checkTrue,
    //                       size: AppValues.baseIconSize,
    //                       color: Palette.peepGreen,
    //                     ),
    //                     boldText:
    //                     controller.getTodoList(date: date)[index].name,
    //                     regularText: '완료!',
    //                     onTapRollback: () {
    //                       Get.back();
    //                     }));
    //             return true;
    //           }
    //         },
    //         child: SizedBox(
    //           width: AppValues.screenWidth - AppValues.screenPadding * 2,
    //           child: ConstrainedBox(
    //             constraints:
    //                 BoxConstraints(minHeight: AppValues.baseItemHeight),
    //             child: Container(
    //               color: Palette.peepWhite,
    //               child: Padding(
    //                 padding:
    //                     EdgeInsets.symmetric(horizontal: AppValues.innerMargin),
    //                 child: Column(
    //                   mainAxisSize: MainAxisSize.min,
    //                   children: <Widget>[
    //                     Row(
    //                       children: [
    //                         if ((controller
    //                                     .getTodoList(date: date)[index]
    //                                     .subTodo
    //                                     ?.length ??
    //                                 0) ==
    //                             0)
    //                           Padding(
    //                             padding: EdgeInsets.symmetric(
    //                               horizontal: AppValues.horizontalMargin,
    //                             ),
    //                             child: PeepIcon(
    //                               Iconsax.egg,
    //                               size: AppValues.baseIconSize,
    //                               color: priorityColor,
    //                             ),
    //                           )
    //                         else
    //                           PeepPriorityFoldingButton(
    //                             date: date,
    //                             index: index,
    //                             color: priorityColor,
    //                             controller: controller,
    //                           ),
    //                         InkWell(
    //                           onTap: () {
    //                             //Todo 페이지 이동
    //                             log("페이지 이동");
    //                           },
    //                           child: Padding(
    //                             padding: EdgeInsets.symmetric(
    //                                 vertical: AppValues.verticalMargin),
    //                             child: SizedBox(
    //                               width: 230.w,
    //                               child: Text(
    //                                 controller
    //                                     .getTodoList(date: date)[index]
    //                                     .name,
    //                                 style: PeepTextStyle.regularM(
    //                                         color: controller
    //                                                 .getTodoList(
    //                                                     date: date)[index]
    //                                                 .isChecked
    //                                                 .value
    //                                             ? Palette.peepGray400
    //                                             : Palette.peepBlack)
    //                                     .copyWith(
    //                                   decoration: controller
    //                                           .getTodoList(date: date)[index]
    //                                           .isChecked
    //                                           .value
    //                                       ? TextDecoration.lineThrough
    //                                       : TextDecoration.none,
    //                                 ),
    //                                 overflow: TextOverflow.ellipsis,
    //                                 maxLines: 3,
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                         Flexible(
    //                           child: Align(
    //                             alignment: Alignment.centerRight,
    //                             child: Padding(
    //                               padding: EdgeInsets.symmetric(
    //                                   horizontal: AppValues.innerMargin),
    //                               child: Align(
    //                                 alignment: Alignment.centerRight,
    //                                 child: PeepCheckButton(
    //                                   color: color,
    //                                   date: date,
    //                                   index: index,
    //                                   controller: controller,
    //                                 ),
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}

// class PeepSubTodoItem extends StatelessWidget {
//   final TodoController1 controller;
//   final Color color;
//   final String date;
//   final int mainIndex;
//   final int index;
//
//   const PeepSubTodoItem(
//       {super.key,
//       required this.controller,
//       required this.mainIndex,
//       required this.index,
//       required this.color,
//       required this.date});
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => SizedBox(
//         height: 40.h,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Padding(
//               padding: EdgeInsets.only(
//                   left: AppValues.baseIconSize + AppValues.horizontalMargin * 2,
//                   top: AppValues.verticalMargin,
//                   bottom: AppValues.verticalMargin),
//               child: InkWell(
//                 onTap: () {
//                   controller.toggleSubTodoChecked(date, mainIndex, index);
//                 },
//                 child: SizedBox(
//                   width: 230.w,
//                   child: Text(
//                     controller
//                         .getSubTodoList(date: date, mainIndex: mainIndex)[index]
//                         .text
//                         .value,
//                     style: PeepTextStyle.regularM(
//                             color: controller
//                                     .getSubTodoList(
//                                         date: date, mainIndex: mainIndex)[index]
//                                     .isChecked
//                                     .value
//                                 ? Palette.peepGray400
//                                 : Palette.peepBlack)
//                         .copyWith(
//                       decoration: controller
//                               .getSubTodoList(
//                                   date: date, mainIndex: mainIndex)[index]
//                               .isChecked
//                               .value
//                           ? TextDecoration.lineThrough
//                           : TextDecoration.none,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 1,
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(right: AppValues.innerMargin + 2.w),
//               child: Align(
//                 alignment: Alignment.centerRight,
//                 child: PeepSubCheckButton(
//                   color: color,
//                   mainIndex: mainIndex,
//                   date: date,
//                   index: index,
//                   controller: controller,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
