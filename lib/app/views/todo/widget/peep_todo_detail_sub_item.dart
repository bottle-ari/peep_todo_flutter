import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_check_button.dart';

class PeepTodoDetailSubItem extends StatelessWidget {
  final Color color;
  final List<String> textList;
  final VoidCallback onTap;
  final VoidCallback onTapCancel;
  final VoidCallback onTapCheck;
  final VoidCallback onTapAddSub;

  //final VoidCallback onTap;

  const PeepTodoDetailSubItem({
    Key? key,
    required this.color,
    required this.textList,
    required this.onTap,
    required this.onTapCancel,
    required this.onTapCheck,
    required this.onTapAddSub,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // define TextEditingController
    TextEditingController controller = TextEditingController();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
      child: Material(
        color: Palette.peepWhite,
        borderRadius: BorderRadius.circular(AppValues.baseRadius),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (String text in textList)
                Column(
                  children: [
                    TextField(
                      controller: TextEditingController(text: text),
                      maxLines: 1,
                      style: PeepTextStyle.regularM(color: Palette.peepBlack),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(AppValues.screenPadding),
                        prefixIcon: GestureDetector(
                          onTap: onTapCancel,
                          child: Padding(
                            padding: EdgeInsets.only(
                                right: AppValues.horizontalMargin),
                            child: Transform.scale(
                              scale: 0.4,
                              child: PeepIcon(
                                Iconsax.cancel,
                                color: Palette.peepGray400,
                                size: AppValues.smallRadius,
                              ),
                            ),
                          ),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: onTapCheck,
                          child: Padding(
                            padding: EdgeInsets.only(
                                right: AppValues.horizontalMargin),
                            child: Transform.scale(
                              scale: 0.8,
                              child: PeepIcon(Iconsax.checkFalse,
                                  color: Palette.peepGray400,
                                  size: AppValues.baseIconSize),
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        print("Tapped on: $text");
                      },
                    ),
                    Divider(),
                  ],
                ),
              Padding(
                padding: EdgeInsets.all(2 * AppValues.horizontalMargin),
                child: GestureDetector(
                  onTap: onTapAddSub,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppValues.baseRadius),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_circle_outline,
                          size: AppValues.baseIconSize,
                          color: color,
                        ),
                        Text(
                          "하위 할 일 추가",
                          style: PeepTextStyle.regularM(color: color),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
