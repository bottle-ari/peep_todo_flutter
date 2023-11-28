import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/overdue_todo_controller.dart';
import 'package:peep_todo_flutter/app/controllers/page/scheduled_todo_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_view.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_square_button.dart';
import 'package:peep_todo_flutter/app/views/common/peep_subpage_appbar.dart';
import 'package:peep_todo_flutter/app/views/common/popup/confirm_popup.dart';
import 'package:peep_todo_flutter/app/views/todo/widget/peep_overdue_todo_item.dart';

import '../../../theme/app_values.dart';
import '../../../theme/icons.dart';

class OverdueTodoPage extends BaseView<OverdueTodoController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(AppValues.appbarHeight),
        child: SafeArea(
          child: PeepSubpageAppbar(
              title: '지연된 할일',
              onTapBackArrow: () {
                Get.back();
              }),
        ));
  }

  @override
  Widget body(BuildContext context) {
    final ScheduledTodoController controller = Get.find();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: AppValues.verticalMargin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PeepSquareButton(
                    icon: PeepIcon(
                      Iconsax.clipboardCheckBold,
                      color:
                          Palette.peepGreen.withOpacity(AppValues.baseOpacity),
                      size: AppValues.largeIconSize,
                    ),
                    text: '모두 확인',
                    onTap: () {}),
                PeepSquareButton(
                    icon: PeepIcon(
                      Iconsax.clipboardDelete,
                      color: Palette.peepRed.withOpacity(AppValues.baseOpacity),
                      size: AppValues.largeIconSize,
                    ),
                    text: '모두 삭제',
                    onTap: () {
                      Get.dialog(ConfirmPopup(
                        icon: Iconsax.clipboardDelete,
                        text: '모두 삭제',
                        confirmText: '삭제',
                        color: Palette.peepRed,
                        func: () {},
                      ));
                    }),
                PeepSquareButton(
                    icon: PeepIcon(
                      Iconsax.clockBold,
                      color:
                          Palette.peepBlue.withOpacity(AppValues.baseOpacity),
                      size: AppValues.largeIconSize,
                    ),
                    text: '오늘 하기',
                    onTap: () {}),
              ],
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Text(
            '7월 23일',
            style: PeepTextStyle.boldL(color: Palette.peepRed),
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(vertical: 10.h),
          //   child: PeepOverdueTodoItem(
          //       color: Palette.peepGreen,
          //       index: 2,
          //       controller: controller,
          //       date: '20231116'),
          // )
        ],
      ),
    );
  }
}
