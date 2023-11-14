import 'dart:math';
import 'package:flutter/material.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/category/widget/peep_color_picker_button.dart';

class CategoryColorPickerModal extends StatelessWidget {
  // Color Picker 내부에서, 특정 컬러가 선택되었을 때, callback 함수
  final Function(Color) onColorSelected;

  const CategoryColorPickerModal({super.key, required this.onColorSelected});

  @override
  Widget build(BuildContext context) {
    // random color list 생성
    List<Color> randomColorList = [];
    for (int i = 0; i < 30; i++) {
      Color randomColor =
          Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
      randomColorList.add(randomColor);
    }

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
              padding:
                  EdgeInsets.symmetric(vertical: AppValues.screenPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 5; i++)
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: AppValues.verticalMargin),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (int j = 0; j < 6; j++)
                            PeepColorPickerButton(
                              color: randomColorList[i * 6 + j],
                              onTap: () {
                                onColorSelected(randomColorList[i * 6 + j]);
                                Navigator.pop(context);
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
