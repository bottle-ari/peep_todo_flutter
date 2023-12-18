import 'dart:developer';

import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/data/model/reminder/reminder_model.dart';
import 'package:peep_todo_flutter/app/data/provider/database/reminder_provider.dart';

class ReminderService extends GetxService {
  final ReminderProvider _provider = ReminderProvider();

  /*
    CREATE DATA
   */
  Future<void> insertReminder({required ReminderModel reminder}) async {
    Map<String, Object?> reminderMap = reminder.toMap();
    await _provider.insertReminder(reminderMap);
  }

  /*
    READ DATA
   */
  Future<List<ReminderModel>> getReminderAll() async {
    final List<Map<String, dynamic>> reminderMaps =
        await _provider.getReminderAll();

    return reminderMaps.map((e) => ReminderModel.fromMap(e)).toList();
  }

  Future<ReminderModel> getReminderById({required String reminderId}) async {
    final Map<String, dynamic> reminder = await _provider.getReminderById(reminderId: reminderId);

    return ReminderModel.fromMap(reminder);
  }

  /*
    UPDATE DATA
   */
  Future<void> updateReminder(ReminderModel reminder) async {
    var row = await _provider.updateReminder(reminder.toMap());

    log("delete $row rows.");
  }

  Future<void> updateReminders(List<ReminderModel> reminderList) async {
    var row = await _provider.updateReminders(reminderList.map((e) => e.toMap()).toList());

    log("delete $row rows.");
  }

  /*
    DELETE DATA
   */
  Future<void> deleteReminder(String reminderId) async {
    var row = await _provider.deleteReminder(reminderId);

    log("delete $row rows.");
  }
}
