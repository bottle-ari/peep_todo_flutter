import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/core/base/base_view.dart';
import 'package:peep_todo_flutter/app/data/enums/todo_enum.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_half_toggle_button.dart';

import '../../../controllers/page/category_add_controller.dart';
import '../../../theme/app_values.dart';
import '../../../theme/icons.dart';
import '../../../theme/palette.dart';
import '../../common/buttons/peep_animation_effect.dart';
import '../../common/painter/bubble_painter.dart';
import '../../common/peep_subpage_appbar.dart';
import '../../common/popup/peep_warning_popup.dart';
import '../../todo/widget/peep_button_textfield.dart';

class CategoryAddPage extends BaseView<CategoryAddController> {
  @override
  bool? get resizeToAvoidBottomInset => false;

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(AppValues.appbarHeight),
        child: SafeArea(
          child: PeepSubpageAppbar(
            title: '카테고리 추가',
            onTapBackArrow: () {
              Get.back();
            },
            buttons: [
              PeepAnimationEffect(
                onTap: () {
                  var isSuccess = controller.onConfirm();

                  if(isSuccess) {
                    Get.back();
                  } else {
                    Get.dialog(PeepWarningPopup(
                        icon: Iconsax.emptyBox,
                        text: '카테고리 이름을 입력해주세요!',
                        confirmText: '확인',
                        color: Palette.peepRed
                            .withOpacity(AppValues.baseOpacity)));
                  }
                },
                child: Obx(() {
                  final hslColor = HSLColor.fromColor(controller.getColor());

                  final newLightness = (hslColor.lightness - 0.3).clamp(0.0, 1.0);
                  final Color modulatedColor = hslColor.withLightness(newLightness).toColor();

                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: modulatedColor),
                      borderRadius:
                          BorderRadius.circular(AppValues.smallRadius),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppValues.horizontalMargin,
                          vertical: AppValues.innerMargin),
                      child: Row(
                        children: [
                          PeepIcon(
                            Iconsax.addSquare,
                            size: AppValues.miniIconSize,
                            color: modulatedColor,
                          ),
                          SizedBox(
                            width: AppValues.innerMargin,
                          ),
                          Text(
                            "추가",
                            style: PeepTextStyle.boldXS(
                                color: modulatedColor),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
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
                    icon: controller.todoType.value == TodoType.scheduled
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
                        controller.todoType.value == TodoType.scheduled),
                PeepHalfToggleButton(
                    textOn: "사용 중",
                    textOff: "사용 안함",
                    onToggle: () async {
                      controller.toggleCategoryActiveState();
                    },
                    backgroundColorOn: controller.getColor(),
                    backgroundColorOff: Palette.peepGray100,
                    textColorOn: getTextColorBold(controller.getColor()),
                    textColorOff: Palette.peepGray300,
                    toggleState: controller.isActive.value)
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
                        controller.todoType.value == TodoType.scheduled
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
            PeepCategoryAddTextfield(
              controller: controller,
            ),
          ],
        ),
      ),
    );
  }
}
