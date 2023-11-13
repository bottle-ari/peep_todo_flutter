import 'package:flutter/material.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';

class PeepCategoryPickerButton extends StatelessWidget {
  final Color color;
  final String name;
  final String emoji;
  final VoidCallback onTap;

  const PeepCategoryPickerButton({
    Key? key,
    required this.color,
    required this.name,
    required this.emoji,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: AppValues.screenWidth - AppValues.screenPadding * 2,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppValues.horizontalMargin),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                emoji,
                style: PeepTextStyle.boldL(),
              ),
              SizedBox(
                width: AppValues.horizontalMargin,
              ),
              Text(
                name.length > 10
                    ? "${name.substring(0, 10)}..."
                    : name,
                style: PeepTextStyle.boldL(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
