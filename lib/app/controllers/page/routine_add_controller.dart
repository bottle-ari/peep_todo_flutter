import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:peep_todo_flutter/app/controllers/data/category_controller.dart';
import 'package:peep_todo_flutter/app/controllers/data/routine_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_controller.dart';
import 'package:peep_todo_flutter/app/data/enums/todo_enum.dart';
import 'package:peep_todo_flutter/app/data/model/routine/routine_model.dart';
import 'package:peep_todo_flutter/app/views/routine/widget/peep_repeat_condition_picker.dart';
import 'package:uuid/uuid.dart';
import '../../data/model/category/category_model.dart';

class RoutineAddController extends BaseController {
  final RoutineController _routineController = Get.find();
  final CategoryController _categoryController = Get.find();

  final PeepRepeatConditionPickerController
      peepRepeatConditionPickerController =
      PeepRepeatConditionPickerController();
  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  final RxBool isActive = true.obs;
  final RxInt priority = 0.obs;
  final String categoryId = Get.arguments['category_id'];
  final Rx<CategoryModel> category = CategoryModel(
    id: 'default',
    name: '',
    color: Colors.black,
    emoji: '',
    type: TodoType.scheduled,
    isActive: true,
    pos: -1,
  ).obs;

  @override
  void onInit() {
    super.onInit();
    Get.put(peepRepeatConditionPickerController);
    loadCategory();
  }

  @override
  void onClose() {
    focusNode.dispose();
    textEditingController.dispose();
    super.onClose();
  }

  /*
    Init Functions
   */

  void loadCategory() {
    category.value =
        _categoryController.getCategoryById(categoryId: categoryId);
  }

  /*
    Update Functions
   */

  void toggleActiveState() {
    isActive.value = !isActive.value;
  }

  bool onConfirm() {
    if (textEditingController.text == '') {
      return false;
    }
    // uuid 생성
    var uuid = const Uuid();
    String newUuid = uuid.v4();

    // lastPos 가져오기
    int lastPos = _routineController.routineList.length;

    // repeatCondition 가져오기 from peepRepeatConditionPickerController
    String subRepeatCondition =
        peepRepeatConditionPickerController.subRepeatCondition.value;
    String startDate = DateFormat("yyyy/MM/dd").format(DateTime.now());
    String endDate = "";
    if (peepRepeatConditionPickerController.endIsChecked.value) {
      endDate = peepRepeatConditionPickerController.endDate.value;
    }

    String repeatCondition = "$subRepeatCondition $startDate $endDate";

    RoutineModel newRoutine = RoutineModel(
      id: newUuid,
      categoryId: category.value.id,
      name: textEditingController.text,
      isActive: isActive.value,
      // Todo : priority 데이터 받아서 넣기
      priority: priority.value,
      repeatCondition: repeatCondition,
      pos: lastPos,
    );

    _routineController.addRoutine(routine: newRoutine);
    return true;
  }
}
