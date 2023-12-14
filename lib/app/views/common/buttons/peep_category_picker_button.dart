import 'package:flutter/material.dart';
import 'package:peep_todo_flutter/app/data/model/category/category_model.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_animation_effect.dart';

class PeepCategoryPickerButton extends StatelessWidget {
  final CategoryModel categoryModel;
  final VoidCallback onTap;

  const PeepCategoryPickerButton({
    Key? key,
    required this.onTap, required this.categoryModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PeepAnimationEffect(
      onTap: onTap,
      scale: 0.95,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppValues.horizontalMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              categoryModel.emoji,
              style: PeepTextStyle.boldL(),
            ),
            SizedBox(
              width: AppValues.horizontalMargin,
            ),
            Text(
              categoryModel.name.length > 10
                  ? "${categoryModel.name.substring(0, 10)}..."
                  : categoryModel.name,
              style: PeepTextStyle.boldL(color: categoryModel.color),
            ),
          ],
        ),
      ),
    );
  }
}
