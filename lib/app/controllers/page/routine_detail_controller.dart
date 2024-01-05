import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/data/category_controller.dart';
import 'package:peep_todo_flutter/app/controllers/data/palette_controller.dart';
import 'package:peep_todo_flutter/app/controllers/data/routine_controller.dart';
import 'package:peep_todo_flutter/app/core/base/base_controller.dart';
import 'package:peep_todo_flutter/app/data/enums/todo_enum.dart';
import 'package:peep_todo_flutter/app/data/model/routine/routine_model.dart';
import 'package:peep_todo_flutter/app/views/routine/widget/peep_repeat_condition_picker.dart';
import '../../data/model/category/category_model.dart';
import '../animation/peep_category_toggle_button_controller.dart';

class RoutineDetailController extends BaseController {
  final PaletteController paletteController = Get.find();
  final RoutineController _routineController = Get.find();
  final CategoryController _categoryController = Get.find();
  final PeepCategoryToggleButtonController _animationController =
  Get.find(tag: Get.arguments['routine_id']);

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
    color: 0,
    emoji: '',
    type: TodoType.scheduled,
    isActive: true,
    pos: -1,
  ).obs;

  final String routineId = Get.arguments['routine_id'];
  final Rx<RoutineModel> routine = RoutineModel(
    id: 'default',
    categoryId: 'default',
    name: '',
    isActive: false,
    priority: 0,
    repeatCondition: '',
    pos: -1,
  ).obs;

  @override
  void onInit() {
    super.onInit();
    Get.put(peepRepeatConditionPickerController);
    loadCategory();
    loadRoutine();
  }

  @override
  void onClose() {
    // 변경된 루틴 정보 저장
    onConfirm(routine.value.repeatCondition.split(' ')[1]);
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

  void loadRoutine() {
    routine.value = _routineController.getRoutineById(routineId: routineId);

    textEditingController.text = routine.value.name;
    isActive.value = routine.value.isActive;
    priority.value = routine.value.priority;
    // routine 의 repeatCondition 파싱하여, peepRepeatConditionPickerController 변수들 init
    peepRepeatConditionPickerController
        .initValuesFromSubRepeatCondition(routine.value.repeatCondition);
  }

  /*
    Read Functions
   */
  Color getColor() {
    return paletteController.getDefaultPalette()[category.value.color].color;
  }

  /*
    Update Functions
   */

  void toggleActiveState() {
    isActive.value = !isActive.value;
    _animationController.toggleAnimation();
  }

  // 루틴 상세 페이지에서 나갈 시, 변경된 내용을 저장하는 함수, onClose() 내부에서 동작
  bool onConfirm(String startDate) {
    // 루틴 name이 empty string 이라면, 변경 내용 저장되지 않음
    if (textEditingController.text == '') {
      return false;
    }

    // repeatCondition 가져오기 from peepRepeatConditionPickerController
    String subRepeatCondition =
        peepRepeatConditionPickerController.subRepeatCondition.value;
    String endDate = "";
    if (peepRepeatConditionPickerController.endIsChecked.value) {
      endDate = peepRepeatConditionPickerController.endDate.value;
    }

    String repeatCondition = "$subRepeatCondition $startDate $endDate";

    RoutineModel newRoutine = RoutineModel(
      id: routineId,
      categoryId: category.value.id,
      name: textEditingController.text,
      isActive: isActive.value,
      priority: priority.value,
      repeatCondition: repeatCondition,
      pos: routine.value.pos,
    );

    _routineController.updateRoutine(newRoutine);
    return true;
  }

  void deleteRoutine() {
    _routineController.deleteRoutine(routine: routine.value);
  }
}
