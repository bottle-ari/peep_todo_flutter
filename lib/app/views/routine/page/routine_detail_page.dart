import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/core/base/base_view.dart';
import 'package:peep_todo_flutter/app/utils/priority_util.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_half_button.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_half_toggle_button.dart';
import 'package:peep_todo_flutter/app/views/routine/widget/peep_repeat_condition_picker.dart';
import 'package:peep_todo_flutter/app/views/routine/widget/peep_routine_text_field.dart';
import '../../../controllers/page/routine_detail_controller.dart';
import '../../../data/model/category/category_model.dart';
import '../../../theme/app_values.dart';
import '../../../theme/icons.dart';
import '../../../theme/palette.dart';
import '../../common/buttons/peep_animation_effect.dart';
import '../../common/buttons/peep_category_picker_button.dart';
import '../../common/peep_dropdown_menu.dart';
import '../../common/peep_subpage_appbar.dart';
import '../../common/popup/peep_confirm_popup.dart';
import 'routine_priority_picker_modal.dart';

class RoutineDetailPage extends BaseView<RoutineDetailController> {
  @override
  bool? get resizeToAvoidBottomInset => false;

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(AppValues.appbarHeight),
        child: SafeArea(
          child: PeepSubpageAppbar(
            title: '루틴 상세',
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
                        controller.deleteRoutine();
                        Get.back();
                      }));
                },
                child: PeepIcon(
                  Iconsax.trash,
                  size: AppValues.baseIconSize,
                  color: Palette.peepRed,
                ),
              ),
              PeepDropdownMenu(
                menuItems: [
                  // Todo : routine drop down menu 구성
                  DropdownMenuItemData(
                      'popup_action_1',
                      PeepIcon(Iconsax.categoryboxAdd,
                          size: AppValues.smallIconSize,
                          color: Palette.peepBlack),
                      'Todo 복사'),
                  DropdownMenuItemData(
                      'popup_action_2',
                      PeepIcon(Iconsax.categorybox,
                          size: AppValues.smallIconSize,
                          color: Palette.peepBlack),
                      'Todo 공유'),
                ],
                onMenuItemSelected: {
                  'popup_action_1': () {
                    debugPrint('1');
                  },
                  'popup_action_2': () {
                    debugPrint('2');
                  },
                },
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
