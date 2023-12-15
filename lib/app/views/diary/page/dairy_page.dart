import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:peep_todo_flutter/app/controllers/main/main_controller.dart';
import 'package:peep_todo_flutter/app/data/enums/todo_enum.dart';
import 'package:peep_todo_flutter/app/data/model/category/category_model.dart';
import 'package:peep_todo_flutter/app/data/model/enum/menu_state.dart';
import 'package:peep_todo_flutter/app/data/model/todo/todo_model.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_animation_effect.dart';
import 'package:peep_todo_flutter/app/views/todo/widget/peep_mini_calendar.dart';

import '../../../controllers/main/peep_main_toggle_button_controller.dart';
import '../../../controllers/page/diary_controller.dart';
import '../../../core/base/base_view.dart';

class DiaryPage extends BaseView<DiaryController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    final PeepMainToggleButtonController mainToggleButtonController =
        Get.find();
    final MainController mainController = Get.find();

    return Obx(
      () {
        return SizedBox(
          height: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
            child: Column(
              children: [
                Center(
                    child: PeepAnimationEffect(
                  onTap: () {
                    controller.onMoveToday();
                  },
                  child: Text(
                    DateFormat('MM월 dd일').format(controller.getSelectedDate()),
                    style: PeepTextStyle.boldM(color: Palette.peepGray500),
                  ),
                )),
                Padding(
                  padding: EdgeInsets.only(bottom: AppValues.verticalMargin),
                  child: PeepMiniCalendar(),
                ),
                Expanded(
                  child: Column(
                    children: [
                      PeepAnimationEffect(
                        onTap: () {},
                        scale: 0.95,
                        child: Container(
                          height: 36.h,
                          decoration: BoxDecoration(
                            color: Palette.peepGray50,
                            border: Border.all(color: Palette.peepGray200),
                            borderRadius:
                                BorderRadius.circular(AppValues.baseRadius),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PeepIcon(
                                Iconsax.image,
                                size: AppValues.smallIconSize,
                                color: Palette.peepGray400,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: AppValues.horizontalMargin),
                                child: Text(
                                  "사진 추가",
                                  style: PeepTextStyle.regularS(
                                      color: Palette.peepGray400),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: AppValues.verticalMargin,
                      ),
                      for (var todo in controller.checkedTodo)
                        Padding(
                          padding:
                              EdgeInsets.only(bottom: AppValues.innerMargin),
                          child: Row(
                            children: [
                              PeepIcon(
                                Iconsax.checkTrue,
                                size: AppValues.smallIconSize,
                                color: todo.color,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: AppValues.horizontalMargin),
                                child: Text(
                                  todo.name,
                                  style: PeepTextStyle.regularS(
                                      color: Palette.peepBlack),
                                ),
                              )
                            ],
                          ),
                        ),
                      const Divider(
                        color: Palette.peepGray200,
                      ),
                      Expanded(
                        child: TextField(
                          decoration:
                              InputDecoration(hintText: "오늘의 일기를 작성하세요!"),
                          maxLines: null,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
