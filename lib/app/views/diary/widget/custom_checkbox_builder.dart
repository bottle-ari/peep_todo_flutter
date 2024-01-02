import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../data/model/palette/palette_model.dart';
import '../../../theme/app_values.dart';
import '../../../theme/icons.dart';
import '../../../theme/palette.dart';
import '../../common/buttons/peep_animation_effect.dart';

class CustomCheckboxBuilder extends QuillCheckboxBuilder {
  @override
  Widget build({
    required BuildContext context,
    required bool isChecked,
    required ValueChanged<bool> onChanged,
  }) {
    return PeepAnimationEffect(
      onTap: () => onChanged(!isChecked),
      child: isChecked
          ? PeepIcon(
        Iconsax.checkTrue,
        size: AppValues.diaryIconSize,
        color: defaultPalette.primaryColor.color,
      )
          : PeepIcon(
        Iconsax.checkFalse,
        size: AppValues.diaryIconSize,
        color: Palette.peepGray300,
      ),
    );
  }
}