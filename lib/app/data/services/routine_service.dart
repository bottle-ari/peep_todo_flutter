import 'dart:developer';

import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/data/model/routine/routine_model.dart';
import 'package:peep_todo_flutter/app/data/provider/database/routine_provider.dart';

class RoutineService extends GetxService {
  final RoutineProvider _provider = RoutineProvider();

  /*
    CREATE DATA
   */
  Future<void> insertRoutine({required RoutineModel routine}) async {
    Map<String, Object?> routineMap = routine.toMap();
    await _provider.insertRoutine(routineMap);
  }

  /*
    READ DATA
   */
  Future<List<RoutineModel>> getRoutineAll() async {
    final List<Map<String, dynamic>> routineMaps =
    await _provider.getRoutineAll();

    return routineMaps.map((e) => RoutineModel.fromMap(e)).toList();
  }

  Future<RoutineModel> getRoutineById({required String routineId}) async {
    final Map<String, dynamic> routine = await _provider.getRoutineById(routineId: routineId);

    return RoutineModel.fromMap(routine);
  }

  /*
    UPDATE DATA
   */
  Future<void> updateRoutine(RoutineModel routine) async {
    var row = await _provider.updateRoutine(routine.toMap());

    log("update $row rows.");
  }

  Future<void> updateRoutines(List<RoutineModel> routineList) async {
    var row = await _provider.updateRoutines(routineList.map((e) => e.toMap()).toList());

    log("update $row rows.");
  }

  /*
    DELETE DATA
   */
  Future<void> deleteRoutine(String routineId) async {
    var row = await _provider.deleteRoutine(routineId);

    log("delete $row rows.");
  }
}
