import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_animation_effect.dart';

import '../../../theme/app_values.dart';

class PeepWarningPopup extends StatelessWidget {
  final String icon;
  final String text;
  final String confirmText;
  final Color color;

  const PeepWarningPopup(
      {super.key,
      required this.icon,
      required this.text,
      required this.confirmText,
      required this.color,});

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
          Text(
            text,
            style: PeepTextStyle.regularM(color: Palette.peepBlack),
            textAlign: TextAlign.center,
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
            child: Text(confirmText, style: PeepTextStyle.boldL(color: Palette.peepBlack))),
      ],
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: EdgeInsets.only(bottom: AppValues.verticalMargin),
    );
  }
}
