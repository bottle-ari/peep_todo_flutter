import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/routine_add_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_view.dart';
import 'package:peep_todo_flutter/app/data/enums/priority.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/utils/priority_util.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_half_button.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_half_toggle_button.dart';
import 'package:peep_todo_flutter/app/views/common/peep_category_tag.dart';
import 'package:peep_todo_flutter/app/views/routine/widget/peep_repeat_condition_picker.dart';
import 'package:peep_todo_flutter/app/views/routine/widget/peep_routine_text_field.dart';
import '../../../data/model/category/category_model.dart';
import '../../../theme/app_values.dart';
import '../../../theme/icons.dart';
import '../../../theme/palette.dart';
import '../../common/buttons/peep_animation_effect.dart';
import '../../common/buttons/peep_category_picker_button.dart';
import '../../common/peep_subpage_appbar.dart';
import '../../common/popup/peep_warning_popup.dart';
import 'routine_priority_picker_modal.dart';

class RoutineAddPage extends BaseView<RoutineAddController> {
  @override
  bool? get resizeToAvoidBottomInset => false;

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(AppValues.appbarHeight),
        child: SafeArea(
          child: PeepSubpageAppbar(
            title: '루틴 추가',
            onTapBackArrow: () {
              Get.back();
            },
            buttons: [
              PeepAnimationEffect(
                onTap: () {
                  var isSuccess = controller.onConfirm();

                  if (isSuccess) {
                    Get.back();
                  } else {
                    Get.dialog(PeepWarningPopup(
                        icon: Iconsax.emptyBox,
                        text: '루틴 이름을 입력해주세요!',
                        confirmText: '확인',
                        color: Palette.peepRed
                            .withOpacity(AppValues.baseOpacity)));
                  }
                },
                child: Obx(() {
                  final hslColor =
                      HSLColor.fromColor(controller.category.value.color);

                  final newLightness =
                      (hslColor.lightness - 0.3).clamp(0.0, 1.0);
                  final Color modulatedColor =
                      hslColor.withLightness(newLightness).toColor();

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
                            style: PeepTextStyle.boldXS(color: modulatedColor),
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
                PeepHalfButton(
                  color: Palette.peepWhite,
                  onTap: () {
                    Get.bottomSheet(
                      RoutinePriorityPickerModal(
                        onSelectPriority: (int selectedPriority) {
                          controller.priority.value = selectedPriority;
                        },
                        currentPriority: controller.priority.value,
                      ),
                    );
                  },
                  text: PriorityUtil.getPriority(controller.priority.value)
                      .PriorityString,
                  textColor: PriorityUtil.getPriority(controller.priority.value)
                      .PriorityColor,
                  icon: PeepIcon(
                    Iconsax.priority,
                    size: AppValues.smallIconSize,
                    color: PriorityUtil.getPriority(controller.priority.value)
                        .PriorityColor,
                  ),
                ),
                PeepHalfToggleButton(
                  textOn: "사용 중",
                  textOff: "사용 안함",
                  onToggle: () async {
                    controller.toggleActiveState();
                  },
                  backgroundColorOn: controller.category.value.color,
                  backgroundColorOff: Palette.peepGray100,
                  textColorOn:
                      getTextColorBold(controller.category.value.color),
                  textColorOff: Palette.peepGray300,
                  toggleState: controller.isActive.value,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: AppValues.verticalMargin,
              ),
              child: PeepCategoryPickerButton(
                onConfirm: (CategoryModel category) {
                  controller.category.value = category;
                },
                categoryModel: controller.category.value,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: AppValues.innerMargin,
              ),
              child: PeepRoutineTextField(
                color: controller.category.value.color,
                textEditingController: controller.textEditingController,
                focusNode: controller.focusNode,
              ),
            ),
            SizedBox(
              height: AppValues.verticalMargin * 2,
            ),
            PeepRepeatConditionPicker(
              color: controller.category.value.color,
              controller: controller.peepRepeatConditionPickerController,
            ),
          ],
        ),
      ),
    );
  }
}
