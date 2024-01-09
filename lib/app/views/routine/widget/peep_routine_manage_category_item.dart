import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/data/enums/todo_enum.dart';
import 'package:peep_todo_flutter/app/data/model/category/category_model.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_animation_effect.dart';

import '../../../controllers/data/palette_controller.dart';

class PeepRoutineManageCategoryItem extends StatelessWidget {
  final PaletteController paletteController = Get.find();
  final CategoryModel category;
  final bool isFolded;
  final VoidCallback onTapAddButton;

  PeepRoutineManageCategoryItem({
    Key? key,
    required this.category,
    required this.onTapAddButton,
    required this.isFolded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {},
      child: SizedBox(
        width: AppValues.screenWidth - AppValues.screenPadding * 2,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppValues.horizontalMargin),
          child: Row(
            children: [
              PeepAnimationEffect(
                onTap: onTapAddButton,
                child: Row(
                  children: [
                    Text(
                      category.emoji,
                      style: PeepTextStyle.boldL(),
                    ),
                    SizedBox(
                      width: AppValues.horizontalMargin,
                    ),
                    Text(
                      category.name.length > 10
                          ? "${category.name.substring(0, 10)}..."
                          : category.name,
                      style: PeepTextStyle.boldL(
                          color: paletteController
                              .getDefaultPalette()[category.color]
                              .color),
                    ),
                    if (category.type == TodoType.constant)
                      Padding(
                        padding: EdgeInsets.only(left: AppValues.innerMargin),
                        child: PeepIcon(
                          Iconsax.constantTodo,
                          size: AppValues.smallIconSize,
                          color: paletteController
                              .getDefaultPalette()[category.color]
                              .color
                              .withOpacity(AppValues.baseOpacity),
                        ),
                      ),
                    SizedBox(
                      width: AppValues.horizontalMargin,
                    ),
                    PeepIcon(
                      Iconsax.addSquare,
                      size: AppValues.baseIconSize,
                      color: paletteController
                          .getDefaultPalette()[category.color]
                          .color,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
