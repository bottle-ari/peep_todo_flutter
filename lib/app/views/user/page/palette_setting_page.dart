import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/my_page_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_view.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/utils/language_util.dart';

import '../../../theme/app_values.dart';
import '../../../theme/icons.dart';
import '../../common/buttons/peep_animation_effect.dart';
import '../../common/painter/ring_painter.dart';
import '../../common/peep_subpage_appbar.dart';

class PaletteSettingPage extends BaseView<MyPageController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(AppValues.appbarHeight),
        child: SafeArea(
          child: PeepSubpageAppbar(
              title: '팔레트 테마 변경',
              onTapBackArrow: () {
                Get.back();
              }),
        ));
  }

  @override
  Widget body(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: AppValues.innerMargin),
              child: Text(
                '메인 색상 선택',
                style: PeepTextStyle.boldM(color: Palette.peepGray500),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 110.h,
              child: GridView.count(
                crossAxisCount: 5,
                childAspectRatio: 4 / 3,
                children: [
                  for (int inx = 0; inx < 10; inx++)
                    Center(
                      child: _PeepColorPickerItem(
                        color: controller.paletteController
                            .getDefaultPalette()[inx]
                            .color,
                        selected: inx == controller.getPrimaryColorIndex(),
                        onTap: () {
                          controller.updatePrimaryColor(inx);
                        },
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: AppValues.innerMargin),
              child: Text(
                '팔레트 선택',
                style: PeepTextStyle.boldM(color: Palette.peepGray500),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: Column(
                children: [
                  for (int inx = 0;
                      inx < controller.paletteController.paletteData.length;
                      inx++)
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: AppValues.innerMargin),
                      child: _PeepPalettePickerItem(
                        palette: inx,
                        selected: inx == controller.getPaletteIndex(),
                        onTap: () {
                          controller.updatePalette(controller
                              .paletteController.paletteData[inx].name);
                        },
                        controller: controller,
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
          border: Border.all(
              color: color == Palette.peepWhite
                  ? Palette.peepGray300
                  : Colors.transparent),
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (selected)
              PeepIcon(
                Iconsax.check,
                size: AppValues.smallIconSize,
                color: color == Palette.peepWhite
                    ? Palette.peepGray400
                    : Palette.peepWhite,
              ),
          ],
        ),
      ),
    );
  }
}

class _PeepPalettePickerItem extends StatelessWidget {
  final MyPageController controller;
  final int palette;
  final bool selected;
  final VoidCallback onTap;

  const _PeepPalettePickerItem(
      {required this.palette,
      required this.onTap,
      required this.selected,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return PeepAnimationEffect(
      onTap: onTap,
      child: Container(
        width: AppValues.screenWidth - AppValues.screenPadding * 2,
        height: AppValues.largeItemHeight,
        decoration: BoxDecoration(
          color: Palette.peepWhite,
          borderRadius: BorderRadius.circular(AppValues.baseRadius),
          border: Border.all(color: Palette.peepGray100),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
          child: Row(
            children: [
              CustomPaint(
                size: Size(
                  AppValues.largeIconSize,
                  AppValues.largeIconSize,
                ),
                painter: RingPainterForPalette(palette),
              ),
              SizedBox(
                width: AppValues.horizontalMargin,
              ),
              Text(
                LanguageUtil.getPaletteName(
                    controller.paletteController.paletteData[palette].name),
                style: PeepTextStyle.regularM(),
              ),
              if (selected)
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: PeepIcon(
                      Iconsax.checkBold,
                      size: AppValues.baseIconSize,
                      color: controller.paletteController.paletteData[palette]
                          .colors[0].color,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
