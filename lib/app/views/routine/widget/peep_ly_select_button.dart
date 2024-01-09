import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';

class PeepLySelectButtonController extends GetxController {
  RxInt ly = 0.obs;

  void setControllerValue(int ly) {
    this.ly.value = ly;
  }
}

class PeepLySelectButton extends StatelessWidget {
  final Function(int ly) onLySelected;
  final int initLyValue;

  const PeepLySelectButton(
      {super.key, required this.onLySelected, required this.initLyValue});

  @override
  Widget build(BuildContext context) {
    final PeepLySelectButtonController controller =
        PeepLySelectButtonController();
    controller.setControllerValue(initLyValue);

    return Obx(
      () => Container(
        width: AppValues.screenWidth - AppValues.screenPadding * 2,
        height: 36.w,
        decoration: BoxDecoration(
          color: Palette.peepGray100,
          borderRadius: BorderRadius.circular(AppValues.baseRadius),
        ),
        child: Stack(
          alignment: Alignment.center, // Stack centered
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 100),
              left: controller.ly.value *
                  (AppValues.screenWidth - AppValues.screenPadding * 2) /
                  4,
              child: Container(
                width:
                    (AppValues.screenWidth - AppValues.screenPadding * 2) / 4,
                height: 36.w,
                decoration: BoxDecoration(
                  color: Palette.peepWhite,
                  borderRadius: BorderRadius.circular(AppValues.baseRadius),
                  boxShadow: [
                    BoxShadow(
                      color: Palette.peepBlack
                          .withOpacity(AppValues.shadowOpacity),
                      spreadRadius: 0,
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    )
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    controller.setControllerValue(0);
                    onLySelected(0);
                  },
                  child: SizedBox(
                    width:
                        (AppValues.screenWidth - AppValues.screenPadding * 2) /
                            4,
                    child: Center(
                      child: Text(
                        "매일",
                        style: PeepTextStyle.boldM(
                            color: controller.ly.value == 0
                                ? Palette.peepGray500
                                : Palette.peepGray400),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    controller.setControllerValue(1);
                    onLySelected(1);
                  },
                  child: SizedBox(
                    width:
                        (AppValues.screenWidth - AppValues.screenPadding * 2) /
                            4,
                    child: Center(
                      child: Text(
                        "매주",
                        style: PeepTextStyle.boldM(
                            color: controller.ly.value == 1
                                ? Palette.peepGray500
                                : Palette.peepGray400),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    controller.setControllerValue(2);
                    onLySelected(2);
                  },
                  child: SizedBox(
                    width:
                        (AppValues.screenWidth - AppValues.screenPadding * 2) /
                            4,
                    child: Center(
                      child: Text(
                        "매월",
                        style: PeepTextStyle.boldM(
                            color: controller.ly.value == 2
                                ? Palette.peepGray500
                                : Palette.peepGray400),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    controller.setControllerValue(3);
                    onLySelected(3);
                  },
                  child: SizedBox(
                    width:
                        (AppValues.screenWidth - AppValues.screenPadding * 2) /
                            4,
                    child: Center(
                      child: Text(
                        "매년",
                        style: PeepTextStyle.boldM(
                            color: controller.ly.value == 3
                                ? Palette.peepGray500
                                : Palette.peepGray400),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
