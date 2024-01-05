import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controllers/page/diary_page_controller.dart';
import '../../../theme/app_values.dart';
import '../../../theme/icons.dart';
import '../../../theme/palette.dart';
import '../../../theme/text_style.dart';
import '../../common/buttons/peep_animation_effect.dart';

class PeepCheckedTodo extends StatelessWidget {
  final DiaryPageController controller = Get.find();
  final DateTime selectedDate;

  PeepCheckedTodo({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onVerticalDragUpdate: (details) {
          if (controller.checkedTodo.length <= 3) return;

          // 위로 스와이프
          if (details.delta.dy < 0) {
            controller.isOpen[DateFormat('yyyyMMdd').format(selectedDate)] =
                false;
          }

          // 아래로 스와이프
          if (details.delta.dy > 0) {
            controller.isOpen[DateFormat('yyyyMMdd').format(selectedDate)] =
                true;
          }
        },
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: [
              if ((controller
                              .checkedTodo[
                                  DateFormat('yyyyMMdd').format(selectedDate)]
                              ?.length ??
                          0) >
                      3 &&
                  !(controller.isOpen[
                          DateFormat('yyyyMMdd').format(selectedDate)] ??
                      true))
                for (int i = 0; i < 3; i++)
                  Padding(
                    padding: EdgeInsets.only(bottom: AppValues.innerMargin),
                    child: Row(
                      children: [
                        PeepIcon(
                          Iconsax.checkTrue,
                          size: AppValues.smallIconSize,
                          color: controller
                              .checkedTodo[DateFormat('yyyyMMdd')
                                  .format(selectedDate)]?[i]
                              .color,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: AppValues.horizontalMargin),
                          child: SizedBox(
                            width: 310.w,
                            child: Text(
                              controller
                                      .checkedTodo[DateFormat('yyyyMMdd')
                                          .format(selectedDate)]?[i]
                                      .name ??
                                  '',
                              style: PeepTextStyle.regularS(
                                      color: Palette.peepBlack)
                                  .copyWith(
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
              else
                for (var todo in controller.checkedTodo[
                        DateFormat('yyyyMMdd').format(selectedDate)] ??
                    [])
                  Padding(
                    padding: EdgeInsets.only(bottom: AppValues.innerMargin),
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          PeepIcon(
                            Iconsax.checkTrue,
                            size: AppValues.smallIconSize,
                            color: todo.color,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: AppValues.horizontalMargin),
                            child: SizedBox(
                              width: 310.w,
                              child: Text(
                                todo.name,
                                style: PeepTextStyle.regularS(
                                        color: Palette.peepBlack)
                                    .copyWith(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          )
                        ],
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

class PeepCheckedTodoFoldDivider extends StatelessWidget {
  final DiaryPageController controller = Get.find();
  final DateTime selectedDate;

  PeepCheckedTodoFoldDivider({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          if ((controller
                      .checkedTodo[DateFormat('yyyyMMdd').format(selectedDate)]
                      ?.length ??
                  0) > 3)
            Stack(children: [
              Positioned(
                left: 0,
                top: -1 * AppValues.verticalMargin,
                bottom: 0,
                right: 0,
                child: const Center(
                  child: Divider(
                    color: Palette.peepGray200,
                  ),
                ),
              ),
              Center(
                child: PeepAnimationEffect(
                  onTap: () {
                    controller.toggleIsOpen(selectedDate);
                  },
                  child: Container(
                    color: Palette.peepWhite,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: AppValues.verticalMargin,
                        left: AppValues.horizontalMargin,
                        right: AppValues.horizontalMargin,
                      ),
                      child: controller.isOpen[DateFormat('yyyyMMdd')
                                  .format(selectedDate)] ??
                              true
                          ? PeepIcon(
                              Iconsax.arrowCircleUp,
                              size: AppValues.miniIconSize,
                              color: Palette.peepGray400,
                            )
                          : PeepIcon(
                              Iconsax.arrowCircleDown,
                              size: AppValues.miniIconSize,
                              color: Palette.peepGray400,
                            ),
                    ),
                  ),
                ),
              ),
            ])
          else if (controller.checkedTodo.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(bottom: AppValues.verticalMargin),
              child: const Divider(
                color: Palette.peepGray200,
              ),
            ),
        ],
      ),
    );
  }
}
