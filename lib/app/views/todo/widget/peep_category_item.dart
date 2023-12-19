import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/page/scheduled_todo_controller.dart';
import 'package:peep_todo_flutter/app/data/enums/todo_enum.dart';
import 'package:peep_todo_flutter/app/data/model/category/category_model.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/common/buttons/peep_animation_effect.dart';

class PeepCategoryItem extends StatelessWidget {
  final CategoryModel category;
  final bool isFolded;
  final VoidCallback onTapAddButton;
  final VoidCallback onTapArrowButton;

  const PeepCategoryItem({
    Key? key,
    required this.category,
    required this.onTapAddButton,
    required this.onTapArrowButton,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
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
                          style: PeepTextStyle.boldL(color: category.color),
                        ),
                        if (category.type == TodoType.constant)
                          Padding(
                            padding: EdgeInsets.only(left: AppValues.innerMargin),
                            child: PeepIcon(
                              Iconsax.constantTodo,
                              size: AppValues.smallIconSize,
                              color: category.color.withOpacity(AppValues.baseOpacity),
                            ),
                          ),
                        SizedBox(
                          width: AppValues.horizontalMargin,
                        ),
                        PeepIcon(
                          Iconsax.addSquare,
                          size: AppValues.baseIconSize,
                          color: category.color,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              GestureDetector(
                onTap: onTapArrowButton,
                child: Row(
                  children: [
                    SizedBox(
                      width: AppValues.horizontalMargin,
                    ),
                    TweenAnimationBuilder(
                      tween: Tween(
                        begin: isFolded ? 0.0 : 1.0,
                        end: isFolded ? 0.0 : 1.0,
                      ),
                      duration: const Duration(milliseconds: 120),
                      builder: (context, double value, child) {
                        return Transform.rotate(
                          angle: -value * pi, // 라디안 값으로 회전 (1.0은 180도)
                          child: child,
                        );
                      },
                      child: PeepIcon(
                        Iconsax.arrowDown,
                        size: AppValues.smallIconSize,
                        color: category.color,
                      ),
                    ),
                    SizedBox(
                      width: AppValues.horizontalMargin,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
