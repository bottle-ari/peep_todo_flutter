import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/modal/todo_add_controller.dart';
import 'package:peep_todo_flutter/app/controllers/todo_controller.dart';
import 'package:peep_todo_flutter/app/data/enums/todo_enum.dart';
import 'package:peep_todo_flutter/app/data/model/category/category_model.dart';
import 'package:peep_todo_flutter/app/data/model/todo/todo_model.dart';
import 'package:peep_todo_flutter/app/theme/app_values.dart';
import 'package:peep_todo_flutter/app/theme/icons.dart';
import 'package:peep_todo_flutter/app/theme/palette.dart';
import 'package:peep_todo_flutter/app/theme/text_style.dart';
import 'package:peep_todo_flutter/app/views/todo/page/priority_picker_modal.dart';
import 'package:peep_todo_flutter/app/views/todo/widget/peep_button_textfield.dart';
import 'package:uuid/uuid.dart';

class TodoAddModal extends StatelessWidget {
  final CategoryModel category;
  final TodoType type;
  final int pos;

  const TodoAddModal(
      {super.key,
      required this.category,
      required this.pos,
      required this.type});

  @override
  Widget build(BuildContext context) {
    final TodoController controller = Get.find();
    final TodoAddController todoAddController = TodoAddController();

    return Container(
      decoration: BoxDecoration(
        color: Palette.peepWhite,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(AppValues.baseRadius),
            topLeft: Radius.circular(AppValues.baseRadius)),
      ),
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: AppValues.verticalMargin,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: AppValues.verticalMargin),
                child: Text(
                  'Todo 추가하기',
                  style: PeepTextStyle.boldL(color: Palette.peepGray400),
                ),
              ),
            ),
            Obx(
              () => PeepTodoTextfield(
                  icon: PeepIcon(
                    Iconsax.eggCracked,
                    color: todoAddController.priority.value.PriorityColor,
                    size: AppValues.baseIconSize,
                  ),
                  color: category.color,
                  onTapPriority: () {
                    Get.bottomSheet(
                      PriorityPickerModal(
                        controller: todoAddController,
                      ),
                    );
                  },
                  onTapAddButton: (String str) {
                    // UUID 생성
                    var uuid = const Uuid();
                    String newUuid = uuid.v4();

                    // 할 일 추가
                    controller.addTodo(
                        todo: TodoModel(
                            id: newUuid,
                            categoryId: category.id,
                            reminderId: null,
                            name: str,
                            subTodo: [],
                            date: controller.selectedDate.value,
                            priority: todoAddController.priority.value.index,
                            memo: '',
                            isFold: false,
                            isChecked: false,
                            pos: pos));
                    controller.loadData(type);

                    //TODO 위치 및 위젯 조정 필요.
                    Get.snackbar('', str + ' 추가되었습니다!');
                  }),
            ),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
      ),
    );
  }
}
