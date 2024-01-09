import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/data/routine_controller.dart';
import 'package:peep_todo_flutter/app/data/model/routine/routine_model.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/utils/routine_util.dart';
import 'package:peep_todo_flutter/app/views/common/popup/peep_confirm_popup.dart';
import 'peep_routine_toggle_button.dart';

class PeepRoutineManageListItem extends StatelessWidget {
  final RoutineController controller = Get.find();
  final RoutineModel routine;
  final VoidCallback onTap;

  PeepRoutineManageListItem({
    Key? key,
    required this.routine,
    required this.onTap,
  }) : super(key: key);

  void deleteCategory() {
    Get.dialog(PeepConfirmPopup(
      icon: Iconsax.trash,
      text: '삭제',
      hintText: '루틴이 삭제됩니다!',
      hintColor: Palette.peepRed,
      confirmText: '삭제',
      color: Palette.peepRed,
      func: () {
        controller.deleteRoutine(routine: routine);
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Palette.peepGray200),
        borderRadius: BorderRadius.circular(AppValues.baseRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppValues.baseRadius),
        child: Slidable(
          key: UniqueKey(),
          startActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: (BuildContext context) {
                  deleteCategory();
                },
                backgroundColor: Palette.peepPriorityHigh,
                foregroundColor: Colors.white,
                icon: PeepIconData.trash,
              ),
            ],
          ),
          child: InkWell(
            onTap: onTap,
            child: Container(
              width: AppValues.screenWidth - AppValues.screenPadding * 2,
              color: routine.isActive ? Palette.peepWhite : Palette.peepGray100,
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(minHeight: AppValues.largeItemHeight),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppValues.horizontalMargin),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: AppValues.innerMargin,
                          ),
                          if (routine.isActive)
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 230.w,
                                    child: Text(
                                      routine.name,
                                      style: PeepTextStyle.regularM(
                                          color: Palette.peepBlack),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      PeepIcon(
                                        Iconsax.routineOutline,
                                        size: 14.w,
                                        color: Palette.peepBlack,
                                      ),
                                      SizedBox(width: AppValues.innerMargin),
                                      Text(
                                        repeatConditionToDescription(
                                            routine.repeatCondition),
                                        style: PeepTextStyle.regularXS(
                                            color: Palette.peepBlack),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          else
                            ColorFiltered(
                              colorFilter: const ColorFilter.matrix([
                                0.2126,
                                0.7152,
                                0.0722,
                                0,
                                0,
                                0.2126,
                                0.7152,
                                0.0722,
                                0,
                                0,
                                0.2126,
                                0.7152,
                                0.0722,
                                0,
                                0,
                                0,
                                0,
                                0,
                                1,
                                0,
                              ]),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.h),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 230.w,
                                      child: Text(
                                        routine.name,
                                        style: PeepTextStyle.regularM(
                                            color: Palette.peepBlack),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        PeepIcon(
                                          Iconsax.routineOutline,
                                          size: 14.w,
                                          color: Palette.peepBlack,
                                        ),
                                        SizedBox(width: AppValues.innerMargin),
                                        Text(
                                          repeatConditionToDescription(
                                              routine.repeatCondition),
                                          style: PeepTextStyle.regularXS(
                                              color: Palette.peepBlack),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                      PeepRoutineToggleButton(
                        routine: routine,
                        controller: controller,
                      ),
                    ],
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
