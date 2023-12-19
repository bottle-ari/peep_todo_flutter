import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/data/routine_controller.dart';
import 'package:peep_todo_flutter/app/controllers/page/routine_manage_controller.dart';
import 'package:peep_todo_flutter/app/data/model/routine/routine_model.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/common/popup/peep_confirm_popup.dart';

import '../../../controllers/data/todo_controller.dart';
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
                backgroundColor: Palette.peepRed,
                foregroundColor: Colors.white,
                label: '삭제',
              ),
            ],
          ),
          child: InkWell(
            onTap: onTap,
            child: Container(
              width: AppValues.screenWidth - AppValues.screenPadding * 2,
              height: AppValues.largeItemHeight,
              color:
              routine.isActive ? Palette.peepWhite : Palette.peepGray100,
              child: Padding(
                padding:
                EdgeInsets.symmetric(horizontal: AppValues.horizontalMargin),
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
                        if(routine.isActive)
                          Text(
                            // Todo : text 길이 조절
                            routine.name.length > 9
                                ? "${routine.name.substring(0, 9)}..."
                                : routine.name,
                            style: PeepTextStyle.regularM(color: Palette.peepBlack),
                          )
                        else
                          ColorFiltered(
                            colorFilter: const ColorFilter.matrix([
                              0.2126, 0.7152, 0.0722, 0, 0,
                              0.2126, 0.7152, 0.0722, 0, 0,
                              0.2126, 0.7152, 0.0722, 0, 0,
                              0,      0,      0,      1, 0,
                            ]),
                            child: Text(
                              // Todo : text 길이 조절
                              routine.name.length > 9
                                  ? "${routine.name.substring(0, 9)}..."
                                  : routine.name,
                              style: PeepTextStyle.regularM(color: Palette.peepBlack),
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
    );
  }
}
