
import 'package:peep_todo_flutter/app/utils/reminder_utils/location/location_reminder.dart';
import 'package:peep_todo_flutter/app/utils/reminder_utils/reminder_interface.dart';
import 'dart:convert';

import 'wifi/wifi_reminder.dart';

class ReminderChecker {
  static Future<bool> isReminderTime(String reminderJson) async {
    Map<String, dynamic> reminderMap = jsonDecode(reminderJson);
    for (var key in reminderMap.keys) {
      late ReminderInterface checkReminder;
      // 나중에 key들은 enum으로 뺄 것
      if (key == "pos") {
        var value = reminderMap[key];
        var langtitude = double.parse(value["langtitude"]);
        var longtitude = double.parse(value["longtitude"]);
        var locationReminder = LocationReminder(langtitude, longtitude, 1000.0); // 1000M
        checkReminder = locationReminder;
      } else if (key == "time") {
        // code20231218154553
      } else if (key == "wifi") {
        var value = reminderMap[key];
        var wifiName = value["wifi_name"];
        var wifiReminder = WifiReminder(wifiName);
        checkReminder = wifiReminder;
      } else {
        throw Exception("잘못된 reminder key");
      }
      
      // 하나의 조건이라도 어긋나면 False
      bool isOk = await checkReminder.isTimeToAlarm();
      if (!isOk) {
        return false;
      }
    }
    return true;
  }
}