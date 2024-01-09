import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/data/model/routine/routine_model.dart';
import '../../../routes/app_pages.dart';
import '../../../theme/app_values.dart';
import '../../../theme/icons.dart';
import '../../../theme/palette.dart';
import '../../../theme/text_style.dart';
import '../../../utils/priority_util.dart';
import '../../common/buttons/peep_animation_effect.dart';

class PeepRoutineItem extends StatelessWidget {
  final Color color;
  final RoutineModel routine;
  final Function onTapRoutineButton;

  const PeepRoutineItem({
    super.key,
    required this.color,
    required this.routine,
    required this.onTapRoutineButton,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // routine manage page 로 넘어가기
        Get.toNamed(Routes.ROUTINE_MANAGE_PAGE);
        // // routine detail page 로 넘어가기
        // Get.toNamed(
        //   Routes.ROUTINE_DETAIL_PAGE,
        //   arguments: {
        //     'category_id': routine.categoryId,
        //     'routine_id': routine.id,
        //   },
        // );
      },
      onLongPress: () {},
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Palette.peepGray200),
            borderRadius: BorderRadius.circular(AppValues.baseRadius),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppValues.baseRadius),
            child: SizedBox(
              width: AppValues.screenWidth - AppValues.screenPadding * 2,
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(minHeight: AppValues.baseItemHeight),
                child: Container(
                  color: Palette.peepWhite,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: AppValues.innerMargin),
                    child: Row(
                      children: [
                        SizedBox(width: AppValues.textMargin),
                        SizedBox(
                          width: 280.w,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: AppValues.verticalMargin),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: routine.name.length > 55
                                        ? '${routine.name.substring(0, 54)}...'
                                        : routine.name,
                                    style: PeepTextStyle.regularM(
                                        color: Palette.peepBlack),
                                  ),
                                  if (routine.priority != 0)
                                    WidgetSpan(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 5.w),
                                        child: PeepIcon(
                                          Iconsax.priority,
                                          size: AppValues.miniIconSize,
                                          color: PriorityUtil.getPriority(
                                                  routine.priority)
                                              .PriorityColor,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              maxLines: 3,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AppValues.innerMargin),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: PeepAnimationEffect(
                                  onTap: onTapRoutineButton,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: AppValues.innerMargin,
                                        vertical: AppValues.verticalMargin),
                                    child: PeepIcon(
                                      Iconsax.routineOutline,
                                      size: AppValues.baseIconSize,
                                      color: color,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
