import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/todo_detail_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_view.dart';
import 'package:peep_todo_flutter/app/routes/app_pages.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/utils/priority_util.dart';
import 'package:peep_todo_flutter/app/views/category/widget/peep_emoji_picker_button.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_category_picker_button.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_half_button.dart';
import 'package:peep_todo_flutter/app/views/common/peep_category_tag.dart';
import 'package:peep_todo_flutter/app/views/common/peep_subpage_appbar.dart';
import 'package:peep_todo_flutter/app/views/todo/widget/peep_todo_detail_main_item.dart';
import 'package:peep_todo_flutter/app/views/todo/widget/peep_todo_detail_sub_item.dart';
import 'package:reorderables/reorderables.dart';

import '../../../theme/app_values.dart';
import '../widget/peep_category_item.dart';
import '../widget/peep_todo_item.dart';

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
    List<String> textList = [];
    if (Get.arguments != null && Get.arguments["subTodo"] != null) {
      for (int subIndex = 0;
          subIndex < Get.arguments["subTodo"].length;
          subIndex++) {
        String text = Get.arguments["subTodo"][subIndex].text.value;
        textList.add(text);
      }
    }

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
                    // 왼쪽 half button
                    PeepHalfButton(
                      color: Palette.peepWhite,
                      onTap: () => {print('on tap')},
                      onTapCancel: () => {print('on tap cancel')},
                      text: PriorityUtil.getPriority(Get.arguments['priority'])
                          .PriorityString,
                      textColor:
                          PriorityUtil.getPriority(Get.arguments['priority'])
                              .PriorityColor,
                      icon: PeepIcon(
                        Iconsax.egg,
                        size: AppValues.smallIconSize,
                        color:
                            PriorityUtil.getPriority(Get.arguments['priority'])
                                .PriorityColor,
                      ),
                      isDate: true,
                    ),
                    PeepHalfButton(
                      // overdue -> color change 수정 필요
                      color: PriorityUtil.getPriority(Get.arguments['priority'])
                          .PriorityColor,
                      onTap: () => {print('on tap')},
                      onTapCancel: () => {print('on tap cancel')},
                      text: Get.arguments['date'].toString(),
                      textColor: Palette.peepWhite,
                      icon: PeepIcon(Iconsax.calendar,
                          size: AppValues.smallIconSize,
                          color: Palette.peepWhite),
                      isDate: true,
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
                        color: Get.arguments["color"],
                        onTap: () => print('detail main item tap'),
                        text: Get.arguments["mainTodo"].name,
                      ),
                    );
                  } else if (index == 2) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppValues.verticalMargin,
                      ),
                      child: PeepTodoDetailSubItem(
                        color: Get.arguments["color"],
                        textList: textList,
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
                                color: Get.arguments["color"],
                              ),
                              Text(
                                "리마인더 추가",
                                style: PeepTextStyle.regularM(
                                    color: Get.arguments["color"]),
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
                            'name': Get.arguments["mainTodo"].name,
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
