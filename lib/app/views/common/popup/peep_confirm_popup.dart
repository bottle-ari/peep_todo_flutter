import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_animation_effect.dart';

import '../../../theme/app_values.dart';

class PeepConfirmPopup extends StatelessWidget {
  final String icon;
  final String text;
  final String? hintText;
  final Color? hintColor;
  final String confirmText;
  final Color color;
  final Function func;

  const PeepConfirmPopup(
      {super.key,
      required this.icon,
      required this.text,
      required this.confirmText,
      required this.color,
      this.hintText,
      required this.func,
      this.hintColor});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Palette.peepWhite,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: AppValues.verticalMargin,
          ),
          PeepIcon(
            icon,
            color: color,
            size: AppValues.xlargeIconSize,
          ),
          SizedBox(
            height: AppValues.verticalMargin * 2,
          ),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: text,
                style: PeepTextStyle.boldM(color: Palette.peepBlack)),
            TextSpan(
                text: ' 하시겠습니까?',
                style: PeepTextStyle.regularM(color: Palette.peepBlack))
          ])),
          if (hintText != null)
            Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: Text(
                hintText!,
                style: PeepTextStyle.regularXS(
                    color: hintColor ?? Palette.peepGray400),
              ),
            ),
        ],
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppValues.baseRadius)),
      actions: [
        PeepAnimationEffect(
            onTap: () {
              Get.back();
            },
            child: Text('취소',
                style: PeepTextStyle.boldL(color: Palette.peepGray500))),
        SizedBox(
          width: 50.w,
        ),
        PeepAnimationEffect(
            onTap: () {
              Get.back();
              func();
            },
            child: Text(confirmText, style: PeepTextStyle.boldL(color: color))),
      ],
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: EdgeInsets.only(bottom: AppValues.verticalMargin * 2),
    );
  }
}
