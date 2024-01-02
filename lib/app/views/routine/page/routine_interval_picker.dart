import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import '../../../theme/app_values.dart';
import '../../../theme/icons.dart';
import '../../../theme/palette.dart';
import '../../../theme/text_style.dart';
import '../../common/buttons/peep_animation_effect.dart';

class RoutineIntervalPickerController extends GetxController {
  RxInt currentValue = 1.obs;
}

class RoutineIntervalPicker extends StatelessWidget {
  final int initValue;
  final Color color;
  final String postfixText;
  final Function(int) onConfirm;

  const RoutineIntervalPicker({
    super.key,
    required this.color,
    required this.initValue,
    required this.onConfirm,
    required this.postfixText,
  });

  @override
  Widget build(BuildContext context) {
    RoutineIntervalPickerController controller =
        RoutineIntervalPickerController();
    controller.currentValue.value = initValue;

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
                      "${controller.currentValue.value} $postfixText",
                      style: PeepTextStyle.boldL(color: Palette.peepGray500),
                    ),
                  ),
                ),
                PeepAnimationEffect(
                  onTap: () {
                    onConfirm(controller.currentValue.value);
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
            NumberPicker(
              value: controller.currentValue.value,
              minValue: 1,
              maxValue: 100,
              onChanged: (value) {
                controller.currentValue.value = value;
              },
            ),
            SizedBox(height: AppValues.verticalMargin),
          ],
        ),
      ),
    );
  }
}
