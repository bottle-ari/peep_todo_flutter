import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/todo_memo_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_view.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/views/common/peep_subpage_appbar.dart';

class TodoMemoPage extends BaseView<TodoMemoController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {

    return PreferredSize(
        preferredSize: Size.fromHeight(AppValues.appbarHeight),
        child: SafeArea(
          child: PeepSubpageAppbar(
              title: '메모',
              onTapBackArrow: () {
                Get.back();
              }),
        ));
  }

  @override
  Widget body(BuildContext context) {
    final text = Get.arguments?["text"] ?? "";

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller:
                      TextEditingController(text: controller.memo.value),
                  onSubmitted: (newText) {
                    controller.memo.value = newText;
                    Get.arguments['text'] = newText;

                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
