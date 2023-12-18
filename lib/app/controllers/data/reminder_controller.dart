

import 'package:get/get.dart';
// 백업은 나중에
// import 'package:peep_todo_flutter/app/data/model/reminder/backup_reminder_model.dart';
import 'package:peep_todo_flutter/app/data/model/reminder/reminder_model.dart';
import 'package:peep_todo_flutter/app/data/services/reminder_service.dart';

import '../../core/base/base_controller.dart';

class ReminderController extends BaseController {
  final ReminderService _service = ReminderService();

  // Data
  final RxList<ReminderModel> reminderList = <ReminderModel>[].obs;

  // Variables
  // 백업은 나중에
  // BackupReminderModel? backup;

  @override
  void onInit() {
    super.onInit();
    loadReminderData();
  }

  /*
    Init Functions
   */
  void loadReminderData() async {
    var data = await _service.getReminderAll();
    reminderList.value = data;
  }

  /*
    Create Functions
   */
  void addReminder({required ReminderModel reminder}) async {
    await _service.insertReminder(reminder: reminder);

    loadReminderData();
  }

  // 백업은 나중에
  // void rollbackReminder() async {
  //   if (backup == null) return;
  //
  //   await _service.insertReminder(reminder: backup!.backupReminderItem);
  //
  //   loadReminderData();
  // }

  /*
    Read Functions
   */
  ReminderModel getReminderById({required String reminderId}) {
    return reminderList.firstWhere((element) => element.id == reminderId);
  }

  /*
    Update Functions
   */
  void reorderReminderList(int oldIndex, int newIndex) async {
    if (oldIndex == newIndex) return;

    var list = reminderList;
    final ReminderModel reminderItem = list.removeAt(oldIndex);

    list.insert(newIndex, reminderItem);
    reminderList.value = List.from(list);

    int newPos = 0;
    for (var reminder in reminderList) {
      reminder.pos = newPos;
      newPos++;
    }

    await _service.updateReminders(reminderList);

    update();
  }

 
  /*
    Delete Functions
   */
  Future<void> deleteReminder({required ReminderModel reminder}) async {
    await _service.deleteReminder(reminder.id);

    // 나중에 백업 구현
    // backup = BackupReminderModel(
    //     backupReminderItem: reminder, backupIndex: reminder.pos);

    loadReminderData();
  }
}
