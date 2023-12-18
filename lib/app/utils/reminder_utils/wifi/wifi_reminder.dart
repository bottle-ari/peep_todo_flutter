

import 'package:peep_todo_flutter/app/utils/reminder_utils/reminder_interface.dart';
import 'package:peep_todo_flutter/app/utils/reminder_utils/wifi/wifi_info.dart';

class WifiReminder implements ReminderInterface {

  @override
  String alarmMessage="와이파이 연결됨";
  String wifiName = "";

  WifiReminder(this.wifiName);

  @override
  String getAlarmMessage() {
    return alarmMessage;
  }

  @override
  Future<bool> isTimeToAlarm() async {
    // 일단은 현재 와이파이 이름이 동일하면 알람 뜨게
    var currentWifi = await WifiInfo.getCurrentWifiInfo();
    var currentWifiName = currentWifi.wifiName;
    if (wifiName == currentWifiName)  {
      return true;
    }
    return false;
  }
}