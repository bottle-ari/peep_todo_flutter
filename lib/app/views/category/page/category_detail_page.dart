import 'dart:developer';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/preferred_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/category_detail_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_view.dart';
import 'package:peep_todo_flutter/app/data/enums/todo_enum.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_half_toggle_button.dart';

import '../../../theme/app_values.dart';
import '../../../theme/icons.dart';
import '../../../theme/palette.dart';
import '../../../utils/device_util.dart';
import '../../common/buttons/peep_animation_effect.dart';
import '../../common/painter/bubble_painter.dart';
import '../../common/peep_subpage_appbar.dart';
import '../../common/popup/peep_confirm_popup.dart';
import '../../todo/widget/peep_button_textfield.dart';

class CategoryDetailPage extends BaseView<CategoryDetailController> {
  @override
  bool? get resizeToAvoidBottomInset => false;

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(AppValues.appbarHeight),
        child: SafeArea(
          child: PeepSubpageAppbar(
            title: '카테고리 상세',
            onTapBackArrow: () {
              Get.back();
            },
            buttons: [
              PeepAnimationEffect(
                onTap: () {
                  Get.dialog(PeepConfirmPopup(
                      icon: Iconsax.trashBold,
                      text: '삭제',
                      confirmText: '삭제',
                      color: Palette.peepRed,
                      func: () {
                        Get.back();
                        //TODO : 카테고리 삭제 기능 넣기
                      }));
                },
                child: PeepIcon(
                  Iconsax.trash,
                  size: AppValues.baseIconSize,
                  color: Palette.peepRed,
                ),
              ),
            ],
          ),
        ));
  }

  @override
  Widget body(BuildContext context) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PeepHalfToggleButton(
                    textOn: "날짜 지정",
                    textOff: "상시 보이기",
                    onToggle: () => controller.toggleTodoType(),
                    backgroundColorOn: Palette.peepWhite,
                    backgroundColorOff: Palette.peepWhite,
                    textColorOn: Palette.peepGray500,
                    textColorOff: Palette.peepGray500,
                    icon: controller.category.value.type == TodoType.scheduled
                        ? PeepIcon(
                            Iconsax.calendar,
                            size: AppValues.baseIconSize,
                            color: Palette.peepGray500,
                          )
                        : PeepIcon(
                            Iconsax.constantTodo,
                            size: AppValues.baseIconSize,
                            color: Palette.peepGray500,
                          ),
                    toggleState:
                        controller.category.value.type == TodoType.scheduled),
                PeepHalfToggleButton(
                    textOn: "사용 중",
                    textOff: "사용 안함",
                    onToggle: () => controller.toggleCategoryActiveState(),
                    backgroundColorOn: controller.category.value.color,
                    backgroundColorOff: Palette.peepGray100,
                    textColorOn: getTextColor(controller.category.value.color),
                    textColorOff: Palette.peepGray300,
                    toggleState: controller.category.value.isActive)
              ],
            ),
            if (true)
              Padding(
                padding: EdgeInsets.symmetric(vertical: AppValues.innerMargin),
                child: PeepAnimationEffect(
                  onLongPress: () {
                    // TODO : 힌트 메시지 가리기
                  },
                  scale: 0.95,
                  child: CustomPaint(
                    size: Size(20.w, 50.h),
                    painter: BubbleTopLeftPainter(
                        backgroundColor: Palette.peepGray100),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: AppValues.screenPadding,
                        top: AppValues.verticalMargin,
                        right: AppValues.screenPadding,
                      ),
                      child: Text(
                        controller.category.value.type == TodoType.scheduled
                            ? "날짜 지정 카테고리는 할 일을 추가할 때\n꼭 날짜 정보를 포함해야 해요"
                            : "상시 보이기 카테고리는 할 일을 완료했을 때\n완료한 날짜를 기준으로 날짜 정보를 추가해요",
                        style:
                            PeepTextStyle.regularS(color: Palette.peepGray400),
                      ),
                    ),
                  ),
                ),
              ),
            SizedBox(
              height: AppValues.verticalMargin,
            ),
            PeepCategoryTextfield(
              controller: controller,
            ),
          ],
        ),
      ),
    );
  }
}
