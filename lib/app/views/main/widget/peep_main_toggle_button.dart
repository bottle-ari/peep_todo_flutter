import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/data/palette_controller.dart';
import 'package:peep_todo_flutter/app/controllers/main/peep_main_toggle_button_controller.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/views/common/base/loading.dart';
import '../../../data/model/enum/menu_state.dart';

class PeepMainToggleButton extends StatelessWidget {
  final Function(MenuState menuState) onNewMenuSelected;

  PeepMainToggleButton({super.key, required this.onNewMenuSelected});

  final PeepMainToggleButtonController controller = Get.find();
  final PaletteController paletteController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Loading();
      }
      return AnimatedBuilder(
        animation: controller.animationController,
        builder: (BuildContext context, Widget? child) {
          return Container(
            width: 120.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: Palette.peepGray100,
              borderRadius: BorderRadius.circular(AppValues.baseRadius),
            ),
            child: Stack(
              alignment: Alignment.center, // Stack centered
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 100),
                  left: controller.animationController.value * 60.w,
                  child: Container(
                    width: 60.w,
                    height: 32.w,
                    decoration: BoxDecoration(
                        color: Palette.peepWhite,
                        borderRadius:
                            BorderRadius.circular(AppValues.baseRadius),
                        boxShadow: [
                          BoxShadow(
                            color: Palette.peepBlack
                                .withOpacity(AppValues.shadowOpacity),
                            spreadRadius: 0,
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          )
                        ]),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Obx(
                      () => GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          controller.animationController
                              .reverse()
                              .then((value) => controller.selectedIndex(0));
                          onNewMenuSelected(MenuState.TODO);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: PeepIcon(
                            Iconsax.checkBold,
                            size: AppValues.smallIconSize,
                            color: controller.selectedIndex.value == 0
                                ? paletteController.getPriorityColor()
                                : Palette.peepGray300,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 3.w,),
                    Obx(
                      () => GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          controller.animationController
                              .forward()
                              .then((value) => controller.selectedIndex(1));
                          onNewMenuSelected(MenuState.DAIRY);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: PeepIcon(
                            Iconsax.diary,
                            size: AppValues.smallIconSize,
                            color: controller.selectedIndex.value == 1
                                ? paletteController.getPriorityColor()
                                : Palette.peepGray300,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
