import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:peep_todo_flutter/app/controllers/todo_controller.dart';

import '../../../core/base/base_view.dart';
import '../../../routes/app_pages.dart';
import '../widget/peep_todo_item.dart';

class ScheduledTodoPage extends BaseView<TodoController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: ListView(
        children: [
          PeepTodoItem(
            color: Color(0xFFBD00FF),
            index: 0,
          ),
          SizedBox(
            height: 10.h,
          ),
          PeepTodoItem(
            color: Color(0xFFBD00FF),
            index: 1,
          ),
          SizedBox(
            height: 10.h,
          ),
          PeepTodoItem(
            color: Color(0xFFBD00FF),
            index: 2,
          ),
          SizedBox(
            height: 10.h,
          ),
          PeepTodoItem(
            color: Color(0xFFBD00FF),
            index: 3,
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }

}
