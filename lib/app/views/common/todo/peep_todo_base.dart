import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peep_todo_flutter/app/data/model/todo/todo_model.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_check_button.dart';

import '../../../data/model/todo/sub_todo_model.dart';

class PeepTodoBase extends StatelessWidget {
  final Color color;
  final TodoModel todo;

  const PeepTodoBase({super.key, required this.color, required this.todo});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppValues.screenWidth - AppValues.screenPadding * 2,
      child: Column(
        children: [
          SizedBox(
            child: Row(
              children: [
                PeepCheckButton(
                  color: color,
                  isToggled: () {},
                  isMain: true,
                  isChecked: false,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4.w, right: 8.w),
                  child: GestureDetector(
                      onTap: () {},
                      child: Text(todo.name, style: PeepTextStyle.regularM())),
                ),
                if (todo.priority != 0)
                  PeepIcon(
                    Iconsax.priority,
                    color: priorityColor(todo.priority),
                    size: 18.w,
                  ),
                Expanded(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: PeepIcon(
                        Iconsax.arrowCircleUp,
                        color: Palette.peepGray300,
                        size: 18.w,
                      )),
                ),
              ],
            ),
          ),
          _buildSubTodoWidget(todo, color),
        ],
      ),
    );
  }

  Widget _buildSubTodoWidget(TodoModel todo, Color color) {
    if (todo.subTodo != null && todo.subTodo!.isNotEmpty) {
      return Container(
          constraints: const BoxConstraints(minHeight: 0),
          child: PeepSubTodoBase(subTodoList: todo.subTodo!, color: color));
    }
    return Container();
  }

  Color priorityColor(int value) {
    switch (value) {
      case 1:
        return Palette.peepGreen;
      case 2:
        return Palette.peepYellow400;
      case 3:
        return Palette.peepRed;
      default:
        return Palette.peepGreen;
    }
  }
}

class PeepSubTodoBase extends StatelessWidget {
  final Color color;
  final List<SubTodoModel> subTodoList;

  const PeepSubTodoBase(
      {super.key, required this.subTodoList, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (SubTodoModel subTodo in subTodoList)
          PeepSubTodoBaseItem(
              color: color,
              text: subTodo.text,
              isChecked: subTodo.isChecked,
              toggleCheck: () {}),
      ],
    );
    //ListView.builder(
    //         itemCount: subTodoList.length,
    //         itemBuilder: (context, index) => PeepSubTodoBaseItem(
    //             color: color,
    //             text: subTodoList[index].text,
    //             isChecked: subTodoList[index].isChecked,
    //             toggleCheck: () {}))
  }
}

// 서브 투두 단일 Item
class PeepSubTodoBaseItem extends StatelessWidget {
  final Color color;
  final String text;
  final bool isChecked;
  final VoidCallback toggleCheck;

  const PeepSubTodoBaseItem(
      {super.key,
      required this.color,
      required this.text,
      required this.isChecked,
      required this.toggleCheck});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 30.w,
        ),
        PeepCheckButton(
          color: color,
          isToggled: () {
            toggleCheck();
          },
          isMain: false,
          isChecked: isChecked,
        ),
        SizedBox(
          width: 4.w,
        ),
        GestureDetector(
            onTap: () {}, child: Text(text, style: PeepTextStyle.regularM())),
      ],
    );
  }
}
