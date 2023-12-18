
abstract class ReminderInterface {
  String alarmMessage="";

  Future<bool> isTimeToAlarm();
  String getAlarmMessage() {
    return alarmMessage;
  }
}