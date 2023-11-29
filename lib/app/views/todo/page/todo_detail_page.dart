import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/data/todo_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_view.dart';
import 'package:peep_todo_flutter/app/routes/app_pages.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/utils/priority_util.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_category_picker_button.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_half_button.dart';
import 'package:peep_todo_flutter/app/views/common/peep_subpage_appbar.dart';
import 'package:peep_todo_flutter/app/views/todo/page/priority_picker_modal.dart';
import 'package:peep_todo_flutter/app/views/todo/widget/peep_todo_detail_main_item.dart';
import 'package:peep_todo_flutter/app/views/todo/widget/peep_todo_detail_sub_item.dart';

import '../../../controllers/data/todo_detail_controller.dart';
import '../../../data/enums/priority.dart';
import '../../../data/model/todo/todo_model.dart';
import '../../../theme/app_values.dart';

class TodoDetailPage extends BaseView<TodoDetailController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(AppValues.appbarHeight),
        child: SafeArea(
          child: PeepSubpageAppbar(
              title: 'Todo 상세',
              onTapBackArrow: () {
                Get.back();
              }),
        ));
  }

  @override
  Widget body(BuildContext context) {
    TodoModel todo = Get.arguments['todo'];
    Color color = Get.arguments['color'];

    return SizedBox(
      height: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: AppValues.verticalMargin),
              child: SizedBox(
                height: 48.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PeepHalfButton(
                      color: Palette.peepWhite,
                      onTap: () {
                        Get.bottomSheet(PriorityPickerModal(controller: controller));
                      },
                      text: PriorityUtil.getPriority(todo.priority)
                          .PriorityString,
                      textColor: PriorityUtil.getPriority(todo.priority) ==
                              Priority.unspecified
                          ? Palette.peepGray400
                          : PriorityUtil.getPriority(todo.priority)
                              .PriorityColor,
                      icon: PeepIcon(
                        Iconsax.eggCracked,
                        size: AppValues.smallIconSize,
                        color: PriorityUtil.getPriority(todo.priority)
                            .PriorityColor,
                      ),
                    ),
                    PeepHalfButton(
                      // overdue -> color change 수정 필요
                      color:
                          PriorityUtil.getPriority(todo.priority).PriorityColor,
                      onTap: () => {print('on tap')},
                      text: todo.date.toString(),
                      textColor: Palette.peepWhite,
                      icon: PeepIcon(Iconsax.calendar,
                          size: AppValues.smallIconSize,
                          color: Palette.peepWhite),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 7, // listview builder 아이템 갯수
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppValues.verticalMargin,
                        horizontal: AppValues.screenPadding,
                      ),
                      child: PeepCategoryPickerButton(
                        emoji: '📝', // 임시 데이터
                        onTap: () {},
                        color: const Color(0XFF00DB58),
                        name: '공부',
                      ),
                    );
                  } else if (index == 1) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppValues.innerMargin,
                      ),
                      child: PeepTodoDetailMainItem(
                        color: color,
                        onTap: () => print('detail main item tap'),
                        text: todo.name,
                      ),
                    );
                  } else if (index == 2) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppValues.verticalMargin,
                      ),
                      child: PeepTodoDetailSubItem(
                        color: color,
                        textList: [],
                        onTap: () => log("detail sub item on tap"),
                        onTapCancel: () => log("detail sub item on tap cancel"),
                        onTapCheck: () => log("detail sub item on tap check"),
                        onTapAddSub: () =>
                            log("detail sub item on tap add sub"),
                      ),
                    );
                  } else if (index == 3) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppValues.verticalMargin,
                      ),
                      child: SizedBox(
                        width:
                            AppValues.screenWidth - AppValues.screenPadding * 2,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppValues.screenPadding +
                                  AppValues.horizontalMargin),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  PeepIcon(
                                    Iconsax.notification,
                                    color: Palette.peepBlack,
                                    size: AppValues.baseIconSize,
                                  ),
                                  SizedBox(
                                    width: AppValues.horizontalMargin,
                                  ),
                                  Text(
                                    '리마인더',
                                    style: PeepTextStyle.regularM(
                                        color: Palette.peepGray400),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else if (index == 4) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppValues.verticalMargin,
                        horizontal: AppValues.screenPadding,
                      ),
                      child: GestureDetector(
                        onTap: () => {log("onTap add reminder")},
                        child: Container(
                          width: double.infinity,
                          height: 64.h,
                          decoration: BoxDecoration(
                            color: Palette.peepWhite,
                            borderRadius:
                                BorderRadius.circular(AppValues.baseRadius),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_circle_outline,
                                size: AppValues.baseIconSize,
                                color: color,
                              ),
                              Text(
                                "리마인더 추가",
                                style: PeepTextStyle.regularM(color: color),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else if (index == 5) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppValues.verticalMargin,
                      ),
                      child: SizedBox(
                        width:
                            AppValues.screenWidth - AppValues.screenPadding * 2,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppValues.screenPadding +
                                  AppValues.horizontalMargin),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  PeepIcon(
                                    Iconsax.memo,
                                    color: Palette.peepBlack,
                                    size: AppValues.baseIconSize,
                                  ),
                                  SizedBox(
                                    width: AppValues.horizontalMargin,
                                  ),
                                  Text(
                                    '메모',
                                    style: PeepTextStyle.regularM(
                                        color: Palette.peepGray400),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else if (index == 6) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppValues.verticalMargin,
                        horizontal: AppValues.screenPadding,
                      ),
                      child: GestureDetector(
                        //Memo 페이지 이동
                        onTap: () {
                          log("페이지 이동");
                          Get.toNamed(AppPages.TODOMEMO, arguments: {
                            'text': controller.text.value,
                            'name': todo.name,
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          height: 64.h,
                          decoration: BoxDecoration(
                            color: Palette.peepWhite,
                            borderRadius:
                                BorderRadius.circular(AppValues.baseRadius),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: AppValues.screenPadding,
                                    bottom: AppValues.verticalMargin),
                                child: Text(
                                  controller.text.value,
                                  style: PeepTextStyle.regularM(
                                      color: Palette.peepGray400),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
