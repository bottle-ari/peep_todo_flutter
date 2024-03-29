import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/data/palette_controller.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_animation_effect.dart';

import '../../../data/model/palette/palette_model.dart';
import '../../../theme/app_values.dart';
import '../../../theme/palette.dart';
import '../../../theme/text_style.dart';

class PeepColorPickerButton extends StatelessWidget {
  final Color color;
  final VoidCallback onTap;
  final Function(int) onSelected;

  const PeepColorPickerButton({
    Key? key,
    required this.color,
    required this.onTap,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PeepAnimationEffect(
      onTap: () {
        onTap();
        Get.bottomSheet(_PeepColorPicker(
          onColorSelected: onSelected,
          color: color,
        ));
      },
      child: Container(
        height: 32.w,
        width: 32.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }
}

class _PeepColorPicker extends StatelessWidget {
  final Color color;
  final PaletteController paletteController = Get.find();
  final Function(int) onColorSelected;

  _PeepColorPicker({required this.onColorSelected, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.peepWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppValues.baseRadius),
          topRight: Radius.circular(AppValues.baseRadius),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: AppValues.screenPadding,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '색 선택하기',
                  style: PeepTextStyle.boldL(color: Palette.peepGray500),
                ),
                // PeepAnimationEffect(
                //   //TODO : 테마 넣기
                //   onTap: () {},
                //   child: Padding(
                //     padding: EdgeInsets.symmetric(
                //       horizontal: AppValues.horizontalMargin,
                //     ),
                //     child: Container(
                //       decoration: BoxDecoration(
                //         border: Border.all(color: Palette.peepGray500),
                //         borderRadius:
                //             BorderRadius.circular(AppValues.tinyRadius),
                //       ),
                //       child: Padding(
                //         padding: EdgeInsets.symmetric(
                //             horizontal: AppValues.horizontalMargin,
                //             vertical: AppValues.innerMargin),
                //         child: Text(
                //           '테마 변경',
                //           style:
                //               PeepTextStyle.boldXS(color: Palette.peepGray500),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppValues.screenPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: AppValues.verticalMargin,
                          horizontal: AppValues.horizontalMargin),
                      child: SizedBox(
                        height: 120.h,
                        child: GridView.count(
                          crossAxisCount: 5,
                          children: [
                            for (int inx = 0;
                                inx <
                                    paletteController.getDefaultPalette().length;
                                inx++)
                              Center(
                                child: _PeepColorPickerItem(
                                  color: paletteController
                                      .getDefaultPalette()[inx]
                                      .color,
                                  selected: paletteController
                                          .getDefaultPalette()[inx]
                                          .color ==
                                      color,
                                  onTap: () {
                                    onColorSelected(inx);
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PeepColorPickerItem extends StatelessWidget {
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  const _PeepColorPickerItem(
      {required this.color, required this.onTap, required this.selected});

  @override
  Widget build(BuildContext context) {
    return PeepAnimationEffect(
      onTap: onTap,
      child: Container(
        width: AppValues.largeIconSize,
        height: AppValues.largeIconSize,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (selected)
              PeepIcon(
                Iconsax.check,
                size: AppValues.smallIconSize,
                color: Palette.peepWhite,
              ),
          ],
        ),
      ),
    );
  }
}
