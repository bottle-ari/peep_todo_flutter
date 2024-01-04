import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/controllers/data/category_controller.dart';
import 'package:peep_todo_flutter/app/controllers/data/routine_controller.dart';
import 'package:peep_todo_flutter/app/data/enums/todo_enum.dart';
import 'package:peep_todo_flutter/app/data/model/category/category_model.dart';
import 'package:peep_todo_flutter/app/data/model/routine/routine_model.dart';
import 'package:uuid/uuid.dart';
import '../../core/base/base_controller.dart';
import 'selected_todo_controller.dart';

class RoutineManageController extends BaseController {
  final CategoryController _categoryController = Get.find();
  final RoutineController _routineController = Get.find();
  final SelectedTodoController selectedTodoController = Get.find();

  // Data
  final RxList<dynamic> routineList = <dynamic>[].obs;

  // Variables
  Map<String, List<int>> categoryIndexMap = <String, List<int>>{};

  @override
  void onInit() {
    super.onInit();

    ever(_routineController.routineList, (callback) {
      updateRoutineList();
    });

    ever(_categoryController.categoryList, (callback) => updateRoutineList());

    updateRoutineList();
  }

  /*
    Init Functions
   */
  void updateRoutineList() async {
    List<dynamic> newRoutineList = List<dynamic>.from(
        _categoryController.categoryList.where((element) =>
            (element.isActive == true && element.type == TodoType.scheduled)));

    initCategoryIndexMap(newRoutineList);

    for (var routine in _routineController.routineList) {
      if (categoryIndexMap[routine.categoryId] == null) continue;

      var inx = categoryIndexMap[routine.categoryId]![1]; // todo가 추가될 index

      if (inx >= newRoutineList.length) {
        newRoutineList.add(routine);
      } else {
        newRoutineList.insert(inx, routine);
      }

      updateCategoryIndexMap(inx);
      categoryIndexMap[routine.categoryId]?[1]++;
    }

    routineList.value = newRoutineList;
  }

  void initCategoryIndexMap(List<dynamic>? routineList) {
    routineList ??= this.routineList;

    Map<String, List<int>> newCategoryIndexMap = {};

    for (int i = 0; i < routineList.length; i++) {
      if (routineList[i] is CategoryModel) {
        newCategoryIndexMap[routineList[i].id] = [i, i + 1];
      } else {
        newCategoryIndexMap[routineList[i].categoryId]?[1]++;
      }
    }

    categoryIndexMap = newCategoryIndexMap;
  }

  void updateCategoryIndexMap(int index) {
    Map<String, List<int>> newCategoryIndexMap = {};

    for (var key in categoryIndexMap.keys) {
      if (categoryIndexMap[key] == null) {
        throw Exception('error in updateCategoryIndexMap');
      }

      if (categoryIndexMap[key]![0] >= index) {
        newCategoryIndexMap[key] = [
          categoryIndexMap[key]![0] + 1,
          categoryIndexMap[key]![1] + 1
        ];
      } else {
        newCategoryIndexMap[key] = [
          categoryIndexMap[key]![0],
          categoryIndexMap[key]![1]
        ];
      }
    }

    categoryIndexMap = newCategoryIndexMap;
  }

  /*
    Create Function
   */
  void addNewRoutine({required String categoryId}) {
    final newRoutinePos = categoryIndexMap[categoryId]![1];

    var uuid = const Uuid();
    var newRoutineId = uuid.v4();

    List<dynamic> newRoutineList = List<dynamic>.from(routineList);

    RoutineModel newRoutine = RoutineModel(
        id: newRoutineId,
        categoryId: categoryId,
        name: "name",
        isActive: true,
        priority: 0,
        repeatCondition: "repeatCondition",
        pos: newRoutinePos);

    _routineController.addRoutine(routine: newRoutine);

    initCategoryIndexMap(newRoutineList);
    routineList.value = newRoutineList;

    update();
  }

  /*
    Read Function
   */
  Color getColor({required String todoId}) {
    var categoryId = _routineController.routineList
        .firstWhere((e) => e.id == todoId)
        .categoryId;

    return _categoryController.categoryList
        .firstWhere((e) => e.id == categoryId)
        .color;
  }

  Color getColorByCategory({required RoutineModel item}) {
    CategoryModel category =
        _categoryController.getCategoryById(categoryId: item.categoryId);

    return category.color;
  }

/*
    Update Function
   */
}
