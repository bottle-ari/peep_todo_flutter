import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_animation_effect.dart';

class PeepHalfToggleButton extends StatelessWidget {
  final bool toggleState;
  final VoidCallback onToggle;
  final Color backgroundColorOn;
  final Color backgroundColorOff;
  final String textOn;
  final String textOff;
  final Color textColorOn;
  final Color textColorOff;
  final PeepIcon? icon;

  const PeepHalfToggleButton({
    Key? key,
    required this.textOn,
    required this.textOff,
    this.icon,
    required this.onToggle,
    required this.backgroundColorOn,
    required this.backgroundColorOff,
    required this.textColorOn,
    required this.textColorOff,
    required this.toggleState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PeepAnimationEffect(
      onTap: onToggle,
      child: Container(
        height: AppValues.baseItemHeight,
        width: 172.w,
        decoration: BoxDecoration(
          border: Border.all(color: Palette.peepGray200),
          borderRadius: BorderRadius.circular(AppValues.baseRadius),
          color: toggleState ? backgroundColorOn : backgroundColorOff,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppValues.innerMargin),
          child: Row(
            mainAxisAlignment: icon != null ? MainAxisAlignment.start : MainAxisAlignment.center,
            children: [
              if (icon != null)
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppValues.horizontalMargin),
                  child: Align(alignment: Alignment.centerLeft, child: icon),
                ),
              Center(
                child: Text(toggleState ? textOn : textOff,
                    style: PeepTextStyle.boldM(
                        color: toggleState ? textColorOn : textColorOff)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
