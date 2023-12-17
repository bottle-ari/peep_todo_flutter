import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_animation_effect.dart';

import '../../../data/model/palette/palette_model.dart';
import '../../../theme/app_values.dart';
import '../../../theme/palette.dart';
import '../../../theme/text_style.dart';

class PeepColorPickerButton extends StatelessWidget {
  final Color color;
  final VoidCallback onTap;
  final Function(Color) onSelected;

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
          colorId: '_',
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
  final String colorId;
  final Function(Color) onColorSelected;

  const _PeepColorPicker(
      {required this.onColorSelected, required this.colorId});

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
            Text(
              '색 선택하기',
              style: PeepTextStyle.boldL(color: Palette.peepGray400),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppValues.screenPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 1; i++)
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: AppValues.verticalMargin),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (var item in defaultPalette.colors)
                            _PeepColorPickerItem(
                              color: item.color,
                              onTap: (String colorId) {
                                onColorSelected(item.color);
                                Get.back();
                              },
                            ),
                        ],
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
  final Function(String) onTap;

  const _PeepColorPickerItem({required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppValues.baseIconSize,
      height: AppValues.baseIconSize,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
