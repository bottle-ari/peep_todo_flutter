import 'package:flutter/material.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';

import '../../theme/palette.dart';

class PeepSubpageAppbar extends StatelessWidget {
  final String title;
  final List<Widget>? buttons;

  const PeepSubpageAppbar({super.key, required this.title, this.buttons});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
        child: Row(
          children: [
            PeepIcon(
              Iconsax.arrowLeft,
              size: AppValues.baseIconSize,
              color: Palette.peepGray500,
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
              child: Text(
                title,
                style: PeepTextStyle.boldL(color: Palette.peepGray500),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    for (Widget button in buttons ?? [])
                      Padding(
                          padding:
                              EdgeInsets.only(left: AppValues.horizontalMargin),
                          child: button),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
