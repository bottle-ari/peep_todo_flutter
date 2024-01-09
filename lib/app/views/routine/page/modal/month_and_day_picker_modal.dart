import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import '../../../../theme/app_values.dart';
import '../../../../theme/icons.dart';
import '../../../../theme/palette.dart';
import '../../../../theme/text_style.dart';
import '../../../common/buttons/peep_animation_effect.dart';

class MonthAndDatePickerController extends GetxController {
  RxInt monthValue = 1.obs;
  RxInt dayValue = 1.obs;
}

class MonthAndDatePickerModal extends StatelessWidget {
  final int initMonthValue;
  final int initDayValue;
  final Color color;
  final Function(int, int) onConfirm;

  const MonthAndDatePickerModal({
    super.key,
    required this.color,
    required this.initMonthValue,
    required this.onConfirm,
    required this.initDayValue,
  });

  @override
  Widget build(BuildContext context) {
    MonthAndDatePickerController controller = MonthAndDatePickerController();
    controller.monthValue.value = initMonthValue;
    controller.dayValue.value = initDayValue;

    return Container(
      decoration: BoxDecoration(
        color: Palette.peepWhite,
        borderRadius: BorderRadius.all(
          Radius.circular(AppValues.baseRadius),
        ),
      ),
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: AppValues.verticalMargin,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PeepAnimationEffect(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppValues.verticalMargin,
                      horizontal: AppValues.screenPadding,
                    ),
                    child: PeepIcon(
                      Iconsax.calendar,
                      size: AppValues.mediumIconSize,
                      color: Colors.transparent,
                    ),
                  ),
                ),
                PeepAnimationEffect(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppValues.verticalMargin,
                      horizontal: AppValues.screenPadding,
                    ),
                    child: Text(
                      "${controller.monthValue.value < 10 ? '0${controller.monthValue.value}' : controller.monthValue.value}월 ${controller.dayValue.value < 10 ? '0${controller.dayValue.value}' : controller.dayValue.value}일",
                      style: PeepTextStyle.boldL(color: Palette.peepGray500),
                    ),
                  ),
                ),
                PeepAnimationEffect(
                  onTap: () {
                    onConfirm(
                        controller.monthValue.value, controller.dayValue.value);
                    Get.back();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppValues.verticalMargin,
                      horizontal: AppValues.screenPadding,
                    ),
                    child: PeepIcon(
                      Iconsax.checkBold,
                      size: AppValues.mediumIconSize,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NumberPicker(
                    infiniteLoop: true,
                    value: controller.monthValue.value,
                    minValue: 1,
                    maxValue: 12,
                    onChanged: (value) {
                      controller.monthValue.value = value;
                    },
                  ),
                  Text("월"),
                  NumberPicker(
                    infiniteLoop: true,
                    value: controller.dayValue.value,
                    minValue: 1,
                    maxValue: 31,
                    onChanged: (value) {
                      controller.dayValue.value = value;
                    },
                  ),
                  Text("일"),
                ],
              ),
            ),
            SizedBox(height: AppValues.verticalMargin),
          ],
        ),
      ),
    );
  }
}
