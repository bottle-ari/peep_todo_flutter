
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/data/model/routine/routine_model.dart';
import 'package:peep_todo_flutter/app/data/services/routine_service.dart';
import '../../core/base/base_controller.dart';

class RoutineController extends BaseController {
  final RoutineService _service = RoutineService();

  // Data
  final RxList<RoutineModel> routineList = <RoutineModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadRoutineData();
  }

  /*
    Init Functions
   */
  void loadRoutineData() async {
    var data = await _service.getRoutineAll();
    routineList.value = data;
  }

  /*
    Create Functions
   */
  void addRoutine({required RoutineModel routine}) async {
    await _service.insertRoutine(routine: routine);

    loadRoutineData();
  }

  /*
    Read Functions
   */
  RoutineModel getRoutineById({required String routineId}) {
    return routineList.firstWhere((element) => element.id == routineId);
  }

  /*
    Update Functions
   */
  void reorderRoutineList(int oldIndex, int newIndex) async {
    if (oldIndex == newIndex) return;

    var list = routineList;
    final RoutineModel routineItem = list.removeAt(oldIndex);

    list.insert(newIndex, routineItem);
    routineList.value = List.from(list);

    int newPos = 0;
    for (var routine in routineList) {
      routine.pos = newPos;
      newPos++;
    }

    await _service.updateRoutines(routineList);

    update();
  }

  void updateCategoryId(String routineId, String newCategoryId) async {
    RoutineModel routine = routineList.firstWhere((e) => e.id == routineId);

    routine.categoryId = newCategoryId;
    await _service.updateRoutine(routine);

    loadRoutineData();
  }

  void updateName(String routineId, String newName) async {
    RoutineModel routine = routineList.firstWhere((e) => e.id == routineId);

    routine.name = newName;
    await _service.updateRoutine(routine);

    loadRoutineData();
  }

  Future<bool> toggleActiveState(String routineId) async {
    RoutineModel routine = routineList.firstWhere((e) => e.id == routineId);

    routine.isActive = !routine.isActive;
    await _service.updateRoutine(routine);

    loadRoutineData();
    return true;
  }

  void updatePriority(String routineId, int newPriority) async {
    RoutineModel routine = routineList.firstWhere((e) => e.id == routineId);

    routine.priority = newPriority;
    await _service.updateRoutine(routine);

    loadRoutineData();
  }

  void updateRepeatCondition(String routineId, String newRepeatCondition) async {
    RoutineModel routine = routineList.firstWhere((e) => e.id == routineId);

    routine.repeatCondition = newRepeatCondition;
    await _service.updateRoutine(routine);

    loadRoutineData();
  }

  void updateRoutine(RoutineModel newRoutine) async {
    await _service.updateRoutine(newRoutine);

    loadRoutineData();
  }

  /*
    Delete Functions
   */
  Future<void> deleteRoutine({required RoutineModel routine}) async {
    await _service.deleteRoutine(routine.id);

    // backup = BackupRoutineModel(
    //     backupRoutineItem: routine, backupIndex: routine.pos);

    loadRoutineData();
  }
}
