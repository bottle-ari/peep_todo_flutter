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
    final PeepMainToggleButtonController mainToggleButtonController = Get.find();
    final MainController mainController = Get.find();

    return Obx(
          () {
        return SizedBox(
          height: double.infinity,
          child: Padding(
            padding:
            EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
            child: Column(
              children: [
                Center(
                    child: PeepAnimationEffect(
                      onTap: () {},
                      child: Text(
                        DateFormat('MM월 dd일')
                            .format(controller.getSelectedDate()),
                        style: PeepTextStyle.boldM(color: Palette.peepGray500),
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(bottom: AppValues.verticalMargin),
                  child: SizedBox(
                    height: 90.h,
                    child: PeepMiniCalendar(),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onHorizontalDragEnd: (DragEndDetails details) {
                      if (details.primaryVelocity! > 0) {
                        mainToggleButtonController.selectedIndex.value = 0;
                        mainToggleButtonController.animationController
                            .reverse()
                            .then((value) => mainToggleButtonController.selectedIndex(0));
                        mainController.onMenuSelected(MenuState.TODO);
                      }
                    },
                    child: Container(),
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
